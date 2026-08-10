// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'work_order_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$WorkOrderDto {

 String get id; String get code; String get title; String? get description; String? get notes; String get address; WorkOrderPriority get priority; WorkOrderStatus get status; double? get latitude; double? get longitude; DateTime? get scheduledAt; DateTime? get createdAt; DateTime get updatedAt;
/// Create a copy of WorkOrderDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WorkOrderDtoCopyWith<WorkOrderDto> get copyWith => _$WorkOrderDtoCopyWithImpl<WorkOrderDto>(this as WorkOrderDto, _$identity);

  /// Serializes this WorkOrderDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WorkOrderDto&&(identical(other.id, id) || other.id == id)&&(identical(other.code, code) || other.code == code)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.notes, notes) || other.notes == notes)&&(identical(other.address, address) || other.address == address)&&(identical(other.priority, priority) || other.priority == priority)&&(identical(other.status, status) || other.status == status)&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude)&&(identical(other.scheduledAt, scheduledAt) || other.scheduledAt == scheduledAt)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,code,title,description,notes,address,priority,status,latitude,longitude,scheduledAt,createdAt,updatedAt);

@override
String toString() {
  return 'WorkOrderDto(id: $id, code: $code, title: $title, description: $description, notes: $notes, address: $address, priority: $priority, status: $status, latitude: $latitude, longitude: $longitude, scheduledAt: $scheduledAt, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class $WorkOrderDtoCopyWith<$Res>  {
  factory $WorkOrderDtoCopyWith(WorkOrderDto value, $Res Function(WorkOrderDto) _then) = _$WorkOrderDtoCopyWithImpl;
@useResult
$Res call({
 String id, String code, String title, String? description, String? notes, String address, WorkOrderPriority priority, WorkOrderStatus status, double? latitude, double? longitude, DateTime? scheduledAt, DateTime? createdAt, DateTime updatedAt
});




}
/// @nodoc
class _$WorkOrderDtoCopyWithImpl<$Res>
    implements $WorkOrderDtoCopyWith<$Res> {
  _$WorkOrderDtoCopyWithImpl(this._self, this._then);

  final WorkOrderDto _self;
  final $Res Function(WorkOrderDto) _then;

/// Create a copy of WorkOrderDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? code = null,Object? title = null,Object? description = freezed,Object? notes = freezed,Object? address = null,Object? priority = null,Object? status = null,Object? latitude = freezed,Object? longitude = freezed,Object? scheduledAt = freezed,Object? createdAt = freezed,Object? updatedAt = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,address: null == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String,priority: null == priority ? _self.priority : priority // ignore: cast_nullable_to_non_nullable
as WorkOrderPriority,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as WorkOrderStatus,latitude: freezed == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double?,longitude: freezed == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double?,scheduledAt: freezed == scheduledAt ? _self.scheduledAt : scheduledAt // ignore: cast_nullable_to_non_nullable
as DateTime?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [WorkOrderDto].
extension WorkOrderDtoPatterns on WorkOrderDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _WorkOrderDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _WorkOrderDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _WorkOrderDto value)  $default,){
final _that = this;
switch (_that) {
case _WorkOrderDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _WorkOrderDto value)?  $default,){
final _that = this;
switch (_that) {
case _WorkOrderDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String code,  String title,  String? description,  String? notes,  String address,  WorkOrderPriority priority,  WorkOrderStatus status,  double? latitude,  double? longitude,  DateTime? scheduledAt,  DateTime? createdAt,  DateTime updatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _WorkOrderDto() when $default != null:
return $default(_that.id,_that.code,_that.title,_that.description,_that.notes,_that.address,_that.priority,_that.status,_that.latitude,_that.longitude,_that.scheduledAt,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String code,  String title,  String? description,  String? notes,  String address,  WorkOrderPriority priority,  WorkOrderStatus status,  double? latitude,  double? longitude,  DateTime? scheduledAt,  DateTime? createdAt,  DateTime updatedAt)  $default,) {final _that = this;
switch (_that) {
case _WorkOrderDto():
return $default(_that.id,_that.code,_that.title,_that.description,_that.notes,_that.address,_that.priority,_that.status,_that.latitude,_that.longitude,_that.scheduledAt,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String code,  String title,  String? description,  String? notes,  String address,  WorkOrderPriority priority,  WorkOrderStatus status,  double? latitude,  double? longitude,  DateTime? scheduledAt,  DateTime? createdAt,  DateTime updatedAt)?  $default,) {final _that = this;
switch (_that) {
case _WorkOrderDto() when $default != null:
return $default(_that.id,_that.code,_that.title,_that.description,_that.notes,_that.address,_that.priority,_that.status,_that.latitude,_that.longitude,_that.scheduledAt,_that.createdAt,_that.updatedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _WorkOrderDto implements WorkOrderDto {
  const _WorkOrderDto({required this.id, required this.code, required this.title, this.description, this.notes, required this.address, required this.priority, required this.status, this.latitude, this.longitude, this.scheduledAt, this.createdAt, required this.updatedAt});
  factory _WorkOrderDto.fromJson(Map<String, dynamic> json) => _$WorkOrderDtoFromJson(json);

@override final  String id;
@override final  String code;
@override final  String title;
@override final  String? description;
@override final  String? notes;
@override final  String address;
@override final  WorkOrderPriority priority;
@override final  WorkOrderStatus status;
@override final  double? latitude;
@override final  double? longitude;
@override final  DateTime? scheduledAt;
@override final  DateTime? createdAt;
@override final  DateTime updatedAt;

/// Create a copy of WorkOrderDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WorkOrderDtoCopyWith<_WorkOrderDto> get copyWith => __$WorkOrderDtoCopyWithImpl<_WorkOrderDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$WorkOrderDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _WorkOrderDto&&(identical(other.id, id) || other.id == id)&&(identical(other.code, code) || other.code == code)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.notes, notes) || other.notes == notes)&&(identical(other.address, address) || other.address == address)&&(identical(other.priority, priority) || other.priority == priority)&&(identical(other.status, status) || other.status == status)&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude)&&(identical(other.scheduledAt, scheduledAt) || other.scheduledAt == scheduledAt)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,code,title,description,notes,address,priority,status,latitude,longitude,scheduledAt,createdAt,updatedAt);

@override
String toString() {
  return 'WorkOrderDto(id: $id, code: $code, title: $title, description: $description, notes: $notes, address: $address, priority: $priority, status: $status, latitude: $latitude, longitude: $longitude, scheduledAt: $scheduledAt, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$WorkOrderDtoCopyWith<$Res> implements $WorkOrderDtoCopyWith<$Res> {
  factory _$WorkOrderDtoCopyWith(_WorkOrderDto value, $Res Function(_WorkOrderDto) _then) = __$WorkOrderDtoCopyWithImpl;
@override @useResult
$Res call({
 String id, String code, String title, String? description, String? notes, String address, WorkOrderPriority priority, WorkOrderStatus status, double? latitude, double? longitude, DateTime? scheduledAt, DateTime? createdAt, DateTime updatedAt
});




}
/// @nodoc
class __$WorkOrderDtoCopyWithImpl<$Res>
    implements _$WorkOrderDtoCopyWith<$Res> {
  __$WorkOrderDtoCopyWithImpl(this._self, this._then);

  final _WorkOrderDto _self;
  final $Res Function(_WorkOrderDto) _then;

/// Create a copy of WorkOrderDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? code = null,Object? title = null,Object? description = freezed,Object? notes = freezed,Object? address = null,Object? priority = null,Object? status = null,Object? latitude = freezed,Object? longitude = freezed,Object? scheduledAt = freezed,Object? createdAt = freezed,Object? updatedAt = null,}) {
  return _then(_WorkOrderDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,address: null == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String,priority: null == priority ? _self.priority : priority // ignore: cast_nullable_to_non_nullable
as WorkOrderPriority,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as WorkOrderStatus,latitude: freezed == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double?,longitude: freezed == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double?,scheduledAt: freezed == scheduledAt ? _self.scheduledAt : scheduledAt // ignore: cast_nullable_to_non_nullable
as DateTime?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
