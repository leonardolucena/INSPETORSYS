// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'sync_queue_item.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SyncQueueItem {

 int get id; String get inspectionClientId; String get status; int get retryCount; DateTime? get lastAttemptAt; DateTime? get nextRetryAt; String? get lastErrorMessage;
/// Create a copy of SyncQueueItem
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SyncQueueItemCopyWith<SyncQueueItem> get copyWith => _$SyncQueueItemCopyWithImpl<SyncQueueItem>(this as SyncQueueItem, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SyncQueueItem&&(identical(other.id, id) || other.id == id)&&(identical(other.inspectionClientId, inspectionClientId) || other.inspectionClientId == inspectionClientId)&&(identical(other.status, status) || other.status == status)&&(identical(other.retryCount, retryCount) || other.retryCount == retryCount)&&(identical(other.lastAttemptAt, lastAttemptAt) || other.lastAttemptAt == lastAttemptAt)&&(identical(other.nextRetryAt, nextRetryAt) || other.nextRetryAt == nextRetryAt)&&(identical(other.lastErrorMessage, lastErrorMessage) || other.lastErrorMessage == lastErrorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,id,inspectionClientId,status,retryCount,lastAttemptAt,nextRetryAt,lastErrorMessage);

@override
String toString() {
  return 'SyncQueueItem(id: $id, inspectionClientId: $inspectionClientId, status: $status, retryCount: $retryCount, lastAttemptAt: $lastAttemptAt, nextRetryAt: $nextRetryAt, lastErrorMessage: $lastErrorMessage)';
}


}

/// @nodoc
abstract mixin class $SyncQueueItemCopyWith<$Res>  {
  factory $SyncQueueItemCopyWith(SyncQueueItem value, $Res Function(SyncQueueItem) _then) = _$SyncQueueItemCopyWithImpl;
@useResult
$Res call({
 int id, String inspectionClientId, String status, int retryCount, DateTime? lastAttemptAt, DateTime? nextRetryAt, String? lastErrorMessage
});




}
/// @nodoc
class _$SyncQueueItemCopyWithImpl<$Res>
    implements $SyncQueueItemCopyWith<$Res> {
  _$SyncQueueItemCopyWithImpl(this._self, this._then);

  final SyncQueueItem _self;
  final $Res Function(SyncQueueItem) _then;

/// Create a copy of SyncQueueItem
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? inspectionClientId = null,Object? status = null,Object? retryCount = null,Object? lastAttemptAt = freezed,Object? nextRetryAt = freezed,Object? lastErrorMessage = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,inspectionClientId: null == inspectionClientId ? _self.inspectionClientId : inspectionClientId // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,retryCount: null == retryCount ? _self.retryCount : retryCount // ignore: cast_nullable_to_non_nullable
as int,lastAttemptAt: freezed == lastAttemptAt ? _self.lastAttemptAt : lastAttemptAt // ignore: cast_nullable_to_non_nullable
as DateTime?,nextRetryAt: freezed == nextRetryAt ? _self.nextRetryAt : nextRetryAt // ignore: cast_nullable_to_non_nullable
as DateTime?,lastErrorMessage: freezed == lastErrorMessage ? _self.lastErrorMessage : lastErrorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [SyncQueueItem].
extension SyncQueueItemPatterns on SyncQueueItem {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SyncQueueItem value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SyncQueueItem() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SyncQueueItem value)  $default,){
final _that = this;
switch (_that) {
case _SyncQueueItem():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SyncQueueItem value)?  $default,){
final _that = this;
switch (_that) {
case _SyncQueueItem() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String inspectionClientId,  String status,  int retryCount,  DateTime? lastAttemptAt,  DateTime? nextRetryAt,  String? lastErrorMessage)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SyncQueueItem() when $default != null:
return $default(_that.id,_that.inspectionClientId,_that.status,_that.retryCount,_that.lastAttemptAt,_that.nextRetryAt,_that.lastErrorMessage);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String inspectionClientId,  String status,  int retryCount,  DateTime? lastAttemptAt,  DateTime? nextRetryAt,  String? lastErrorMessage)  $default,) {final _that = this;
switch (_that) {
case _SyncQueueItem():
return $default(_that.id,_that.inspectionClientId,_that.status,_that.retryCount,_that.lastAttemptAt,_that.nextRetryAt,_that.lastErrorMessage);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String inspectionClientId,  String status,  int retryCount,  DateTime? lastAttemptAt,  DateTime? nextRetryAt,  String? lastErrorMessage)?  $default,) {final _that = this;
switch (_that) {
case _SyncQueueItem() when $default != null:
return $default(_that.id,_that.inspectionClientId,_that.status,_that.retryCount,_that.lastAttemptAt,_that.nextRetryAt,_that.lastErrorMessage);case _:
  return null;

}
}

}

/// @nodoc


class _SyncQueueItem implements SyncQueueItem {
  const _SyncQueueItem({required this.id, required this.inspectionClientId, required this.status, required this.retryCount, this.lastAttemptAt, this.nextRetryAt, this.lastErrorMessage});
  

@override final  int id;
@override final  String inspectionClientId;
@override final  String status;
@override final  int retryCount;
@override final  DateTime? lastAttemptAt;
@override final  DateTime? nextRetryAt;
@override final  String? lastErrorMessage;

/// Create a copy of SyncQueueItem
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SyncQueueItemCopyWith<_SyncQueueItem> get copyWith => __$SyncQueueItemCopyWithImpl<_SyncQueueItem>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SyncQueueItem&&(identical(other.id, id) || other.id == id)&&(identical(other.inspectionClientId, inspectionClientId) || other.inspectionClientId == inspectionClientId)&&(identical(other.status, status) || other.status == status)&&(identical(other.retryCount, retryCount) || other.retryCount == retryCount)&&(identical(other.lastAttemptAt, lastAttemptAt) || other.lastAttemptAt == lastAttemptAt)&&(identical(other.nextRetryAt, nextRetryAt) || other.nextRetryAt == nextRetryAt)&&(identical(other.lastErrorMessage, lastErrorMessage) || other.lastErrorMessage == lastErrorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,id,inspectionClientId,status,retryCount,lastAttemptAt,nextRetryAt,lastErrorMessage);

@override
String toString() {
  return 'SyncQueueItem(id: $id, inspectionClientId: $inspectionClientId, status: $status, retryCount: $retryCount, lastAttemptAt: $lastAttemptAt, nextRetryAt: $nextRetryAt, lastErrorMessage: $lastErrorMessage)';
}


}

/// @nodoc
abstract mixin class _$SyncQueueItemCopyWith<$Res> implements $SyncQueueItemCopyWith<$Res> {
  factory _$SyncQueueItemCopyWith(_SyncQueueItem value, $Res Function(_SyncQueueItem) _then) = __$SyncQueueItemCopyWithImpl;
@override @useResult
$Res call({
 int id, String inspectionClientId, String status, int retryCount, DateTime? lastAttemptAt, DateTime? nextRetryAt, String? lastErrorMessage
});




}
/// @nodoc
class __$SyncQueueItemCopyWithImpl<$Res>
    implements _$SyncQueueItemCopyWith<$Res> {
  __$SyncQueueItemCopyWithImpl(this._self, this._then);

  final _SyncQueueItem _self;
  final $Res Function(_SyncQueueItem) _then;

/// Create a copy of SyncQueueItem
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? inspectionClientId = null,Object? status = null,Object? retryCount = null,Object? lastAttemptAt = freezed,Object? nextRetryAt = freezed,Object? lastErrorMessage = freezed,}) {
  return _then(_SyncQueueItem(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,inspectionClientId: null == inspectionClientId ? _self.inspectionClientId : inspectionClientId // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,retryCount: null == retryCount ? _self.retryCount : retryCount // ignore: cast_nullable_to_non_nullable
as int,lastAttemptAt: freezed == lastAttemptAt ? _self.lastAttemptAt : lastAttemptAt // ignore: cast_nullable_to_non_nullable
as DateTime?,nextRetryAt: freezed == nextRetryAt ? _self.nextRetryAt : nextRetryAt // ignore: cast_nullable_to_non_nullable
as DateTime?,lastErrorMessage: freezed == lastErrorMessage ? _self.lastErrorMessage : lastErrorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
