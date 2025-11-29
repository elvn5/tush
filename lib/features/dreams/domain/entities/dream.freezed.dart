// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'dream.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Dream {

 String get id; String get text; DateTime get createdAt;
/// Create a copy of Dream
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DreamCopyWith<Dream> get copyWith => _$DreamCopyWithImpl<Dream>(this as Dream, _$identity);

  /// Serializes this Dream to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Dream&&(identical(other.id, id) || other.id == id)&&(identical(other.text, text) || other.text == text)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,text,createdAt);

@override
String toString() {
  return 'Dream(id: $id, text: $text, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class $DreamCopyWith<$Res>  {
  factory $DreamCopyWith(Dream value, $Res Function(Dream) _then) = _$DreamCopyWithImpl;
@useResult
$Res call({
 String id, String text, DateTime createdAt
});




}
/// @nodoc
class _$DreamCopyWithImpl<$Res>
    implements $DreamCopyWith<$Res> {
  _$DreamCopyWithImpl(this._self, this._then);

  final Dream _self;
  final $Res Function(Dream) _then;

/// Create a copy of Dream
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? text = null,Object? createdAt = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [Dream].
extension DreamPatterns on Dream {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Dream value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Dream() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Dream value)  $default,){
final _that = this;
switch (_that) {
case _Dream():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Dream value)?  $default,){
final _that = this;
switch (_that) {
case _Dream() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String text,  DateTime createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Dream() when $default != null:
return $default(_that.id,_that.text,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String text,  DateTime createdAt)  $default,) {final _that = this;
switch (_that) {
case _Dream():
return $default(_that.id,_that.text,_that.createdAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String text,  DateTime createdAt)?  $default,) {final _that = this;
switch (_that) {
case _Dream() when $default != null:
return $default(_that.id,_that.text,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Dream implements Dream {
  const _Dream({required this.id, required this.text, required this.createdAt});
  factory _Dream.fromJson(Map<String, dynamic> json) => _$DreamFromJson(json);

@override final  String id;
@override final  String text;
@override final  DateTime createdAt;

/// Create a copy of Dream
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DreamCopyWith<_Dream> get copyWith => __$DreamCopyWithImpl<_Dream>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DreamToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Dream&&(identical(other.id, id) || other.id == id)&&(identical(other.text, text) || other.text == text)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,text,createdAt);

@override
String toString() {
  return 'Dream(id: $id, text: $text, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$DreamCopyWith<$Res> implements $DreamCopyWith<$Res> {
  factory _$DreamCopyWith(_Dream value, $Res Function(_Dream) _then) = __$DreamCopyWithImpl;
@override @useResult
$Res call({
 String id, String text, DateTime createdAt
});




}
/// @nodoc
class __$DreamCopyWithImpl<$Res>
    implements _$DreamCopyWith<$Res> {
  __$DreamCopyWithImpl(this._self, this._then);

  final _Dream _self;
  final $Res Function(_Dream) _then;

/// Create a copy of Dream
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? text = null,Object? createdAt = null,}) {
  return _then(_Dream(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
