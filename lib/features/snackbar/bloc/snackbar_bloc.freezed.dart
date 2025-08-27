// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'snackbar_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SnackbarItem {

 String get id; Key? get key; String get content; SnackbarType get type;
/// Create a copy of SnackbarItem
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SnackbarItemCopyWith<SnackbarItem> get copyWith => _$SnackbarItemCopyWithImpl<SnackbarItem>(this as SnackbarItem, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SnackbarItem&&(identical(other.id, id) || other.id == id)&&(identical(other.key, key) || other.key == key)&&(identical(other.content, content) || other.content == content)&&(identical(other.type, type) || other.type == type));
}


@override
int get hashCode => Object.hash(runtimeType,id,key,content,type);

@override
String toString() {
  return 'SnackbarItem(id: $id, key: $key, content: $content, type: $type)';
}


}

/// @nodoc
abstract mixin class $SnackbarItemCopyWith<$Res>  {
  factory $SnackbarItemCopyWith(SnackbarItem value, $Res Function(SnackbarItem) _then) = _$SnackbarItemCopyWithImpl;
@useResult
$Res call({
 String id, Key? key, String content, SnackbarType type
});




}
/// @nodoc
class _$SnackbarItemCopyWithImpl<$Res>
    implements $SnackbarItemCopyWith<$Res> {
  _$SnackbarItemCopyWithImpl(this._self, this._then);

  final SnackbarItem _self;
  final $Res Function(SnackbarItem) _then;

/// Create a copy of SnackbarItem
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? key = freezed,Object? content = null,Object? type = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,key: freezed == key ? _self.key : key // ignore: cast_nullable_to_non_nullable
as Key?,content: null == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as SnackbarType,
  ));
}

}


/// Adds pattern-matching-related methods to [SnackbarItem].
extension SnackbarItemPatterns on SnackbarItem {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SnackbarItem value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SnackbarItem() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SnackbarItem value)  $default,){
final _that = this;
switch (_that) {
case _SnackbarItem():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SnackbarItem value)?  $default,){
final _that = this;
switch (_that) {
case _SnackbarItem() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  Key? key,  String content,  SnackbarType type)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SnackbarItem() when $default != null:
return $default(_that.id,_that.key,_that.content,_that.type);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  Key? key,  String content,  SnackbarType type)  $default,) {final _that = this;
switch (_that) {
case _SnackbarItem():
return $default(_that.id,_that.key,_that.content,_that.type);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  Key? key,  String content,  SnackbarType type)?  $default,) {final _that = this;
switch (_that) {
case _SnackbarItem() when $default != null:
return $default(_that.id,_that.key,_that.content,_that.type);case _:
  return null;

}
}

}

/// @nodoc


class _SnackbarItem implements SnackbarItem {
   _SnackbarItem({this.id = '', this.key = null, this.content = '', this.type = SnackbarType.success});
  

@override@JsonKey() final  String id;
@override@JsonKey() final  Key? key;
@override@JsonKey() final  String content;
@override@JsonKey() final  SnackbarType type;

/// Create a copy of SnackbarItem
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SnackbarItemCopyWith<_SnackbarItem> get copyWith => __$SnackbarItemCopyWithImpl<_SnackbarItem>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SnackbarItem&&(identical(other.id, id) || other.id == id)&&(identical(other.key, key) || other.key == key)&&(identical(other.content, content) || other.content == content)&&(identical(other.type, type) || other.type == type));
}


@override
int get hashCode => Object.hash(runtimeType,id,key,content,type);

@override
String toString() {
  return 'SnackbarItem(id: $id, key: $key, content: $content, type: $type)';
}


}

/// @nodoc
abstract mixin class _$SnackbarItemCopyWith<$Res> implements $SnackbarItemCopyWith<$Res> {
  factory _$SnackbarItemCopyWith(_SnackbarItem value, $Res Function(_SnackbarItem) _then) = __$SnackbarItemCopyWithImpl;
@override @useResult
$Res call({
 String id, Key? key, String content, SnackbarType type
});




}
/// @nodoc
class __$SnackbarItemCopyWithImpl<$Res>
    implements _$SnackbarItemCopyWith<$Res> {
  __$SnackbarItemCopyWithImpl(this._self, this._then);

  final _SnackbarItem _self;
  final $Res Function(_SnackbarItem) _then;

/// Create a copy of SnackbarItem
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? key = freezed,Object? content = null,Object? type = null,}) {
  return _then(_SnackbarItem(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,key: freezed == key ? _self.key : key // ignore: cast_nullable_to_non_nullable
as Key?,content: null == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as SnackbarType,
  ));
}


}

/// @nodoc
mixin _$SnackbarState {

 List<SnackbarItem> get snackbarItems;
/// Create a copy of SnackbarState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SnackbarStateCopyWith<SnackbarState> get copyWith => _$SnackbarStateCopyWithImpl<SnackbarState>(this as SnackbarState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SnackbarState&&const DeepCollectionEquality().equals(other.snackbarItems, snackbarItems));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(snackbarItems));

@override
String toString() {
  return 'SnackbarState(snackbarItems: $snackbarItems)';
}


}

/// @nodoc
abstract mixin class $SnackbarStateCopyWith<$Res>  {
  factory $SnackbarStateCopyWith(SnackbarState value, $Res Function(SnackbarState) _then) = _$SnackbarStateCopyWithImpl;
@useResult
$Res call({
 List<SnackbarItem> snackbarItems
});




}
/// @nodoc
class _$SnackbarStateCopyWithImpl<$Res>
    implements $SnackbarStateCopyWith<$Res> {
  _$SnackbarStateCopyWithImpl(this._self, this._then);

  final SnackbarState _self;
  final $Res Function(SnackbarState) _then;

/// Create a copy of SnackbarState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? snackbarItems = null,}) {
  return _then(_self.copyWith(
snackbarItems: null == snackbarItems ? _self.snackbarItems : snackbarItems // ignore: cast_nullable_to_non_nullable
as List<SnackbarItem>,
  ));
}

}


/// Adds pattern-matching-related methods to [SnackbarState].
extension SnackbarStatePatterns on SnackbarState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SnackbarState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SnackbarState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SnackbarState value)  $default,){
final _that = this;
switch (_that) {
case _SnackbarState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SnackbarState value)?  $default,){
final _that = this;
switch (_that) {
case _SnackbarState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<SnackbarItem> snackbarItems)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SnackbarState() when $default != null:
return $default(_that.snackbarItems);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<SnackbarItem> snackbarItems)  $default,) {final _that = this;
switch (_that) {
case _SnackbarState():
return $default(_that.snackbarItems);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<SnackbarItem> snackbarItems)?  $default,) {final _that = this;
switch (_that) {
case _SnackbarState() when $default != null:
return $default(_that.snackbarItems);case _:
  return null;

}
}

}

/// @nodoc


class _SnackbarState implements SnackbarState {
   _SnackbarState({final  List<SnackbarItem> snackbarItems = const <SnackbarItem>[]}): _snackbarItems = snackbarItems;
  

 final  List<SnackbarItem> _snackbarItems;
@override@JsonKey() List<SnackbarItem> get snackbarItems {
  if (_snackbarItems is EqualUnmodifiableListView) return _snackbarItems;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_snackbarItems);
}


/// Create a copy of SnackbarState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SnackbarStateCopyWith<_SnackbarState> get copyWith => __$SnackbarStateCopyWithImpl<_SnackbarState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SnackbarState&&const DeepCollectionEquality().equals(other._snackbarItems, _snackbarItems));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_snackbarItems));

@override
String toString() {
  return 'SnackbarState(snackbarItems: $snackbarItems)';
}


}

/// @nodoc
abstract mixin class _$SnackbarStateCopyWith<$Res> implements $SnackbarStateCopyWith<$Res> {
  factory _$SnackbarStateCopyWith(_SnackbarState value, $Res Function(_SnackbarState) _then) = __$SnackbarStateCopyWithImpl;
@override @useResult
$Res call({
 List<SnackbarItem> snackbarItems
});




}
/// @nodoc
class __$SnackbarStateCopyWithImpl<$Res>
    implements _$SnackbarStateCopyWith<$Res> {
  __$SnackbarStateCopyWithImpl(this._self, this._then);

  final _SnackbarState _self;
  final $Res Function(_SnackbarState) _then;

/// Create a copy of SnackbarState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? snackbarItems = null,}) {
  return _then(_SnackbarState(
snackbarItems: null == snackbarItems ? _self._snackbarItems : snackbarItems // ignore: cast_nullable_to_non_nullable
as List<SnackbarItem>,
  ));
}


}

// dart format on
