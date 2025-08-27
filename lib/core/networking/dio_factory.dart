import 'package:dio/dio.dart';
import 'package:dome_care/core/constants/constants.dart';
import 'package:dome_care/core/helpers/shared_pref_helper.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class DioFactory {
  DioFactory._();
  static Dio? _dio;

  static Future<Dio> getDio() async {
    if (_dio != null) return _dio!;
    final dio = Dio()
      ..options.connectTimeout = const Duration(seconds: 30)
      ..options.receiveTimeout = const Duration(seconds: 30);
    _dio = dio;
    await _addDioHeaders();
    _addDioInterceptor();
    return _dio!;
  }

  static Future<void> _addDioHeaders() async {
    final token = await SharedPrefHelper.getSecuredString(
      SharedPrefKeys.userToken,
    );
    _dio?.options.headers = {
      'content-type': 'application/json',
      'Accept-Language': 'ar_SY',
      'Authorization': token,
    };
    if (token.isNotEmpty) {
      _dio?.options.headers['Authorization'] = token;
    }
  }

  static void _addDioInterceptor() {
    _dio?.interceptors.add(
      PrettyDioLogger(
        requestBody: true,
        requestHeader: true,
        responseHeader: true,
      ),
    );
  }

  static Future<void> updateToken(String token) async {
    _dio?.options.headers['Authorization'] = token;
  }
}
