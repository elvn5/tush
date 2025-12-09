// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'dreams_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$DreamsEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DreamsEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'DreamsEvent()';
}


}

/// @nodoc
class $DreamsEventCopyWith<$Res>  {
$DreamsEventCopyWith(DreamsEvent _, $Res Function(DreamsEvent) __);
}


/// Adds pattern-matching-related methods to [DreamsEvent].
extension DreamsEventPatterns on DreamsEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Started value)?  started,TResult Function( _LoadMore value)?  loadMore,TResult Function( _Refresh value)?  refresh,TResult Function( _Add value)?  add,TResult Function( _SearchChanged value)?  searchChanged,TResult Function( _FilterChanged value)?  filterChanged,TResult Function( _Delete value)?  delete,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Started() when started != null:
return started(_that);case _LoadMore() when loadMore != null:
return loadMore(_that);case _Refresh() when refresh != null:
return refresh(_that);case _Add() when add != null:
return add(_that);case _SearchChanged() when searchChanged != null:
return searchChanged(_that);case _FilterChanged() when filterChanged != null:
return filterChanged(_that);case _Delete() when delete != null:
return delete(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Started value)  started,required TResult Function( _LoadMore value)  loadMore,required TResult Function( _Refresh value)  refresh,required TResult Function( _Add value)  add,required TResult Function( _SearchChanged value)  searchChanged,required TResult Function( _FilterChanged value)  filterChanged,required TResult Function( _Delete value)  delete,}){
final _that = this;
switch (_that) {
case _Started():
return started(_that);case _LoadMore():
return loadMore(_that);case _Refresh():
return refresh(_that);case _Add():
return add(_that);case _SearchChanged():
return searchChanged(_that);case _FilterChanged():
return filterChanged(_that);case _Delete():
return delete(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Started value)?  started,TResult? Function( _LoadMore value)?  loadMore,TResult? Function( _Refresh value)?  refresh,TResult? Function( _Add value)?  add,TResult? Function( _SearchChanged value)?  searchChanged,TResult? Function( _FilterChanged value)?  filterChanged,TResult? Function( _Delete value)?  delete,}){
final _that = this;
switch (_that) {
case _Started() when started != null:
return started(_that);case _LoadMore() when loadMore != null:
return loadMore(_that);case _Refresh() when refresh != null:
return refresh(_that);case _Add() when add != null:
return add(_that);case _SearchChanged() when searchChanged != null:
return searchChanged(_that);case _FilterChanged() when filterChanged != null:
return filterChanged(_that);case _Delete() when delete != null:
return delete(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  started,TResult Function()?  loadMore,TResult Function( Completer<void>? completer)?  refresh,TResult Function( String text)?  add,TResult Function( String query)?  searchChanged,TResult Function( bool? status,  DateTime? startDate,  DateTime? endDate)?  filterChanged,TResult Function( String id)?  delete,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Started() when started != null:
return started();case _LoadMore() when loadMore != null:
return loadMore();case _Refresh() when refresh != null:
return refresh(_that.completer);case _Add() when add != null:
return add(_that.text);case _SearchChanged() when searchChanged != null:
return searchChanged(_that.query);case _FilterChanged() when filterChanged != null:
return filterChanged(_that.status,_that.startDate,_that.endDate);case _Delete() when delete != null:
return delete(_that.id);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  started,required TResult Function()  loadMore,required TResult Function( Completer<void>? completer)  refresh,required TResult Function( String text)  add,required TResult Function( String query)  searchChanged,required TResult Function( bool? status,  DateTime? startDate,  DateTime? endDate)  filterChanged,required TResult Function( String id)  delete,}) {final _that = this;
switch (_that) {
case _Started():
return started();case _LoadMore():
return loadMore();case _Refresh():
return refresh(_that.completer);case _Add():
return add(_that.text);case _SearchChanged():
return searchChanged(_that.query);case _FilterChanged():
return filterChanged(_that.status,_that.startDate,_that.endDate);case _Delete():
return delete(_that.id);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  started,TResult? Function()?  loadMore,TResult? Function( Completer<void>? completer)?  refresh,TResult? Function( String text)?  add,TResult? Function( String query)?  searchChanged,TResult? Function( bool? status,  DateTime? startDate,  DateTime? endDate)?  filterChanged,TResult? Function( String id)?  delete,}) {final _that = this;
switch (_that) {
case _Started() when started != null:
return started();case _LoadMore() when loadMore != null:
return loadMore();case _Refresh() when refresh != null:
return refresh(_that.completer);case _Add() when add != null:
return add(_that.text);case _SearchChanged() when searchChanged != null:
return searchChanged(_that.query);case _FilterChanged() when filterChanged != null:
return filterChanged(_that.status,_that.startDate,_that.endDate);case _Delete() when delete != null:
return delete(_that.id);case _:
  return null;

}
}

}

/// @nodoc


class _Started implements DreamsEvent {
  const _Started();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Started);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'DreamsEvent.started()';
}


}




/// @nodoc


class _LoadMore implements DreamsEvent {
  const _LoadMore();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LoadMore);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'DreamsEvent.loadMore()';
}


}




/// @nodoc


class _Refresh implements DreamsEvent {
  const _Refresh([this.completer]);
  

 final  Completer<void>? completer;

/// Create a copy of DreamsEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RefreshCopyWith<_Refresh> get copyWith => __$RefreshCopyWithImpl<_Refresh>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Refresh&&(identical(other.completer, completer) || other.completer == completer));
}


@override
int get hashCode => Object.hash(runtimeType,completer);

@override
String toString() {
  return 'DreamsEvent.refresh(completer: $completer)';
}


}

/// @nodoc
abstract mixin class _$RefreshCopyWith<$Res> implements $DreamsEventCopyWith<$Res> {
  factory _$RefreshCopyWith(_Refresh value, $Res Function(_Refresh) _then) = __$RefreshCopyWithImpl;
@useResult
$Res call({
 Completer<void>? completer
});




}
/// @nodoc
class __$RefreshCopyWithImpl<$Res>
    implements _$RefreshCopyWith<$Res> {
  __$RefreshCopyWithImpl(this._self, this._then);

  final _Refresh _self;
  final $Res Function(_Refresh) _then;

/// Create a copy of DreamsEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? completer = freezed,}) {
  return _then(_Refresh(
freezed == completer ? _self.completer : completer // ignore: cast_nullable_to_non_nullable
as Completer<void>?,
  ));
}


}

/// @nodoc


class _Add implements DreamsEvent {
  const _Add(this.text);
  

 final  String text;

/// Create a copy of DreamsEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AddCopyWith<_Add> get copyWith => __$AddCopyWithImpl<_Add>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Add&&(identical(other.text, text) || other.text == text));
}


@override
int get hashCode => Object.hash(runtimeType,text);

@override
String toString() {
  return 'DreamsEvent.add(text: $text)';
}


}

/// @nodoc
abstract mixin class _$AddCopyWith<$Res> implements $DreamsEventCopyWith<$Res> {
  factory _$AddCopyWith(_Add value, $Res Function(_Add) _then) = __$AddCopyWithImpl;
@useResult
$Res call({
 String text
});




}
/// @nodoc
class __$AddCopyWithImpl<$Res>
    implements _$AddCopyWith<$Res> {
  __$AddCopyWithImpl(this._self, this._then);

  final _Add _self;
  final $Res Function(_Add) _then;

/// Create a copy of DreamsEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? text = null,}) {
  return _then(_Add(
null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _SearchChanged implements DreamsEvent {
  const _SearchChanged(this.query);
  

 final  String query;

/// Create a copy of DreamsEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SearchChangedCopyWith<_SearchChanged> get copyWith => __$SearchChangedCopyWithImpl<_SearchChanged>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SearchChanged&&(identical(other.query, query) || other.query == query));
}


@override
int get hashCode => Object.hash(runtimeType,query);

@override
String toString() {
  return 'DreamsEvent.searchChanged(query: $query)';
}


}

/// @nodoc
abstract mixin class _$SearchChangedCopyWith<$Res> implements $DreamsEventCopyWith<$Res> {
  factory _$SearchChangedCopyWith(_SearchChanged value, $Res Function(_SearchChanged) _then) = __$SearchChangedCopyWithImpl;
@useResult
$Res call({
 String query
});




}
/// @nodoc
class __$SearchChangedCopyWithImpl<$Res>
    implements _$SearchChangedCopyWith<$Res> {
  __$SearchChangedCopyWithImpl(this._self, this._then);

  final _SearchChanged _self;
  final $Res Function(_SearchChanged) _then;

/// Create a copy of DreamsEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? query = null,}) {
  return _then(_SearchChanged(
null == query ? _self.query : query // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _FilterChanged implements DreamsEvent {
  const _FilterChanged({this.status, this.startDate, this.endDate});
  

 final  bool? status;
 final  DateTime? startDate;
 final  DateTime? endDate;

/// Create a copy of DreamsEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FilterChangedCopyWith<_FilterChanged> get copyWith => __$FilterChangedCopyWithImpl<_FilterChanged>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FilterChanged&&(identical(other.status, status) || other.status == status)&&(identical(other.startDate, startDate) || other.startDate == startDate)&&(identical(other.endDate, endDate) || other.endDate == endDate));
}


@override
int get hashCode => Object.hash(runtimeType,status,startDate,endDate);

@override
String toString() {
  return 'DreamsEvent.filterChanged(status: $status, startDate: $startDate, endDate: $endDate)';
}


}

/// @nodoc
abstract mixin class _$FilterChangedCopyWith<$Res> implements $DreamsEventCopyWith<$Res> {
  factory _$FilterChangedCopyWith(_FilterChanged value, $Res Function(_FilterChanged) _then) = __$FilterChangedCopyWithImpl;
@useResult
$Res call({
 bool? status, DateTime? startDate, DateTime? endDate
});




}
/// @nodoc
class __$FilterChangedCopyWithImpl<$Res>
    implements _$FilterChangedCopyWith<$Res> {
  __$FilterChangedCopyWithImpl(this._self, this._then);

  final _FilterChanged _self;
  final $Res Function(_FilterChanged) _then;

/// Create a copy of DreamsEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? status = freezed,Object? startDate = freezed,Object? endDate = freezed,}) {
  return _then(_FilterChanged(
status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as bool?,startDate: freezed == startDate ? _self.startDate : startDate // ignore: cast_nullable_to_non_nullable
as DateTime?,endDate: freezed == endDate ? _self.endDate : endDate // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

/// @nodoc


class _Delete implements DreamsEvent {
  const _Delete(this.id);
  

 final  String id;

/// Create a copy of DreamsEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DeleteCopyWith<_Delete> get copyWith => __$DeleteCopyWithImpl<_Delete>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Delete&&(identical(other.id, id) || other.id == id));
}


@override
int get hashCode => Object.hash(runtimeType,id);

@override
String toString() {
  return 'DreamsEvent.delete(id: $id)';
}


}

/// @nodoc
abstract mixin class _$DeleteCopyWith<$Res> implements $DreamsEventCopyWith<$Res> {
  factory _$DeleteCopyWith(_Delete value, $Res Function(_Delete) _then) = __$DeleteCopyWithImpl;
@useResult
$Res call({
 String id
});




}
/// @nodoc
class __$DeleteCopyWithImpl<$Res>
    implements _$DeleteCopyWith<$Res> {
  __$DeleteCopyWithImpl(this._self, this._then);

  final _Delete _self;
  final $Res Function(_Delete) _then;

/// Create a copy of DreamsEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? id = null,}) {
  return _then(_Delete(
null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
mixin _$DreamsState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DreamsState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'DreamsState()';
}


}

/// @nodoc
class $DreamsStateCopyWith<$Res>  {
$DreamsStateCopyWith(DreamsState _, $Res Function(DreamsState) __);
}


/// Adds pattern-matching-related methods to [DreamsState].
extension DreamsStatePatterns on DreamsState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Initial value)?  initial,TResult Function( _Loading value)?  loading,TResult Function( _Loaded value)?  loaded,TResult Function( _Failure value)?  failure,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case _Loading() when loading != null:
return loading(_that);case _Loaded() when loaded != null:
return loaded(_that);case _Failure() when failure != null:
return failure(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Initial value)  initial,required TResult Function( _Loading value)  loading,required TResult Function( _Loaded value)  loaded,required TResult Function( _Failure value)  failure,}){
final _that = this;
switch (_that) {
case _Initial():
return initial(_that);case _Loading():
return loading(_that);case _Loaded():
return loaded(_that);case _Failure():
return failure(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Initial value)?  initial,TResult? Function( _Loading value)?  loading,TResult? Function( _Loaded value)?  loaded,TResult? Function( _Failure value)?  failure,}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case _Loading() when loading != null:
return loading(_that);case _Loaded() when loaded != null:
return loaded(_that);case _Failure() when failure != null:
return failure(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function( List<Dream> dreams,  String? nextCursor,  bool hasReachedMax,  bool isLoadingMore,  String? searchQuery,  bool? statusFilter,  DateTime? startDateFilter,  DateTime? endDateFilter,  bool isAdded,  bool isDeleted,  bool isSaving)?  loaded,TResult Function( String message)?  failure,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case _Loading() when loading != null:
return loading();case _Loaded() when loaded != null:
return loaded(_that.dreams,_that.nextCursor,_that.hasReachedMax,_that.isLoadingMore,_that.searchQuery,_that.statusFilter,_that.startDateFilter,_that.endDateFilter,_that.isAdded,_that.isDeleted,_that.isSaving);case _Failure() when failure != null:
return failure(_that.message);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function( List<Dream> dreams,  String? nextCursor,  bool hasReachedMax,  bool isLoadingMore,  String? searchQuery,  bool? statusFilter,  DateTime? startDateFilter,  DateTime? endDateFilter,  bool isAdded,  bool isDeleted,  bool isSaving)  loaded,required TResult Function( String message)  failure,}) {final _that = this;
switch (_that) {
case _Initial():
return initial();case _Loading():
return loading();case _Loaded():
return loaded(_that.dreams,_that.nextCursor,_that.hasReachedMax,_that.isLoadingMore,_that.searchQuery,_that.statusFilter,_that.startDateFilter,_that.endDateFilter,_that.isAdded,_that.isDeleted,_that.isSaving);case _Failure():
return failure(_that.message);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function( List<Dream> dreams,  String? nextCursor,  bool hasReachedMax,  bool isLoadingMore,  String? searchQuery,  bool? statusFilter,  DateTime? startDateFilter,  DateTime? endDateFilter,  bool isAdded,  bool isDeleted,  bool isSaving)?  loaded,TResult? Function( String message)?  failure,}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case _Loading() when loading != null:
return loading();case _Loaded() when loaded != null:
return loaded(_that.dreams,_that.nextCursor,_that.hasReachedMax,_that.isLoadingMore,_that.searchQuery,_that.statusFilter,_that.startDateFilter,_that.endDateFilter,_that.isAdded,_that.isDeleted,_that.isSaving);case _Failure() when failure != null:
return failure(_that.message);case _:
  return null;

}
}

}

/// @nodoc


class _Initial implements DreamsState {
  const _Initial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Initial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'DreamsState.initial()';
}


}




/// @nodoc


class _Loading implements DreamsState {
  const _Loading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Loading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'DreamsState.loading()';
}


}




/// @nodoc


class _Loaded implements DreamsState {
  const _Loaded({required final  List<Dream> dreams, this.nextCursor, this.hasReachedMax = false, this.isLoadingMore = false, this.searchQuery, this.statusFilter, this.startDateFilter, this.endDateFilter, this.isAdded = false, this.isDeleted = false, this.isSaving = false}): _dreams = dreams;
  

 final  List<Dream> _dreams;
 List<Dream> get dreams {
  if (_dreams is EqualUnmodifiableListView) return _dreams;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_dreams);
}

 final  String? nextCursor;
@JsonKey() final  bool hasReachedMax;
@JsonKey() final  bool isLoadingMore;
 final  String? searchQuery;
 final  bool? statusFilter;
 final  DateTime? startDateFilter;
 final  DateTime? endDateFilter;
@JsonKey() final  bool isAdded;
@JsonKey() final  bool isDeleted;
@JsonKey() final  bool isSaving;

/// Create a copy of DreamsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LoadedCopyWith<_Loaded> get copyWith => __$LoadedCopyWithImpl<_Loaded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Loaded&&const DeepCollectionEquality().equals(other._dreams, _dreams)&&(identical(other.nextCursor, nextCursor) || other.nextCursor == nextCursor)&&(identical(other.hasReachedMax, hasReachedMax) || other.hasReachedMax == hasReachedMax)&&(identical(other.isLoadingMore, isLoadingMore) || other.isLoadingMore == isLoadingMore)&&(identical(other.searchQuery, searchQuery) || other.searchQuery == searchQuery)&&(identical(other.statusFilter, statusFilter) || other.statusFilter == statusFilter)&&(identical(other.startDateFilter, startDateFilter) || other.startDateFilter == startDateFilter)&&(identical(other.endDateFilter, endDateFilter) || other.endDateFilter == endDateFilter)&&(identical(other.isAdded, isAdded) || other.isAdded == isAdded)&&(identical(other.isDeleted, isDeleted) || other.isDeleted == isDeleted)&&(identical(other.isSaving, isSaving) || other.isSaving == isSaving));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_dreams),nextCursor,hasReachedMax,isLoadingMore,searchQuery,statusFilter,startDateFilter,endDateFilter,isAdded,isDeleted,isSaving);

@override
String toString() {
  return 'DreamsState.loaded(dreams: $dreams, nextCursor: $nextCursor, hasReachedMax: $hasReachedMax, isLoadingMore: $isLoadingMore, searchQuery: $searchQuery, statusFilter: $statusFilter, startDateFilter: $startDateFilter, endDateFilter: $endDateFilter, isAdded: $isAdded, isDeleted: $isDeleted, isSaving: $isSaving)';
}


}

/// @nodoc
abstract mixin class _$LoadedCopyWith<$Res> implements $DreamsStateCopyWith<$Res> {
  factory _$LoadedCopyWith(_Loaded value, $Res Function(_Loaded) _then) = __$LoadedCopyWithImpl;
@useResult
$Res call({
 List<Dream> dreams, String? nextCursor, bool hasReachedMax, bool isLoadingMore, String? searchQuery, bool? statusFilter, DateTime? startDateFilter, DateTime? endDateFilter, bool isAdded, bool isDeleted, bool isSaving
});




}
/// @nodoc
class __$LoadedCopyWithImpl<$Res>
    implements _$LoadedCopyWith<$Res> {
  __$LoadedCopyWithImpl(this._self, this._then);

  final _Loaded _self;
  final $Res Function(_Loaded) _then;

/// Create a copy of DreamsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? dreams = null,Object? nextCursor = freezed,Object? hasReachedMax = null,Object? isLoadingMore = null,Object? searchQuery = freezed,Object? statusFilter = freezed,Object? startDateFilter = freezed,Object? endDateFilter = freezed,Object? isAdded = null,Object? isDeleted = null,Object? isSaving = null,}) {
  return _then(_Loaded(
dreams: null == dreams ? _self._dreams : dreams // ignore: cast_nullable_to_non_nullable
as List<Dream>,nextCursor: freezed == nextCursor ? _self.nextCursor : nextCursor // ignore: cast_nullable_to_non_nullable
as String?,hasReachedMax: null == hasReachedMax ? _self.hasReachedMax : hasReachedMax // ignore: cast_nullable_to_non_nullable
as bool,isLoadingMore: null == isLoadingMore ? _self.isLoadingMore : isLoadingMore // ignore: cast_nullable_to_non_nullable
as bool,searchQuery: freezed == searchQuery ? _self.searchQuery : searchQuery // ignore: cast_nullable_to_non_nullable
as String?,statusFilter: freezed == statusFilter ? _self.statusFilter : statusFilter // ignore: cast_nullable_to_non_nullable
as bool?,startDateFilter: freezed == startDateFilter ? _self.startDateFilter : startDateFilter // ignore: cast_nullable_to_non_nullable
as DateTime?,endDateFilter: freezed == endDateFilter ? _self.endDateFilter : endDateFilter // ignore: cast_nullable_to_non_nullable
as DateTime?,isAdded: null == isAdded ? _self.isAdded : isAdded // ignore: cast_nullable_to_non_nullable
as bool,isDeleted: null == isDeleted ? _self.isDeleted : isDeleted // ignore: cast_nullable_to_non_nullable
as bool,isSaving: null == isSaving ? _self.isSaving : isSaving // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

/// @nodoc


class _Failure implements DreamsState {
  const _Failure(this.message);
  

 final  String message;

/// Create a copy of DreamsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FailureCopyWith<_Failure> get copyWith => __$FailureCopyWithImpl<_Failure>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Failure&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'DreamsState.failure(message: $message)';
}


}

/// @nodoc
abstract mixin class _$FailureCopyWith<$Res> implements $DreamsStateCopyWith<$Res> {
  factory _$FailureCopyWith(_Failure value, $Res Function(_Failure) _then) = __$FailureCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class __$FailureCopyWithImpl<$Res>
    implements _$FailureCopyWith<$Res> {
  __$FailureCopyWithImpl(this._self, this._then);

  final _Failure _self;
  final $Res Function(_Failure) _then;

/// Create a copy of DreamsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(_Failure(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
