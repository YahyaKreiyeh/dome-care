import 'dart:async';

import 'package:dio/dio.dart';
import 'package:dome_care/core/constants/constants.dart';
import 'package:dome_care/core/helpers/shared_pref_helper.dart';
import 'package:dome_care/core/routing/routes.dart';
import 'package:dome_care/dome_care.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class DioFactory {
  DioFactory._();
  static Dio? _dio;

  static bool _isRefreshing = false;
  static final List<Queued> _queue = [];

  static Future<Dio> getDio() async {
    if (_dio != null) return _dio!;
    final dio = Dio()
      ..options.connectTimeout = const Duration(seconds: 30)
      ..options.receiveTimeout = const Duration(seconds: 30);
    _addInterceptors(dio);
    assert(() {
      dio.interceptors.add(
        PrettyDioLogger(
          requestBody: true,
          requestHeader: true,
          responseHeader: true,
        ),
      );
      return true;
    }());
    _dio = dio;
    return _dio!;
  }

  static void _addInterceptors(Dio dio) {
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (opts, handler) async {
          final t = await SharedPrefHelper.getSecuredString(
            SharedPrefKeys.userToken,
          );
          if (t.isNotEmpty) {
            opts.headers['Authorization'] = 'Bearer $t';
          } else {
            opts.headers.remove('Authorization');
          }
          opts.headers['content-type'] = 'application/json';
          opts.headers['Accept-Language'] = 'ar_SY';
          handler.next(opts);
        },
        onError: (err, handler) async {
          final alreadyRetried = err.requestOptions.extra['__ret'] == true;
          if (_looksLikeAuthFailure(err.response) && !alreadyRetried) {
            final c = Completer<Response<dynamic>>();
            _queue.add(Queued(err.requestOptions, c));

            if (!_isRefreshing) {
              _isRefreshing = true;
              final ok = await _tryRefreshToken();
              _isRefreshing = false;

              final items = List<Queued>.from(_queue);
              _queue.clear();

              if (ok) {
                for (final q in items) {
                  _retryRequest(
                    dio,
                    q.ro,
                  ).then(q.c.complete, onError: q.c.completeError);
                }
              } else {
                for (final q in items) {
                  q.c.completeError(err);
                }
                _forceLogoutToLogin();
              }
            }
            final result = await c.future;
            return handler.resolve(result);
          }
          handler.next(err);
        },
      ),
    );
  }

  static Future<Response<dynamic>> _retryRequest(Dio dio, RequestOptions ro) {
    final opts = Options(
      method: ro.method,
      headers: Map<String, dynamic>.from(ro.headers),
      responseType: ro.responseType,
      contentType: ro.contentType,
      sendTimeout: ro.sendTimeout,
      receiveTimeout: ro.receiveTimeout,
      followRedirects: ro.followRedirects,
      receiveDataWhenStatusError: ro.receiveDataWhenStatusError,
      extra: Map<String, dynamic>.from(ro.extra)..['__ret'] = true,
    );
    return dio.request<dynamic>(
      ro.path,
      data: ro.data,
      queryParameters: ro.queryParameters,
      options: opts,
      cancelToken: ro.cancelToken,
      onSendProgress: ro.onSendProgress,
      onReceiveProgress: ro.onReceiveProgress,
    );
  }

  static Future<bool> _tryRefreshToken() async {
    try {
      final refresh = await SharedPrefHelper.getSecuredString(
        SharedPrefKeys.refreshToken,
      );
      if (refresh.isEmpty) return false;

      final bare = Dio()
        ..options = BaseOptions(
          baseUrl: 'https://dummyjson.com',
          connectTimeout: const Duration(seconds: 15),
          receiveTimeout: const Duration(seconds: 15),
          headers: {'content-type': 'application/json'},
        );

      final resp = await bare.post(
        '/auth/refresh',
        data: {'refreshToken': refresh, 'expiresInMins': 30},
      );

      if (resp.statusCode == 200 && resp.data is Map) {
        final map = resp.data as Map;
        final newAccess = (map['accessToken'] ?? map['token']) as String?;
        final newRefresh = map['refreshToken'] as String?;
        if (newAccess == null || newAccess.isEmpty) return false;

        await SharedPrefHelper.setSecuredString(
          SharedPrefKeys.userToken,
          newAccess,
        );
        if (newRefresh != null && newRefresh.isNotEmpty) {
          await SharedPrefHelper.setSecuredString(
            SharedPrefKeys.refreshToken,
            newRefresh,
          );
        }
        return true;
      }
      return false;
    } catch (_) {
      return false;
    }
  }

  static Future<void> _forceLogoutToLogin() async {
    await SharedPrefHelper.deleteSecured(SharedPrefKeys.userToken);
    await SharedPrefHelper.deleteSecured(SharedPrefKeys.refreshToken);
    Future.microtask(() {
      final nav = navigatorKey.currentState;
      if (nav == null) return;
      nav.pushNamedAndRemoveUntil(Routes.login, (r) => false);
    });
  }

  static bool _looksLikeAuthFailure(Response? r) {
    final code = r?.statusCode ?? 0;
    if (code == 401 || code == 403) return true;
    if (code == 500) {
      final msg = (r?.data is Map ? r?.data['message'] : null)
          ?.toString()
          .toLowerCase();
      if (msg != null) {
        return msg.contains('invalid signature') ||
            msg.contains('jwt expired') ||
            (msg.contains('token') && msg.contains('invalid'));
      }
    }
    return false;
  }

  static Future<void> updateToken(String token) async {
    _dio?.options.headers['Authorization'] = 'Bearer $token';
  }
}

class Queued {
  Queued(this.ro, this.c);
  final RequestOptions ro;
  final Completer<Response<dynamic>> c;
}
