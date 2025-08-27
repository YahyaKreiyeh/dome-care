import 'package:freezed_annotation/freezed_annotation.dart';

part 'result.freezed.dart';

@freezed
sealed class Result<T> with _$Result<T> {
  const factory Result.empty() = Empty<T>;
  const factory Result.loading() = Loading<T>;
  const factory Result.success({required T data}) = Success<T>;
  const factory Result.failure({
    required Exception error,
    T? data,
    String? errorMessage,
  }) = Failure<T>;
}

extension ResultX<T> on Result<T> {
  bool get isSuccess => switch (this) {
    Success() => true,
    _ => false,
  };

  bool get isLoading => switch (this) {
    Loading() => true,
    _ => false,
  };

  bool get isFailure => switch (this) {
    Failure() => true,
    _ => false,
  };

  T? get successValue => switch (this) {
    Success(data: final d) => d,
    _ => null,
  };

  T? get failureValue => switch (this) {
    Failure(data: final d) => d,
    _ => null,
  };

  String? get failureMessage => switch (this) {
    Failure(errorMessage: final m) => m,
    _ => null,
  };
}
