// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'inspection_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$InspectionDto {

 String get id; String get clientId; String get workOrderId;@JsonKey(name: 'observation') String? get notes; String? get condition; String? get photoUrl; double? get latitude; double? get longitude;@JsonKey(name: 'capturedAt') DateTime? get capturedAt; DateTime? get createdAt; DateTime? get updatedAt; DateTime? get syncedAt;
/// Create a copy of InspectionDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$InspectionDtoCopyWith<InspectionDto> get copyWith => _$InspectionDtoCopyWithImpl<InspectionDto>(this as InspectionDto, _$identity);

  /// Serializes this InspectionDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is InspectionDto&&(identical(other.id, id) || other.id == id)&&(identical(other.clientId, clientId) || other.clientId == clientId)&&(identical(other.workOrderId, workOrderId) || other.workOrderId == workOrderId)&&(identical(other.notes, notes) || other.notes == notes)&&(identical(other.condition, condition) || other.condition == condition)&&(identical(other.photoUrl, photoUrl) || other.photoUrl == photoUrl)&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude)&&(identical(other.capturedAt, capturedAt) || other.capturedAt == capturedAt)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.syncedAt, syncedAt) || other.syncedAt == syncedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,clientId,workOrderId,notes,condition,photoUrl,latitude,longitude,capturedAt,createdAt,updatedAt,syncedAt);

@override
String toString() {
  return 'InspectionDto(id: $id, clientId: $clientId, workOrderId: $workOrderId, notes: $notes, condition: $condition, photoUrl: $photoUrl, latitude: $latitude, longitude: $longitude, capturedAt: $capturedAt, createdAt: $createdAt, updatedAt: $updatedAt, syncedAt: $syncedAt)';
}


}

/// @nodoc
abstract mixin class $InspectionDtoCopyWith<$Res>  {
  factory $InspectionDtoCopyWith(InspectionDto value, $Res Function(InspectionDto) _then) = _$InspectionDtoCopyWithImpl;
@useResult
$Res call({
 String id, String clientId, String workOrderId,@JsonKey(name: 'observation') String? notes, String? condition, String? photoUrl, double? latitude, double? longitude,@JsonKey(name: 'capturedAt') DateTime? capturedAt, DateTime? createdAt, DateTime? updatedAt, DateTime? syncedAt
});




}
/// @nodoc
class _$InspectionDtoCopyWithImpl<$Res>
    implements $InspectionDtoCopyWith<$Res> {
  _$InspectionDtoCopyWithImpl(this._self, this._then);

  final InspectionDto _self;
  final $Res Function(InspectionDto) _then;

/// Create a copy of InspectionDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? clientId = null,Object? workOrderId = null,Object? notes = freezed,Object? condition = freezed,Object? photoUrl = freezed,Object? latitude = freezed,Object? longitude = freezed,Object? capturedAt = freezed,Object? createdAt = freezed,Object? updatedAt = freezed,Object? syncedAt = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,clientId: null == clientId ? _self.clientId : clientId // ignore: cast_nullable_to_non_nullable
as String,workOrderId: null == workOrderId ? _self.workOrderId : workOrderId // ignore: cast_nullable_to_non_nullable
as String,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,condition: freezed == condition ? _self.condition : condition // ignore: cast_nullable_to_non_nullable
as String?,photoUrl: freezed == photoUrl ? _self.photoUrl : photoUrl // ignore: cast_nullable_to_non_nullable
as String?,latitude: freezed == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double?,longitude: freezed == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double?,capturedAt: freezed == capturedAt ? _self.capturedAt : capturedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,syncedAt: freezed == syncedAt ? _self.syncedAt : syncedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [InspectionDto].
extension InspectionDtoPatterns on InspectionDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _InspectionDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _InspectionDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _InspectionDto value)  $default,){
final _that = this;
switch (_that) {
case _InspectionDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _InspectionDto value)?  $default,){
final _that = this;
switch (_that) {
case _InspectionDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String clientId,  String workOrderId, @JsonKey(name: 'observation')  String? notes,  String? condition,  String? photoUrl,  double? latitude,  double? longitude, @JsonKey(name: 'capturedAt')  DateTime? capturedAt,  DateTime? createdAt,  DateTime? updatedAt,  DateTime? syncedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _InspectionDto() when $default != null:
return $default(_that.id,_that.clientId,_that.workOrderId,_that.notes,_that.condition,_that.photoUrl,_that.latitude,_that.longitude,_that.capturedAt,_that.createdAt,_that.updatedAt,_that.syncedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String clientId,  String workOrderId, @JsonKey(name: 'observation')  String? notes,  String? condition,  String? photoUrl,  double? latitude,  double? longitude, @JsonKey(name: 'capturedAt')  DateTime? capturedAt,  DateTime? createdAt,  DateTime? updatedAt,  DateTime? syncedAt)  $default,) {final _that = this;
switch (_that) {
case _InspectionDto():
return $default(_that.id,_that.clientId,_that.workOrderId,_that.notes,_that.condition,_that.photoUrl,_that.latitude,_that.longitude,_that.capturedAt,_that.createdAt,_that.updatedAt,_that.syncedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String clientId,  String workOrderId, @JsonKey(name: 'observation')  String? notes,  String? condition,  String? photoUrl,  double? latitude,  double? longitude, @JsonKey(name: 'capturedAt')  DateTime? capturedAt,  DateTime? createdAt,  DateTime? updatedAt,  DateTime? syncedAt)?  $default,) {final _that = this;
switch (_that) {
case _InspectionDto() when $default != null:
return $default(_that.id,_that.clientId,_that.workOrderId,_that.notes,_that.condition,_that.photoUrl,_that.latitude,_that.longitude,_that.capturedAt,_that.createdAt,_that.updatedAt,_that.syncedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _InspectionDto implements InspectionDto {
  const _InspectionDto({required this.id, required this.clientId, required this.workOrderId, @JsonKey(name: 'observation') this.notes, this.condition, this.photoUrl, this.latitude, this.longitude, @JsonKey(name: 'capturedAt') this.capturedAt, this.createdAt, this.updatedAt, this.syncedAt});
  factory _InspectionDto.fromJson(Map<String, dynamic> json) => _$InspectionDtoFromJson(json);

@override final  String id;
@override final  String clientId;
@override final  String workOrderId;
@override@JsonKey(name: 'observation') final  String? notes;
@override final  String? condition;
@override final  String? photoUrl;
@override final  double? latitude;
@override final  double? longitude;
@override@JsonKey(name: 'capturedAt') final  DateTime? capturedAt;
@override final  DateTime? createdAt;
@override final  DateTime? updatedAt;
@override final  DateTime? syncedAt;

/// Create a copy of InspectionDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$InspectionDtoCopyWith<_InspectionDto> get copyWith => __$InspectionDtoCopyWithImpl<_InspectionDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$InspectionDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _InspectionDto&&(identical(other.id, id) || other.id == id)&&(identical(other.clientId, clientId) || other.clientId == clientId)&&(identical(other.workOrderId, workOrderId) || other.workOrderId == workOrderId)&&(identical(other.notes, notes) || other.notes == notes)&&(identical(other.condition, condition) || other.condition == condition)&&(identical(other.photoUrl, photoUrl) || other.photoUrl == photoUrl)&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude)&&(identical(other.capturedAt, capturedAt) || other.capturedAt == capturedAt)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.syncedAt, syncedAt) || other.syncedAt == syncedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,clientId,workOrderId,notes,condition,photoUrl,latitude,longitude,capturedAt,createdAt,updatedAt,syncedAt);

@override
String toString() {
  return 'InspectionDto(id: $id, clientId: $clientId, workOrderId: $workOrderId, notes: $notes, condition: $condition, photoUrl: $photoUrl, latitude: $latitude, longitude: $longitude, capturedAt: $capturedAt, createdAt: $createdAt, updatedAt: $updatedAt, syncedAt: $syncedAt)';
}


}

/// @nodoc
abstract mixin class _$InspectionDtoCopyWith<$Res> implements $InspectionDtoCopyWith<$Res> {
  factory _$InspectionDtoCopyWith(_InspectionDto value, $Res Function(_InspectionDto) _then) = __$InspectionDtoCopyWithImpl;
@override @useResult
$Res call({
 String id, String clientId, String workOrderId,@JsonKey(name: 'observation') String? notes, String? condition, String? photoUrl, double? latitude, double? longitude,@JsonKey(name: 'capturedAt') DateTime? capturedAt, DateTime? createdAt, DateTime? updatedAt, DateTime? syncedAt
});




}
/// @nodoc
class __$InspectionDtoCopyWithImpl<$Res>
    implements _$InspectionDtoCopyWith<$Res> {
  __$InspectionDtoCopyWithImpl(this._self, this._then);

  final _InspectionDto _self;
  final $Res Function(_InspectionDto) _then;

/// Create a copy of InspectionDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? clientId = null,Object? workOrderId = null,Object? notes = freezed,Object? condition = freezed,Object? photoUrl = freezed,Object? latitude = freezed,Object? longitude = freezed,Object? capturedAt = freezed,Object? createdAt = freezed,Object? updatedAt = freezed,Object? syncedAt = freezed,}) {
  return _then(_InspectionDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,clientId: null == clientId ? _self.clientId : clientId // ignore: cast_nullable_to_non_nullable
as String,workOrderId: null == workOrderId ? _self.workOrderId : workOrderId // ignore: cast_nullable_to_non_nullable
as String,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,condition: freezed == condition ? _self.condition : condition // ignore: cast_nullable_to_non_nullable
as String?,photoUrl: freezed == photoUrl ? _self.photoUrl : photoUrl // ignore: cast_nullable_to_non_nullable
as String?,latitude: freezed == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double?,longitude: freezed == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double?,capturedAt: freezed == capturedAt ? _self.capturedAt : capturedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,syncedAt: freezed == syncedAt ? _self.syncedAt : syncedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
