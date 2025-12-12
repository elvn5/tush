// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'friends_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$FriendsEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FriendsEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'FriendsEvent()';
}


}

/// @nodoc
class $FriendsEventCopyWith<$Res>  {
$FriendsEventCopyWith(FriendsEvent _, $Res Function(FriendsEvent) __);
}


/// Adds pattern-matching-related methods to [FriendsEvent].
extension FriendsEventPatterns on FriendsEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _SearchUsers value)?  searchUsers,TResult Function( _ClearSearch value)?  clearSearch,TResult Function( _AddFriend value)?  addFriend,TResult Function( _LoadFriends value)?  loadFriends,TResult Function( _RemoveFriend value)?  removeFriend,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SearchUsers() when searchUsers != null:
return searchUsers(_that);case _ClearSearch() when clearSearch != null:
return clearSearch(_that);case _AddFriend() when addFriend != null:
return addFriend(_that);case _LoadFriends() when loadFriends != null:
return loadFriends(_that);case _RemoveFriend() when removeFriend != null:
return removeFriend(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _SearchUsers value)  searchUsers,required TResult Function( _ClearSearch value)  clearSearch,required TResult Function( _AddFriend value)  addFriend,required TResult Function( _LoadFriends value)  loadFriends,required TResult Function( _RemoveFriend value)  removeFriend,}){
final _that = this;
switch (_that) {
case _SearchUsers():
return searchUsers(_that);case _ClearSearch():
return clearSearch(_that);case _AddFriend():
return addFriend(_that);case _LoadFriends():
return loadFriends(_that);case _RemoveFriend():
return removeFriend(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _SearchUsers value)?  searchUsers,TResult? Function( _ClearSearch value)?  clearSearch,TResult? Function( _AddFriend value)?  addFriend,TResult? Function( _LoadFriends value)?  loadFriends,TResult? Function( _RemoveFriend value)?  removeFriend,}){
final _that = this;
switch (_that) {
case _SearchUsers() when searchUsers != null:
return searchUsers(_that);case _ClearSearch() when clearSearch != null:
return clearSearch(_that);case _AddFriend() when addFriend != null:
return addFriend(_that);case _LoadFriends() when loadFriends != null:
return loadFriends(_that);case _RemoveFriend() when removeFriend != null:
return removeFriend(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( String query)?  searchUsers,TResult Function()?  clearSearch,TResult Function( String friendId)?  addFriend,TResult Function()?  loadFriends,TResult Function( String friendId)?  removeFriend,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SearchUsers() when searchUsers != null:
return searchUsers(_that.query);case _ClearSearch() when clearSearch != null:
return clearSearch();case _AddFriend() when addFriend != null:
return addFriend(_that.friendId);case _LoadFriends() when loadFriends != null:
return loadFriends();case _RemoveFriend() when removeFriend != null:
return removeFriend(_that.friendId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( String query)  searchUsers,required TResult Function()  clearSearch,required TResult Function( String friendId)  addFriend,required TResult Function()  loadFriends,required TResult Function( String friendId)  removeFriend,}) {final _that = this;
switch (_that) {
case _SearchUsers():
return searchUsers(_that.query);case _ClearSearch():
return clearSearch();case _AddFriend():
return addFriend(_that.friendId);case _LoadFriends():
return loadFriends();case _RemoveFriend():
return removeFriend(_that.friendId);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( String query)?  searchUsers,TResult? Function()?  clearSearch,TResult? Function( String friendId)?  addFriend,TResult? Function()?  loadFriends,TResult? Function( String friendId)?  removeFriend,}) {final _that = this;
switch (_that) {
case _SearchUsers() when searchUsers != null:
return searchUsers(_that.query);case _ClearSearch() when clearSearch != null:
return clearSearch();case _AddFriend() when addFriend != null:
return addFriend(_that.friendId);case _LoadFriends() when loadFriends != null:
return loadFriends();case _RemoveFriend() when removeFriend != null:
return removeFriend(_that.friendId);case _:
  return null;

}
}

}

/// @nodoc


class _SearchUsers implements FriendsEvent {
  const _SearchUsers({required this.query});
  

 final  String query;

/// Create a copy of FriendsEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SearchUsersCopyWith<_SearchUsers> get copyWith => __$SearchUsersCopyWithImpl<_SearchUsers>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SearchUsers&&(identical(other.query, query) || other.query == query));
}


@override
int get hashCode => Object.hash(runtimeType,query);

@override
String toString() {
  return 'FriendsEvent.searchUsers(query: $query)';
}


}

/// @nodoc
abstract mixin class _$SearchUsersCopyWith<$Res> implements $FriendsEventCopyWith<$Res> {
  factory _$SearchUsersCopyWith(_SearchUsers value, $Res Function(_SearchUsers) _then) = __$SearchUsersCopyWithImpl;
@useResult
$Res call({
 String query
});




}
/// @nodoc
class __$SearchUsersCopyWithImpl<$Res>
    implements _$SearchUsersCopyWith<$Res> {
  __$SearchUsersCopyWithImpl(this._self, this._then);

  final _SearchUsers _self;
  final $Res Function(_SearchUsers) _then;

/// Create a copy of FriendsEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? query = null,}) {
  return _then(_SearchUsers(
query: null == query ? _self.query : query // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _ClearSearch implements FriendsEvent {
  const _ClearSearch();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ClearSearch);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'FriendsEvent.clearSearch()';
}


}




/// @nodoc


class _AddFriend implements FriendsEvent {
  const _AddFriend({required this.friendId});
  

 final  String friendId;

/// Create a copy of FriendsEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AddFriendCopyWith<_AddFriend> get copyWith => __$AddFriendCopyWithImpl<_AddFriend>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AddFriend&&(identical(other.friendId, friendId) || other.friendId == friendId));
}


@override
int get hashCode => Object.hash(runtimeType,friendId);

@override
String toString() {
  return 'FriendsEvent.addFriend(friendId: $friendId)';
}


}

/// @nodoc
abstract mixin class _$AddFriendCopyWith<$Res> implements $FriendsEventCopyWith<$Res> {
  factory _$AddFriendCopyWith(_AddFriend value, $Res Function(_AddFriend) _then) = __$AddFriendCopyWithImpl;
@useResult
$Res call({
 String friendId
});




}
/// @nodoc
class __$AddFriendCopyWithImpl<$Res>
    implements _$AddFriendCopyWith<$Res> {
  __$AddFriendCopyWithImpl(this._self, this._then);

  final _AddFriend _self;
  final $Res Function(_AddFriend) _then;

/// Create a copy of FriendsEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? friendId = null,}) {
  return _then(_AddFriend(
friendId: null == friendId ? _self.friendId : friendId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _LoadFriends implements FriendsEvent {
  const _LoadFriends();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LoadFriends);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'FriendsEvent.loadFriends()';
}


}




/// @nodoc


class _RemoveFriend implements FriendsEvent {
  const _RemoveFriend({required this.friendId});
  

 final  String friendId;

/// Create a copy of FriendsEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RemoveFriendCopyWith<_RemoveFriend> get copyWith => __$RemoveFriendCopyWithImpl<_RemoveFriend>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RemoveFriend&&(identical(other.friendId, friendId) || other.friendId == friendId));
}


@override
int get hashCode => Object.hash(runtimeType,friendId);

@override
String toString() {
  return 'FriendsEvent.removeFriend(friendId: $friendId)';
}


}

/// @nodoc
abstract mixin class _$RemoveFriendCopyWith<$Res> implements $FriendsEventCopyWith<$Res> {
  factory _$RemoveFriendCopyWith(_RemoveFriend value, $Res Function(_RemoveFriend) _then) = __$RemoveFriendCopyWithImpl;
@useResult
$Res call({
 String friendId
});




}
/// @nodoc
class __$RemoveFriendCopyWithImpl<$Res>
    implements _$RemoveFriendCopyWith<$Res> {
  __$RemoveFriendCopyWithImpl(this._self, this._then);

  final _RemoveFriend _self;
  final $Res Function(_RemoveFriend) _then;

/// Create a copy of FriendsEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? friendId = null,}) {
  return _then(_RemoveFriend(
friendId: null == friendId ? _self.friendId : friendId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
mixin _$FriendsState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FriendsState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'FriendsState()';
}


}

/// @nodoc
class $FriendsStateCopyWith<$Res>  {
$FriendsStateCopyWith(FriendsState _, $Res Function(FriendsState) __);
}


/// Adds pattern-matching-related methods to [FriendsState].
extension FriendsStatePatterns on FriendsState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Initial value)?  initial,TResult Function( _Searching value)?  searching,TResult Function( _SearchResults value)?  searchResults,TResult Function( _Empty value)?  empty,TResult Function( _Error value)?  error,TResult Function( _AddingFriend value)?  addingFriend,TResult Function( _FriendAdded value)?  friendAdded,TResult Function( _LoadingFriends value)?  loadingFriends,TResult Function( _FriendsLoaded value)?  friendsLoaded,TResult Function( _FriendRemoved value)?  friendRemoved,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case _Searching() when searching != null:
return searching(_that);case _SearchResults() when searchResults != null:
return searchResults(_that);case _Empty() when empty != null:
return empty(_that);case _Error() when error != null:
return error(_that);case _AddingFriend() when addingFriend != null:
return addingFriend(_that);case _FriendAdded() when friendAdded != null:
return friendAdded(_that);case _LoadingFriends() when loadingFriends != null:
return loadingFriends(_that);case _FriendsLoaded() when friendsLoaded != null:
return friendsLoaded(_that);case _FriendRemoved() when friendRemoved != null:
return friendRemoved(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Initial value)  initial,required TResult Function( _Searching value)  searching,required TResult Function( _SearchResults value)  searchResults,required TResult Function( _Empty value)  empty,required TResult Function( _Error value)  error,required TResult Function( _AddingFriend value)  addingFriend,required TResult Function( _FriendAdded value)  friendAdded,required TResult Function( _LoadingFriends value)  loadingFriends,required TResult Function( _FriendsLoaded value)  friendsLoaded,required TResult Function( _FriendRemoved value)  friendRemoved,}){
final _that = this;
switch (_that) {
case _Initial():
return initial(_that);case _Searching():
return searching(_that);case _SearchResults():
return searchResults(_that);case _Empty():
return empty(_that);case _Error():
return error(_that);case _AddingFriend():
return addingFriend(_that);case _FriendAdded():
return friendAdded(_that);case _LoadingFriends():
return loadingFriends(_that);case _FriendsLoaded():
return friendsLoaded(_that);case _FriendRemoved():
return friendRemoved(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Initial value)?  initial,TResult? Function( _Searching value)?  searching,TResult? Function( _SearchResults value)?  searchResults,TResult? Function( _Empty value)?  empty,TResult? Function( _Error value)?  error,TResult? Function( _AddingFriend value)?  addingFriend,TResult? Function( _FriendAdded value)?  friendAdded,TResult? Function( _LoadingFriends value)?  loadingFriends,TResult? Function( _FriendsLoaded value)?  friendsLoaded,TResult? Function( _FriendRemoved value)?  friendRemoved,}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case _Searching() when searching != null:
return searching(_that);case _SearchResults() when searchResults != null:
return searchResults(_that);case _Empty() when empty != null:
return empty(_that);case _Error() when error != null:
return error(_that);case _AddingFriend() when addingFriend != null:
return addingFriend(_that);case _FriendAdded() when friendAdded != null:
return friendAdded(_that);case _LoadingFriends() when loadingFriends != null:
return loadingFriends(_that);case _FriendsLoaded() when friendsLoaded != null:
return friendsLoaded(_that);case _FriendRemoved() when friendRemoved != null:
return friendRemoved(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  searching,TResult Function( List<FriendUser> users)?  searchResults,TResult Function()?  empty,TResult Function( String message)?  error,TResult Function()?  addingFriend,TResult Function()?  friendAdded,TResult Function()?  loadingFriends,TResult Function( List<FriendUser> friends)?  friendsLoaded,TResult Function()?  friendRemoved,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case _Searching() when searching != null:
return searching();case _SearchResults() when searchResults != null:
return searchResults(_that.users);case _Empty() when empty != null:
return empty();case _Error() when error != null:
return error(_that.message);case _AddingFriend() when addingFriend != null:
return addingFriend();case _FriendAdded() when friendAdded != null:
return friendAdded();case _LoadingFriends() when loadingFriends != null:
return loadingFriends();case _FriendsLoaded() when friendsLoaded != null:
return friendsLoaded(_that.friends);case _FriendRemoved() when friendRemoved != null:
return friendRemoved();case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  searching,required TResult Function( List<FriendUser> users)  searchResults,required TResult Function()  empty,required TResult Function( String message)  error,required TResult Function()  addingFriend,required TResult Function()  friendAdded,required TResult Function()  loadingFriends,required TResult Function( List<FriendUser> friends)  friendsLoaded,required TResult Function()  friendRemoved,}) {final _that = this;
switch (_that) {
case _Initial():
return initial();case _Searching():
return searching();case _SearchResults():
return searchResults(_that.users);case _Empty():
return empty();case _Error():
return error(_that.message);case _AddingFriend():
return addingFriend();case _FriendAdded():
return friendAdded();case _LoadingFriends():
return loadingFriends();case _FriendsLoaded():
return friendsLoaded(_that.friends);case _FriendRemoved():
return friendRemoved();case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  searching,TResult? Function( List<FriendUser> users)?  searchResults,TResult? Function()?  empty,TResult? Function( String message)?  error,TResult? Function()?  addingFriend,TResult? Function()?  friendAdded,TResult? Function()?  loadingFriends,TResult? Function( List<FriendUser> friends)?  friendsLoaded,TResult? Function()?  friendRemoved,}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case _Searching() when searching != null:
return searching();case _SearchResults() when searchResults != null:
return searchResults(_that.users);case _Empty() when empty != null:
return empty();case _Error() when error != null:
return error(_that.message);case _AddingFriend() when addingFriend != null:
return addingFriend();case _FriendAdded() when friendAdded != null:
return friendAdded();case _LoadingFriends() when loadingFriends != null:
return loadingFriends();case _FriendsLoaded() when friendsLoaded != null:
return friendsLoaded(_that.friends);case _FriendRemoved() when friendRemoved != null:
return friendRemoved();case _:
  return null;

}
}

}

/// @nodoc


class _Initial implements FriendsState {
  const _Initial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Initial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'FriendsState.initial()';
}


}




/// @nodoc


class _Searching implements FriendsState {
  const _Searching();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Searching);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'FriendsState.searching()';
}


}




/// @nodoc


class _SearchResults implements FriendsState {
  const _SearchResults({required final  List<FriendUser> users}): _users = users;
  

 final  List<FriendUser> _users;
 List<FriendUser> get users {
  if (_users is EqualUnmodifiableListView) return _users;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_users);
}


/// Create a copy of FriendsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SearchResultsCopyWith<_SearchResults> get copyWith => __$SearchResultsCopyWithImpl<_SearchResults>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SearchResults&&const DeepCollectionEquality().equals(other._users, _users));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_users));

@override
String toString() {
  return 'FriendsState.searchResults(users: $users)';
}


}

/// @nodoc
abstract mixin class _$SearchResultsCopyWith<$Res> implements $FriendsStateCopyWith<$Res> {
  factory _$SearchResultsCopyWith(_SearchResults value, $Res Function(_SearchResults) _then) = __$SearchResultsCopyWithImpl;
@useResult
$Res call({
 List<FriendUser> users
});




}
/// @nodoc
class __$SearchResultsCopyWithImpl<$Res>
    implements _$SearchResultsCopyWith<$Res> {
  __$SearchResultsCopyWithImpl(this._self, this._then);

  final _SearchResults _self;
  final $Res Function(_SearchResults) _then;

/// Create a copy of FriendsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? users = null,}) {
  return _then(_SearchResults(
users: null == users ? _self._users : users // ignore: cast_nullable_to_non_nullable
as List<FriendUser>,
  ));
}


}

/// @nodoc


class _Empty implements FriendsState {
  const _Empty();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Empty);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'FriendsState.empty()';
}


}




/// @nodoc


class _Error implements FriendsState {
  const _Error({required this.message});
  

 final  String message;

/// Create a copy of FriendsState
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
  return 'FriendsState.error(message: $message)';
}


}

/// @nodoc
abstract mixin class _$ErrorCopyWith<$Res> implements $FriendsStateCopyWith<$Res> {
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

/// Create a copy of FriendsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(_Error(
message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _AddingFriend implements FriendsState {
  const _AddingFriend();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AddingFriend);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'FriendsState.addingFriend()';
}


}




/// @nodoc


class _FriendAdded implements FriendsState {
  const _FriendAdded();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FriendAdded);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'FriendsState.friendAdded()';
}


}




/// @nodoc


class _LoadingFriends implements FriendsState {
  const _LoadingFriends();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LoadingFriends);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'FriendsState.loadingFriends()';
}


}




/// @nodoc


class _FriendsLoaded implements FriendsState {
  const _FriendsLoaded({required final  List<FriendUser> friends}): _friends = friends;
  

 final  List<FriendUser> _friends;
 List<FriendUser> get friends {
  if (_friends is EqualUnmodifiableListView) return _friends;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_friends);
}


/// Create a copy of FriendsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FriendsLoadedCopyWith<_FriendsLoaded> get copyWith => __$FriendsLoadedCopyWithImpl<_FriendsLoaded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FriendsLoaded&&const DeepCollectionEquality().equals(other._friends, _friends));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_friends));

@override
String toString() {
  return 'FriendsState.friendsLoaded(friends: $friends)';
}


}

/// @nodoc
abstract mixin class _$FriendsLoadedCopyWith<$Res> implements $FriendsStateCopyWith<$Res> {
  factory _$FriendsLoadedCopyWith(_FriendsLoaded value, $Res Function(_FriendsLoaded) _then) = __$FriendsLoadedCopyWithImpl;
@useResult
$Res call({
 List<FriendUser> friends
});




}
/// @nodoc
class __$FriendsLoadedCopyWithImpl<$Res>
    implements _$FriendsLoadedCopyWith<$Res> {
  __$FriendsLoadedCopyWithImpl(this._self, this._then);

  final _FriendsLoaded _self;
  final $Res Function(_FriendsLoaded) _then;

/// Create a copy of FriendsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? friends = null,}) {
  return _then(_FriendsLoaded(
friends: null == friends ? _self._friends : friends // ignore: cast_nullable_to_non_nullable
as List<FriendUser>,
  ));
}


}

/// @nodoc


class _FriendRemoved implements FriendsState {
  const _FriendRemoved();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FriendRemoved);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'FriendsState.friendRemoved()';
}


}




// dart format on
