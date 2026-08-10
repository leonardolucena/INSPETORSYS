// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'inspection.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$Inspection {

 String get clientId; String? get serverId; String get workOrderId; String? get workOrderCode; double? get workOrderLatitude; double? get workOrderLongitude; InspectionSyncStatus get status; String? get notes; String? get photoPath; double? get latitude; double? get longitude; DateTime? get capturedAt; Map<String, dynamic>? get formData; InspectionFormSchema? get formSchema; String? get syncErrorMessage; DateTime get createdAt; DateTime get updatedAt; DateTime? get syncedAt;
/// Create a copy of Inspection
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$InspectionCopyWith<Inspection> get copyWith => _$InspectionCopyWithImpl<Inspection>(this as Inspection, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Inspection&&(identical(other.clientId, clientId) || other.clientId == clientId)&&(identical(other.serverId, serverId) || other.serverId == serverId)&&(identical(other.workOrderId, workOrderId) || other.workOrderId == workOrderId)&&(identical(other.workOrderCode, workOrderCode) || other.workOrderCode == workOrderCode)&&(identical(other.workOrderLatitude, workOrderLatitude) || other.workOrderLatitude == workOrderLatitude)&&(identical(other.workOrderLongitude, workOrderLongitude) || other.workOrderLongitude == workOrderLongitude)&&(identical(other.status, status) || other.status == status)&&(identical(other.notes, notes) || other.notes == notes)&&(identical(other.photoPath, photoPath) || other.photoPath == photoPath)&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude)&&(identical(other.capturedAt, capturedAt) || other.capturedAt == capturedAt)&&const DeepCollectionEquality().equals(other.formData, formData)&&(identical(other.formSchema, formSchema) || other.formSchema == formSchema)&&(identical(other.syncErrorMessage, syncErrorMessage) || other.syncErrorMessage == syncErrorMessage)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.syncedAt, syncedAt) || other.syncedAt == syncedAt));
}


@override
int get hashCode => Object.hash(runtimeType,clientId,serverId,workOrderId,workOrderCode,workOrderLatitude,workOrderLongitude,status,notes,photoPath,latitude,longitude,capturedAt,const DeepCollectionEquality().hash(formData),formSchema,syncErrorMessage,createdAt,updatedAt,syncedAt);

@override
String toString() {
  return 'Inspection(clientId: $clientId, serverId: $serverId, workOrderId: $workOrderId, workOrderCode: $workOrderCode, workOrderLatitude: $workOrderLatitude, workOrderLongitude: $workOrderLongitude, status: $status, notes: $notes, photoPath: $photoPath, latitude: $latitude, longitude: $longitude, capturedAt: $capturedAt, formData: $formData, formSchema: $formSchema, syncErrorMessage: $syncErrorMessage, createdAt: $createdAt, updatedAt: $updatedAt, syncedAt: $syncedAt)';
}


}

/// @nodoc
abstract mixin class $InspectionCopyWith<$Res>  {
  factory $InspectionCopyWith(Inspection value, $Res Function(Inspection) _then) = _$InspectionCopyWithImpl;
@useResult
$Res call({
 String clientId, String? serverId, String workOrderId, String? workOrderCode, double? workOrderLatitude, double? workOrderLongitude, InspectionSyncStatus status, String? notes, String? photoPath, double? latitude, double? longitude, DateTime? capturedAt, Map<String, dynamic>? formData, InspectionFormSchema? formSchema, String? syncErrorMessage, DateTime createdAt, DateTime updatedAt, DateTime? syncedAt
});


$InspectionFormSchemaCopyWith<$Res>? get formSchema;

}
/// @nodoc
class _$InspectionCopyWithImpl<$Res>
    implements $InspectionCopyWith<$Res> {
  _$InspectionCopyWithImpl(this._self, this._then);

  final Inspection _self;
  final $Res Function(Inspection) _then;

/// Create a copy of Inspection
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? clientId = null,Object? serverId = freezed,Object? workOrderId = null,Object? workOrderCode = freezed,Object? workOrderLatitude = freezed,Object? workOrderLongitude = freezed,Object? status = null,Object? notes = freezed,Object? photoPath = freezed,Object? latitude = freezed,Object? longitude = freezed,Object? capturedAt = freezed,Object? formData = freezed,Object? formSchema = freezed,Object? syncErrorMessage = freezed,Object? createdAt = null,Object? updatedAt = null,Object? syncedAt = freezed,}) {
  return _then(_self.copyWith(
clientId: null == clientId ? _self.clientId : clientId // ignore: cast_nullable_to_non_nullable
as String,serverId: freezed == serverId ? _self.serverId : serverId // ignore: cast_nullable_to_non_nullable
as String?,workOrderId: null == workOrderId ? _self.workOrderId : workOrderId // ignore: cast_nullable_to_non_nullable
as String,workOrderCode: freezed == workOrderCode ? _self.workOrderCode : workOrderCode // ignore: cast_nullable_to_non_nullable
as String?,workOrderLatitude: freezed == workOrderLatitude ? _self.workOrderLatitude : workOrderLatitude // ignore: cast_nullable_to_non_nullable
as double?,workOrderLongitude: freezed == workOrderLongitude ? _self.workOrderLongitude : workOrderLongitude // ignore: cast_nullable_to_non_nullable
as double?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as InspectionSyncStatus,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,photoPath: freezed == photoPath ? _self.photoPath : photoPath // ignore: cast_nullable_to_non_nullable
as String?,latitude: freezed == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double?,longitude: freezed == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double?,capturedAt: freezed == capturedAt ? _self.capturedAt : capturedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,formData: freezed == formData ? _self.formData : formData // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,formSchema: freezed == formSchema ? _self.formSchema : formSchema // ignore: cast_nullable_to_non_nullable
as InspectionFormSchema?,syncErrorMessage: freezed == syncErrorMessage ? _self.syncErrorMessage : syncErrorMessage // ignore: cast_nullable_to_non_nullable
as String?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,syncedAt: freezed == syncedAt ? _self.syncedAt : syncedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}
/// Create a copy of Inspection
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$InspectionFormSchemaCopyWith<$Res>? get formSchema {
    if (_self.formSchema == null) {
    return null;
  }

  return $InspectionFormSchemaCopyWith<$Res>(_self.formSchema!, (value) {
    return _then(_self.copyWith(formSchema: value));
  });
}
}


/// Adds pattern-matching-related methods to [Inspection].
extension InspectionPatterns on Inspection {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Inspection value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Inspection() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Inspection value)  $default,){
final _that = this;
switch (_that) {
case _Inspection():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Inspection value)?  $default,){
final _that = this;
switch (_that) {
case _Inspection() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String clientId,  String? serverId,  String workOrderId,  String? workOrderCode,  double? workOrderLatitude,  double? workOrderLongitude,  InspectionSyncStatus status,  String? notes,  String? photoPath,  double? latitude,  double? longitude,  DateTime? capturedAt,  Map<String, dynamic>? formData,  InspectionFormSchema? formSchema,  String? syncErrorMessage,  DateTime createdAt,  DateTime updatedAt,  DateTime? syncedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Inspection() when $default != null:
return $default(_that.clientId,_that.serverId,_that.workOrderId,_that.workOrderCode,_that.workOrderLatitude,_that.workOrderLongitude,_that.status,_that.notes,_that.photoPath,_that.latitude,_that.longitude,_that.capturedAt,_that.formData,_that.formSchema,_that.syncErrorMessage,_that.createdAt,_that.updatedAt,_that.syncedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String clientId,  String? serverId,  String workOrderId,  String? workOrderCode,  double? workOrderLatitude,  double? workOrderLongitude,  InspectionSyncStatus status,  String? notes,  String? photoPath,  double? latitude,  double? longitude,  DateTime? capturedAt,  Map<String, dynamic>? formData,  InspectionFormSchema? formSchema,  String? syncErrorMessage,  DateTime createdAt,  DateTime updatedAt,  DateTime? syncedAt)  $default,) {final _that = this;
switch (_that) {
case _Inspection():
return $default(_that.clientId,_that.serverId,_that.workOrderId,_that.workOrderCode,_that.workOrderLatitude,_that.workOrderLongitude,_that.status,_that.notes,_that.photoPath,_that.latitude,_that.longitude,_that.capturedAt,_that.formData,_that.formSchema,_that.syncErrorMessage,_that.createdAt,_that.updatedAt,_that.syncedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String clientId,  String? serverId,  String workOrderId,  String? workOrderCode,  double? workOrderLatitude,  double? workOrderLongitude,  InspectionSyncStatus status,  String? notes,  String? photoPath,  double? latitude,  double? longitude,  DateTime? capturedAt,  Map<String, dynamic>? formData,  InspectionFormSchema? formSchema,  String? syncErrorMessage,  DateTime createdAt,  DateTime updatedAt,  DateTime? syncedAt)?  $default,) {final _that = this;
switch (_that) {
case _Inspection() when $default != null:
return $default(_that.clientId,_that.serverId,_that.workOrderId,_that.workOrderCode,_that.workOrderLatitude,_that.workOrderLongitude,_that.status,_that.notes,_that.photoPath,_that.latitude,_that.longitude,_that.capturedAt,_that.formData,_that.formSchema,_that.syncErrorMessage,_that.createdAt,_that.updatedAt,_that.syncedAt);case _:
  return null;

}
}

}

/// @nodoc


class _Inspection implements Inspection {
  const _Inspection({required this.clientId, this.serverId, required this.workOrderId, this.workOrderCode, this.workOrderLatitude, this.workOrderLongitude, required this.status, this.notes, this.photoPath, this.latitude, this.longitude, this.capturedAt, final  Map<String, dynamic>? formData, this.formSchema, this.syncErrorMessage, required this.createdAt, required this.updatedAt, this.syncedAt}): _formData = formData;
  

@override final  String clientId;
@override final  String? serverId;
@override final  String workOrderId;
@override final  String? workOrderCode;
@override final  double? workOrderLatitude;
@override final  double? workOrderLongitude;
@override final  InspectionSyncStatus status;
@override final  String? notes;
@override final  String? photoPath;
@override final  double? latitude;
@override final  double? longitude;
@override final  DateTime? capturedAt;
 final  Map<String, dynamic>? _formData;
@override Map<String, dynamic>? get formData {
  final value = _formData;
  if (value == null) return null;
  if (_formData is EqualUnmodifiableMapView) return _formData;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}

@override final  InspectionFormSchema? formSchema;
@override final  String? syncErrorMessage;
@override final  DateTime createdAt;
@override final  DateTime updatedAt;
@override final  DateTime? syncedAt;

/// Create a copy of Inspection
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$InspectionCopyWith<_Inspection> get copyWith => __$InspectionCopyWithImpl<_Inspection>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Inspection&&(identical(other.clientId, clientId) || other.clientId == clientId)&&(identical(other.serverId, serverId) || other.serverId == serverId)&&(identical(other.workOrderId, workOrderId) || other.workOrderId == workOrderId)&&(identical(other.workOrderCode, workOrderCode) || other.workOrderCode == workOrderCode)&&(identical(other.workOrderLatitude, workOrderLatitude) || other.workOrderLatitude == workOrderLatitude)&&(identical(other.workOrderLongitude, workOrderLongitude) || other.workOrderLongitude == workOrderLongitude)&&(identical(other.status, status) || other.status == status)&&(identical(other.notes, notes) || other.notes == notes)&&(identical(other.photoPath, photoPath) || other.photoPath == photoPath)&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude)&&(identical(other.capturedAt, capturedAt) || other.capturedAt == capturedAt)&&const DeepCollectionEquality().equals(other._formData, _formData)&&(identical(other.formSchema, formSchema) || other.formSchema == formSchema)&&(identical(other.syncErrorMessage, syncErrorMessage) || other.syncErrorMessage == syncErrorMessage)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.syncedAt, syncedAt) || other.syncedAt == syncedAt));
}


@override
int get hashCode => Object.hash(runtimeType,clientId,serverId,workOrderId,workOrderCode,workOrderLatitude,workOrderLongitude,status,notes,photoPath,latitude,longitude,capturedAt,const DeepCollectionEquality().hash(_formData),formSchema,syncErrorMessage,createdAt,updatedAt,syncedAt);

@override
String toString() {
  return 'Inspection(clientId: $clientId, serverId: $serverId, workOrderId: $workOrderId, workOrderCode: $workOrderCode, workOrderLatitude: $workOrderLatitude, workOrderLongitude: $workOrderLongitude, status: $status, notes: $notes, photoPath: $photoPath, latitude: $latitude, longitude: $longitude, capturedAt: $capturedAt, formData: $formData, formSchema: $formSchema, syncErrorMessage: $syncErrorMessage, createdAt: $createdAt, updatedAt: $updatedAt, syncedAt: $syncedAt)';
}


}

/// @nodoc
abstract mixin class _$InspectionCopyWith<$Res> implements $InspectionCopyWith<$Res> {
  factory _$InspectionCopyWith(_Inspection value, $Res Function(_Inspection) _then) = __$InspectionCopyWithImpl;
@override @useResult
$Res call({
 String clientId, String? serverId, String workOrderId, String? workOrderCode, double? workOrderLatitude, double? workOrderLongitude, InspectionSyncStatus status, String? notes, String? photoPath, double? latitude, double? longitude, DateTime? capturedAt, Map<String, dynamic>? formData, InspectionFormSchema? formSchema, String? syncErrorMessage, DateTime createdAt, DateTime updatedAt, DateTime? syncedAt
});


@override $InspectionFormSchemaCopyWith<$Res>? get formSchema;

}
/// @nodoc
class __$InspectionCopyWithImpl<$Res>
    implements _$InspectionCopyWith<$Res> {
  __$InspectionCopyWithImpl(this._self, this._then);

  final _Inspection _self;
  final $Res Function(_Inspection) _then;

/// Create a copy of Inspection
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? clientId = null,Object? serverId = freezed,Object? workOrderId = null,Object? workOrderCode = freezed,Object? workOrderLatitude = freezed,Object? workOrderLongitude = freezed,Object? status = null,Object? notes = freezed,Object? photoPath = freezed,Object? latitude = freezed,Object? longitude = freezed,Object? capturedAt = freezed,Object? formData = freezed,Object? formSchema = freezed,Object? syncErrorMessage = freezed,Object? createdAt = null,Object? updatedAt = null,Object? syncedAt = freezed,}) {
  return _then(_Inspection(
clientId: null == clientId ? _self.clientId : clientId // ignore: cast_nullable_to_non_nullable
as String,serverId: freezed == serverId ? _self.serverId : serverId // ignore: cast_nullable_to_non_nullable
as String?,workOrderId: null == workOrderId ? _self.workOrderId : workOrderId // ignore: cast_nullable_to_non_nullable
as String,workOrderCode: freezed == workOrderCode ? _self.workOrderCode : workOrderCode // ignore: cast_nullable_to_non_nullable
as String?,workOrderLatitude: freezed == workOrderLatitude ? _self.workOrderLatitude : workOrderLatitude // ignore: cast_nullable_to_non_nullable
as double?,workOrderLongitude: freezed == workOrderLongitude ? _self.workOrderLongitude : workOrderLongitude // ignore: cast_nullable_to_non_nullable
as double?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as InspectionSyncStatus,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,photoPath: freezed == photoPath ? _self.photoPath : photoPath // ignore: cast_nullable_to_non_nullable
as String?,latitude: freezed == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double?,longitude: freezed == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double?,capturedAt: freezed == capturedAt ? _self.capturedAt : capturedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,formData: freezed == formData ? _self._formData : formData // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,formSchema: freezed == formSchema ? _self.formSchema : formSchema // ignore: cast_nullable_to_non_nullable
as InspectionFormSchema?,syncErrorMessage: freezed == syncErrorMessage ? _self.syncErrorMessage : syncErrorMessage // ignore: cast_nullable_to_non_nullable
as String?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,syncedAt: freezed == syncedAt ? _self.syncedAt : syncedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

/// Create a copy of Inspection
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$InspectionFormSchemaCopyWith<$Res>? get formSchema {
    if (_self.formSchema == null) {
    return null;
  }

  return $InspectionFormSchemaCopyWith<$Res>(_self.formSchema!, (value) {
    return _then(_self.copyWith(formSchema: value));
  });
}
}

// dart format on
