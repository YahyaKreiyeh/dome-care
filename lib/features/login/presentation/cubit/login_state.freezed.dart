// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'login_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$LoginState {

 Result get status; String get phone; String? get phoneError; String get password; String? get passwordError; bool get isPasswordObscured;
/// Create a copy of LoginState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LoginStateCopyWith<LoginState> get copyWith => _$LoginStateCopyWithImpl<LoginState>(this as LoginState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LoginState&&(identical(other.status, status) || other.status == status)&&(identical(other.phone, phone) || other.phone == phone)&&(identical(other.phoneError, phoneError) || other.phoneError == phoneError)&&(identical(other.password, password) || other.password == password)&&(identical(other.passwordError, passwordError) || other.passwordError == passwordError)&&(identical(other.isPasswordObscured, isPasswordObscured) || other.isPasswordObscured == isPasswordObscured));
}


@override
int get hashCode => Object.hash(runtimeType,status,phone,phoneError,password,passwordError,isPasswordObscured);

@override
String toString() {
  return 'LoginState(status: $status, phone: $phone, phoneError: $phoneError, password: $password, passwordError: $passwordError, isPasswordObscured: $isPasswordObscured)';
}


}

/// @nodoc
abstract mixin class $LoginStateCopyWith<$Res>  {
  factory $LoginStateCopyWith(LoginState value, $Res Function(LoginState) _then) = _$LoginStateCopyWithImpl;
@useResult
$Res call({
 Result status, String phone, String? phoneError, String password, String? passwordError, bool isPasswordObscured
});


$ResultCopyWith<dynamic, $Res> get status;

}
/// @nodoc
class _$LoginStateCopyWithImpl<$Res>
    implements $LoginStateCopyWith<$Res> {
  _$LoginStateCopyWithImpl(this._self, this._then);

  final LoginState _self;
  final $Res Function(LoginState) _then;

/// Create a copy of LoginState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? phone = null,Object? phoneError = freezed,Object? password = null,Object? passwordError = freezed,Object? isPasswordObscured = null,}) {
  return _then(_self.copyWith(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as Result,phone: null == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String,phoneError: freezed == phoneError ? _self.phoneError : phoneError // ignore: cast_nullable_to_non_nullable
as String?,password: null == password ? _self.password : password // ignore: cast_nullable_to_non_nullable
as String,passwordError: freezed == passwordError ? _self.passwordError : passwordError // ignore: cast_nullable_to_non_nullable
as String?,isPasswordObscured: null == isPasswordObscured ? _self.isPasswordObscured : isPasswordObscured // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}
/// Create a copy of LoginState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ResultCopyWith<dynamic, $Res> get status {
  
  return $ResultCopyWith<dynamic, $Res>(_self.status, (value) {
    return _then(_self.copyWith(status: value));
  });
}
}


/// Adds pattern-matching-related methods to [LoginState].
extension LoginStatePatterns on LoginState {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LoginState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LoginState() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LoginState value)  $default,){
final _that = this;
switch (_that) {
case _LoginState():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LoginState value)?  $default,){
final _that = this;
switch (_that) {
case _LoginState() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( Result status,  String phone,  String? phoneError,  String password,  String? passwordError,  bool isPasswordObscured)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LoginState() when $default != null:
return $default(_that.status,_that.phone,_that.phoneError,_that.password,_that.passwordError,_that.isPasswordObscured);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( Result status,  String phone,  String? phoneError,  String password,  String? passwordError,  bool isPasswordObscured)  $default,) {final _that = this;
switch (_that) {
case _LoginState():
return $default(_that.status,_that.phone,_that.phoneError,_that.password,_that.passwordError,_that.isPasswordObscured);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( Result status,  String phone,  String? phoneError,  String password,  String? passwordError,  bool isPasswordObscured)?  $default,) {final _that = this;
switch (_that) {
case _LoginState() when $default != null:
return $default(_that.status,_that.phone,_that.phoneError,_that.password,_that.passwordError,_that.isPasswordObscured);case _:
  return null;

}
}

}

/// @nodoc


class _LoginState implements LoginState {
  const _LoginState({this.status = const Result.empty(), this.phone = '', this.phoneError, this.password = '', this.passwordError, this.isPasswordObscured = true});
  

@override@JsonKey() final  Result status;
@override@JsonKey() final  String phone;
@override final  String? phoneError;
@override@JsonKey() final  String password;
@override final  String? passwordError;
@override@JsonKey() final  bool isPasswordObscured;

/// Create a copy of LoginState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LoginStateCopyWith<_LoginState> get copyWith => __$LoginStateCopyWithImpl<_LoginState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LoginState&&(identical(other.status, status) || other.status == status)&&(identical(other.phone, phone) || other.phone == phone)&&(identical(other.phoneError, phoneError) || other.phoneError == phoneError)&&(identical(other.password, password) || other.password == password)&&(identical(other.passwordError, passwordError) || other.passwordError == passwordError)&&(identical(other.isPasswordObscured, isPasswordObscured) || other.isPasswordObscured == isPasswordObscured));
}


@override
int get hashCode => Object.hash(runtimeType,status,phone,phoneError,password,passwordError,isPasswordObscured);

@override
String toString() {
  return 'LoginState(status: $status, phone: $phone, phoneError: $phoneError, password: $password, passwordError: $passwordError, isPasswordObscured: $isPasswordObscured)';
}


}

/// @nodoc
abstract mixin class _$LoginStateCopyWith<$Res> implements $LoginStateCopyWith<$Res> {
  factory _$LoginStateCopyWith(_LoginState value, $Res Function(_LoginState) _then) = __$LoginStateCopyWithImpl;
@override @useResult
$Res call({
 Result status, String phone, String? phoneError, String password, String? passwordError, bool isPasswordObscured
});


@override $ResultCopyWith<dynamic, $Res> get status;

}
/// @nodoc
class __$LoginStateCopyWithImpl<$Res>
    implements _$LoginStateCopyWith<$Res> {
  __$LoginStateCopyWithImpl(this._self, this._then);

  final _LoginState _self;
  final $Res Function(_LoginState) _then;

/// Create a copy of LoginState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? phone = null,Object? phoneError = freezed,Object? password = null,Object? passwordError = freezed,Object? isPasswordObscured = null,}) {
  return _then(_LoginState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as Result,phone: null == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String,phoneError: freezed == phoneError ? _self.phoneError : phoneError // ignore: cast_nullable_to_non_nullable
as String?,password: null == password ? _self.password : password // ignore: cast_nullable_to_non_nullable
as String,passwordError: freezed == passwordError ? _self.passwordError : passwordError // ignore: cast_nullable_to_non_nullable
as String?,isPasswordObscured: null == isPasswordObscured ? _self.isPasswordObscured : isPasswordObscured // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

/// Create a copy of LoginState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ResultCopyWith<dynamic, $Res> get status {
  
  return $ResultCopyWith<dynamic, $Res>(_self.status, (value) {
    return _then(_self.copyWith(status: value));
  });
}
}

// dart format on
