// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'inspection_sync_result.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$InspectionSyncResult {

 int get processed; int get synced; int get keptPending; int get markedFailed; int get skipped;
/// Create a copy of InspectionSyncResult
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$InspectionSyncResultCopyWith<InspectionSyncResult> get copyWith => _$InspectionSyncResultCopyWithImpl<InspectionSyncResult>(this as InspectionSyncResult, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is InspectionSyncResult&&(identical(other.processed, processed) || other.processed == processed)&&(identical(other.synced, synced) || other.synced == synced)&&(identical(other.keptPending, keptPending) || other.keptPending == keptPending)&&(identical(other.markedFailed, markedFailed) || other.markedFailed == markedFailed)&&(identical(other.skipped, skipped) || other.skipped == skipped));
}


@override
int get hashCode => Object.hash(runtimeType,processed,synced,keptPending,markedFailed,skipped);

@override
String toString() {
  return 'InspectionSyncResult(processed: $processed, synced: $synced, keptPending: $keptPending, markedFailed: $markedFailed, skipped: $skipped)';
}


}

/// @nodoc
abstract mixin class $InspectionSyncResultCopyWith<$Res>  {
  factory $InspectionSyncResultCopyWith(InspectionSyncResult value, $Res Function(InspectionSyncResult) _then) = _$InspectionSyncResultCopyWithImpl;
@useResult
$Res call({
 int processed, int synced, int keptPending, int markedFailed, int skipped
});




}
/// @nodoc
class _$InspectionSyncResultCopyWithImpl<$Res>
    implements $InspectionSyncResultCopyWith<$Res> {
  _$InspectionSyncResultCopyWithImpl(this._self, this._then);

  final InspectionSyncResult _self;
  final $Res Function(InspectionSyncResult) _then;

/// Create a copy of InspectionSyncResult
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? processed = null,Object? synced = null,Object? keptPending = null,Object? markedFailed = null,Object? skipped = null,}) {
  return _then(_self.copyWith(
processed: null == processed ? _self.processed : processed // ignore: cast_nullable_to_non_nullable
as int,synced: null == synced ? _self.synced : synced // ignore: cast_nullable_to_non_nullable
as int,keptPending: null == keptPending ? _self.keptPending : keptPending // ignore: cast_nullable_to_non_nullable
as int,markedFailed: null == markedFailed ? _self.markedFailed : markedFailed // ignore: cast_nullable_to_non_nullable
as int,skipped: null == skipped ? _self.skipped : skipped // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [InspectionSyncResult].
extension InspectionSyncResultPatterns on InspectionSyncResult {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _InspectionSyncResult value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _InspectionSyncResult() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _InspectionSyncResult value)  $default,){
final _that = this;
switch (_that) {
case _InspectionSyncResult():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _InspectionSyncResult value)?  $default,){
final _that = this;
switch (_that) {
case _InspectionSyncResult() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int processed,  int synced,  int keptPending,  int markedFailed,  int skipped)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _InspectionSyncResult() when $default != null:
return $default(_that.processed,_that.synced,_that.keptPending,_that.markedFailed,_that.skipped);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int processed,  int synced,  int keptPending,  int markedFailed,  int skipped)  $default,) {final _that = this;
switch (_that) {
case _InspectionSyncResult():
return $default(_that.processed,_that.synced,_that.keptPending,_that.markedFailed,_that.skipped);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int processed,  int synced,  int keptPending,  int markedFailed,  int skipped)?  $default,) {final _that = this;
switch (_that) {
case _InspectionSyncResult() when $default != null:
return $default(_that.processed,_that.synced,_that.keptPending,_that.markedFailed,_that.skipped);case _:
  return null;

}
}

}

/// @nodoc


class _InspectionSyncResult implements InspectionSyncResult {
  const _InspectionSyncResult({this.processed = 0, this.synced = 0, this.keptPending = 0, this.markedFailed = 0, this.skipped = 0});
  

@override@JsonKey() final  int processed;
@override@JsonKey() final  int synced;
@override@JsonKey() final  int keptPending;
@override@JsonKey() final  int markedFailed;
@override@JsonKey() final  int skipped;

/// Create a copy of InspectionSyncResult
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$InspectionSyncResultCopyWith<_InspectionSyncResult> get copyWith => __$InspectionSyncResultCopyWithImpl<_InspectionSyncResult>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _InspectionSyncResult&&(identical(other.processed, processed) || other.processed == processed)&&(identical(other.synced, synced) || other.synced == synced)&&(identical(other.keptPending, keptPending) || other.keptPending == keptPending)&&(identical(other.markedFailed, markedFailed) || other.markedFailed == markedFailed)&&(identical(other.skipped, skipped) || other.skipped == skipped));
}


@override
int get hashCode => Object.hash(runtimeType,processed,synced,keptPending,markedFailed,skipped);

@override
String toString() {
  return 'InspectionSyncResult(processed: $processed, synced: $synced, keptPending: $keptPending, markedFailed: $markedFailed, skipped: $skipped)';
}


}

/// @nodoc
abstract mixin class _$InspectionSyncResultCopyWith<$Res> implements $InspectionSyncResultCopyWith<$Res> {
  factory _$InspectionSyncResultCopyWith(_InspectionSyncResult value, $Res Function(_InspectionSyncResult) _then) = __$InspectionSyncResultCopyWithImpl;
@override @useResult
$Res call({
 int processed, int synced, int keptPending, int markedFailed, int skipped
});




}
/// @nodoc
class __$InspectionSyncResultCopyWithImpl<$Res>
    implements _$InspectionSyncResultCopyWith<$Res> {
  __$InspectionSyncResultCopyWithImpl(this._self, this._then);

  final _InspectionSyncResult _self;
  final $Res Function(_InspectionSyncResult) _then;

/// Create a copy of InspectionSyncResult
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? processed = null,Object? synced = null,Object? keptPending = null,Object? markedFailed = null,Object? skipped = null,}) {
  return _then(_InspectionSyncResult(
processed: null == processed ? _self.processed : processed // ignore: cast_nullable_to_non_nullable
as int,synced: null == synced ? _self.synced : synced // ignore: cast_nullable_to_non_nullable
as int,keptPending: null == keptPending ? _self.keptPending : keptPending // ignore: cast_nullable_to_non_nullable
as int,markedFailed: null == markedFailed ? _self.markedFailed : markedFailed // ignore: cast_nullable_to_non_nullable
as int,skipped: null == skipped ? _self.skipped : skipped // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
