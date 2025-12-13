// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'friend_requests_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$FriendRequestsEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FriendRequestsEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'FriendRequestsEvent()';
}


}

/// @nodoc
class $FriendRequestsEventCopyWith<$Res>  {
$FriendRequestsEventCopyWith(FriendRequestsEvent _, $Res Function(FriendRequestsEvent) __);
}


/// Adds pattern-matching-related methods to [FriendRequestsEvent].
extension FriendRequestsEventPatterns on FriendRequestsEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Load value)?  load,TResult Function( _Accept value)?  accept,TResult Function( _Decline value)?  decline,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Load() when load != null:
return load(_that);case _Accept() when accept != null:
return accept(_that);case _Decline() when decline != null:
return decline(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Load value)  load,required TResult Function( _Accept value)  accept,required TResult Function( _Decline value)  decline,}){
final _that = this;
switch (_that) {
case _Load():
return load(_that);case _Accept():
return accept(_that);case _Decline():
return decline(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Load value)?  load,TResult? Function( _Accept value)?  accept,TResult? Function( _Decline value)?  decline,}){
final _that = this;
switch (_that) {
case _Load() when load != null:
return load(_that);case _Accept() when accept != null:
return accept(_that);case _Decline() when decline != null:
return decline(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  load,TResult Function( String senderId)?  accept,TResult Function( String senderId)?  decline,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Load() when load != null:
return load();case _Accept() when accept != null:
return accept(_that.senderId);case _Decline() when decline != null:
return decline(_that.senderId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  load,required TResult Function( String senderId)  accept,required TResult Function( String senderId)  decline,}) {final _that = this;
switch (_that) {
case _Load():
return load();case _Accept():
return accept(_that.senderId);case _Decline():
return decline(_that.senderId);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  load,TResult? Function( String senderId)?  accept,TResult? Function( String senderId)?  decline,}) {final _that = this;
switch (_that) {
case _Load() when load != null:
return load();case _Accept() when accept != null:
return accept(_that.senderId);case _Decline() when decline != null:
return decline(_that.senderId);case _:
  return null;

}
}

}

/// @nodoc


class _Load implements FriendRequestsEvent {
  const _Load();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Load);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'FriendRequestsEvent.load()';
}


}




/// @nodoc


class _Accept implements FriendRequestsEvent {
  const _Accept({required this.senderId});
  

 final  String senderId;

/// Create a copy of FriendRequestsEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AcceptCopyWith<_Accept> get copyWith => __$AcceptCopyWithImpl<_Accept>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Accept&&(identical(other.senderId, senderId) || other.senderId == senderId));
}


@override
int get hashCode => Object.hash(runtimeType,senderId);

@override
String toString() {
  return 'FriendRequestsEvent.accept(senderId: $senderId)';
}


}

/// @nodoc
abstract mixin class _$AcceptCopyWith<$Res> implements $FriendRequestsEventCopyWith<$Res> {
  factory _$AcceptCopyWith(_Accept value, $Res Function(_Accept) _then) = __$AcceptCopyWithImpl;
@useResult
$Res call({
 String senderId
});




}
/// @nodoc
class __$AcceptCopyWithImpl<$Res>
    implements _$AcceptCopyWith<$Res> {
  __$AcceptCopyWithImpl(this._self, this._then);

  final _Accept _self;
  final $Res Function(_Accept) _then;

/// Create a copy of FriendRequestsEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? senderId = null,}) {
  return _then(_Accept(
senderId: null == senderId ? _self.senderId : senderId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _Decline implements FriendRequestsEvent {
  const _Decline({required this.senderId});
  

 final  String senderId;

/// Create a copy of FriendRequestsEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DeclineCopyWith<_Decline> get copyWith => __$DeclineCopyWithImpl<_Decline>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Decline&&(identical(other.senderId, senderId) || other.senderId == senderId));
}


@override
int get hashCode => Object.hash(runtimeType,senderId);

@override
String toString() {
  return 'FriendRequestsEvent.decline(senderId: $senderId)';
}


}

/// @nodoc
abstract mixin class _$DeclineCopyWith<$Res> implements $FriendRequestsEventCopyWith<$Res> {
  factory _$DeclineCopyWith(_Decline value, $Res Function(_Decline) _then) = __$DeclineCopyWithImpl;
@useResult
$Res call({
 String senderId
});




}
/// @nodoc
class __$DeclineCopyWithImpl<$Res>
    implements _$DeclineCopyWith<$Res> {
  __$DeclineCopyWithImpl(this._self, this._then);

  final _Decline _self;
  final $Res Function(_Decline) _then;

/// Create a copy of FriendRequestsEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? senderId = null,}) {
  return _then(_Decline(
senderId: null == senderId ? _self.senderId : senderId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
mixin _$FriendRequestsState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FriendRequestsState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'FriendRequestsState()';
}


}

/// @nodoc
class $FriendRequestsStateCopyWith<$Res>  {
$FriendRequestsStateCopyWith(FriendRequestsState _, $Res Function(FriendRequestsState) __);
}


/// Adds pattern-matching-related methods to [FriendRequestsState].
extension FriendRequestsStatePatterns on FriendRequestsState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Initial value)?  initial,TResult Function( _Loading value)?  loading,TResult Function( _Loaded value)?  loaded,TResult Function( _Error value)?  error,TResult Function( _Accepted value)?  accepted,TResult Function( _Declined value)?  declined,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case _Loading() when loading != null:
return loading(_that);case _Loaded() when loaded != null:
return loaded(_that);case _Error() when error != null:
return error(_that);case _Accepted() when accepted != null:
return accepted(_that);case _Declined() when declined != null:
return declined(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Initial value)  initial,required TResult Function( _Loading value)  loading,required TResult Function( _Loaded value)  loaded,required TResult Function( _Error value)  error,required TResult Function( _Accepted value)  accepted,required TResult Function( _Declined value)  declined,}){
final _that = this;
switch (_that) {
case _Initial():
return initial(_that);case _Loading():
return loading(_that);case _Loaded():
return loaded(_that);case _Error():
return error(_that);case _Accepted():
return accepted(_that);case _Declined():
return declined(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Initial value)?  initial,TResult? Function( _Loading value)?  loading,TResult? Function( _Loaded value)?  loaded,TResult? Function( _Error value)?  error,TResult? Function( _Accepted value)?  accepted,TResult? Function( _Declined value)?  declined,}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case _Loading() when loading != null:
return loading(_that);case _Loaded() when loaded != null:
return loaded(_that);case _Error() when error != null:
return error(_that);case _Accepted() when accepted != null:
return accepted(_that);case _Declined() when declined != null:
return declined(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function( List<FriendUser> requests)?  loaded,TResult Function( String message)?  error,TResult Function()?  accepted,TResult Function()?  declined,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case _Loading() when loading != null:
return loading();case _Loaded() when loaded != null:
return loaded(_that.requests);case _Error() when error != null:
return error(_that.message);case _Accepted() when accepted != null:
return accepted();case _Declined() when declined != null:
return declined();case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function( List<FriendUser> requests)  loaded,required TResult Function( String message)  error,required TResult Function()  accepted,required TResult Function()  declined,}) {final _that = this;
switch (_that) {
case _Initial():
return initial();case _Loading():
return loading();case _Loaded():
return loaded(_that.requests);case _Error():
return error(_that.message);case _Accepted():
return accepted();case _Declined():
return declined();case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function( List<FriendUser> requests)?  loaded,TResult? Function( String message)?  error,TResult? Function()?  accepted,TResult? Function()?  declined,}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case _Loading() when loading != null:
return loading();case _Loaded() when loaded != null:
return loaded(_that.requests);case _Error() when error != null:
return error(_that.message);case _Accepted() when accepted != null:
return accepted();case _Declined() when declined != null:
return declined();case _:
  return null;

}
}

}

/// @nodoc


class _Initial implements FriendRequestsState {
  const _Initial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Initial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'FriendRequestsState.initial()';
}


}




/// @nodoc


class _Loading implements FriendRequestsState {
  const _Loading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Loading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'FriendRequestsState.loading()';
}


}




/// @nodoc


class _Loaded implements FriendRequestsState {
  const _Loaded({required final  List<FriendUser> requests}): _requests = requests;
  

 final  List<FriendUser> _requests;
 List<FriendUser> get requests {
  if (_requests is EqualUnmodifiableListView) return _requests;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_requests);
}


/// Create a copy of FriendRequestsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LoadedCopyWith<_Loaded> get copyWith => __$LoadedCopyWithImpl<_Loaded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Loaded&&const DeepCollectionEquality().equals(other._requests, _requests));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_requests));

@override
String toString() {
  return 'FriendRequestsState.loaded(requests: $requests)';
}


}

/// @nodoc
abstract mixin class _$LoadedCopyWith<$Res> implements $FriendRequestsStateCopyWith<$Res> {
  factory _$LoadedCopyWith(_Loaded value, $Res Function(_Loaded) _then) = __$LoadedCopyWithImpl;
@useResult
$Res call({
 List<FriendUser> requests
});




}
/// @nodoc
class __$LoadedCopyWithImpl<$Res>
    implements _$LoadedCopyWith<$Res> {
  __$LoadedCopyWithImpl(this._self, this._then);

  final _Loaded _self;
  final $Res Function(_Loaded) _then;

/// Create a copy of FriendRequestsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? requests = null,}) {
  return _then(_Loaded(
requests: null == requests ? _self._requests : requests // ignore: cast_nullable_to_non_nullable
as List<FriendUser>,
  ));
}


}

/// @nodoc


class _Error implements FriendRequestsState {
  const _Error({required this.message});
  

 final  String message;

/// Create a copy of FriendRequestsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ErrorCopyWith<_Error> get copyWith => __$ErrorCopyWithImpl<_Error>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Error&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'FriendRequestsState.error(message: $message)';
}


}

/// @nodoc
abstract mixin class _$ErrorCopyWith<$Res> implements $FriendRequestsStateCopyWith<$Res> {
  factory _$ErrorCopyWith(_Error value, $Res Function(_Error) _then) = __$ErrorCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class __$ErrorCopyWithImpl<$Res>
    implements _$ErrorCopyWith<$Res> {
  __$ErrorCopyWithImpl(this._self, this._then);

  final _Error _self;
  final $Res Function(_Error) _then;

/// Create a copy of FriendRequestsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(_Error(
message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _Accepted implements FriendRequestsState {
  const _Accepted();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Accepted);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'FriendRequestsState.accepted()';
}


}




/// @nodoc


class _Declined implements FriendRequestsState {
  const _Declined();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Declined);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'FriendRequestsState.declined()';
}


}




// dart format on
