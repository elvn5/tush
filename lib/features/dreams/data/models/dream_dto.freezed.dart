// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'dream_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$DreamDTO {

 String get dreamId; String get title;@JsonKey(name: 'dream') String get text; int? get createdAt; bool get isReady;
/// Create a copy of DreamDTO
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DreamDTOCopyWith<DreamDTO> get copyWith => _$DreamDTOCopyWithImpl<DreamDTO>(this as DreamDTO, _$identity);

  /// Serializes this DreamDTO to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DreamDTO&&(identical(other.dreamId, dreamId) || other.dreamId == dreamId)&&(identical(other.title, title) || other.title == title)&&(identical(other.text, text) || other.text == text)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.isReady, isReady) || other.isReady == isReady));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,dreamId,title,text,createdAt,isReady);

@override
String toString() {
  return 'DreamDTO(dreamId: $dreamId, title: $title, text: $text, createdAt: $createdAt, isReady: $isReady)';
}


}

/// @nodoc
abstract mixin class $DreamDTOCopyWith<$Res>  {
  factory $DreamDTOCopyWith(DreamDTO value, $Res Function(DreamDTO) _then) = _$DreamDTOCopyWithImpl;
@useResult
$Res call({
 String dreamId, String title,@JsonKey(name: 'dream') String text, int? createdAt, bool isReady
});




}
/// @nodoc
class _$DreamDTOCopyWithImpl<$Res>
    implements $DreamDTOCopyWith<$Res> {
  _$DreamDTOCopyWithImpl(this._self, this._then);

  final DreamDTO _self;
  final $Res Function(DreamDTO) _then;

/// Create a copy of DreamDTO
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? dreamId = null,Object? title = null,Object? text = null,Object? createdAt = freezed,Object? isReady = null,}) {
  return _then(_self.copyWith(
dreamId: null == dreamId ? _self.dreamId : dreamId // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as int?,isReady: null == isReady ? _self.isReady : isReady // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [DreamDTO].
extension DreamDTOPatterns on DreamDTO {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DreamDTO value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DreamDTO() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DreamDTO value)  $default,){
final _that = this;
switch (_that) {
case _DreamDTO():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DreamDTO value)?  $default,){
final _that = this;
switch (_that) {
case _DreamDTO() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String dreamId,  String title, @JsonKey(name: 'dream')  String text,  int? createdAt,  bool isReady)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DreamDTO() when $default != null:
return $default(_that.dreamId,_that.title,_that.text,_that.createdAt,_that.isReady);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String dreamId,  String title, @JsonKey(name: 'dream')  String text,  int? createdAt,  bool isReady)  $default,) {final _that = this;
switch (_that) {
case _DreamDTO():
return $default(_that.dreamId,_that.title,_that.text,_that.createdAt,_that.isReady);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String dreamId,  String title, @JsonKey(name: 'dream')  String text,  int? createdAt,  bool isReady)?  $default,) {final _that = this;
switch (_that) {
case _DreamDTO() when $default != null:
return $default(_that.dreamId,_that.title,_that.text,_that.createdAt,_that.isReady);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _DreamDTO extends DreamDTO {
  const _DreamDTO({required this.dreamId, required this.title, @JsonKey(name: 'dream') required this.text, this.createdAt, this.isReady = false}): super._();
  factory _DreamDTO.fromJson(Map<String, dynamic> json) => _$DreamDTOFromJson(json);

@override final  String dreamId;
@override final  String title;
@override@JsonKey(name: 'dream') final  String text;
@override final  int? createdAt;
@override@JsonKey() final  bool isReady;

/// Create a copy of DreamDTO
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DreamDTOCopyWith<_DreamDTO> get copyWith => __$DreamDTOCopyWithImpl<_DreamDTO>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DreamDTOToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DreamDTO&&(identical(other.dreamId, dreamId) || other.dreamId == dreamId)&&(identical(other.title, title) || other.title == title)&&(identical(other.text, text) || other.text == text)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.isReady, isReady) || other.isReady == isReady));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,dreamId,title,text,createdAt,isReady);

@override
String toString() {
  return 'DreamDTO(dreamId: $dreamId, title: $title, text: $text, createdAt: $createdAt, isReady: $isReady)';
}


}

/// @nodoc
abstract mixin class _$DreamDTOCopyWith<$Res> implements $DreamDTOCopyWith<$Res> {
  factory _$DreamDTOCopyWith(_DreamDTO value, $Res Function(_DreamDTO) _then) = __$DreamDTOCopyWithImpl;
@override @useResult
$Res call({
 String dreamId, String title,@JsonKey(name: 'dream') String text, int? createdAt, bool isReady
});




}
/// @nodoc
class __$DreamDTOCopyWithImpl<$Res>
    implements _$DreamDTOCopyWith<$Res> {
  __$DreamDTOCopyWithImpl(this._self, this._then);

  final _DreamDTO _self;
  final $Res Function(_DreamDTO) _then;

/// Create a copy of DreamDTO
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? dreamId = null,Object? title = null,Object? text = null,Object? createdAt = freezed,Object? isReady = null,}) {
  return _then(_DreamDTO(
dreamId: null == dreamId ? _self.dreamId : dreamId // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as int?,isReady: null == isReady ? _self.isReady : isReady // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
