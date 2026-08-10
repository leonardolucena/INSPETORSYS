// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'inspection_form_schema_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$InspectionFormFieldSchemaDto {

 String get key; String get type; String get label;@JsonKey(name: 'required') bool get isRequired; int? get minLength; List<String>? get options;
/// Create a copy of InspectionFormFieldSchemaDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$InspectionFormFieldSchemaDtoCopyWith<InspectionFormFieldSchemaDto> get copyWith => _$InspectionFormFieldSchemaDtoCopyWithImpl<InspectionFormFieldSchemaDto>(this as InspectionFormFieldSchemaDto, _$identity);

  /// Serializes this InspectionFormFieldSchemaDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is InspectionFormFieldSchemaDto&&(identical(other.key, key) || other.key == key)&&(identical(other.type, type) || other.type == type)&&(identical(other.label, label) || other.label == label)&&(identical(other.isRequired, isRequired) || other.isRequired == isRequired)&&(identical(other.minLength, minLength) || other.minLength == minLength)&&const DeepCollectionEquality().equals(other.options, options));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,key,type,label,isRequired,minLength,const DeepCollectionEquality().hash(options));

@override
String toString() {
  return 'InspectionFormFieldSchemaDto(key: $key, type: $type, label: $label, isRequired: $isRequired, minLength: $minLength, options: $options)';
}


}

/// @nodoc
abstract mixin class $InspectionFormFieldSchemaDtoCopyWith<$Res>  {
  factory $InspectionFormFieldSchemaDtoCopyWith(InspectionFormFieldSchemaDto value, $Res Function(InspectionFormFieldSchemaDto) _then) = _$InspectionFormFieldSchemaDtoCopyWithImpl;
@useResult
$Res call({
 String key, String type, String label,@JsonKey(name: 'required') bool isRequired, int? minLength, List<String>? options
});




}
/// @nodoc
class _$InspectionFormFieldSchemaDtoCopyWithImpl<$Res>
    implements $InspectionFormFieldSchemaDtoCopyWith<$Res> {
  _$InspectionFormFieldSchemaDtoCopyWithImpl(this._self, this._then);

  final InspectionFormFieldSchemaDto _self;
  final $Res Function(InspectionFormFieldSchemaDto) _then;

/// Create a copy of InspectionFormFieldSchemaDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? key = null,Object? type = null,Object? label = null,Object? isRequired = null,Object? minLength = freezed,Object? options = freezed,}) {
  return _then(_self.copyWith(
key: null == key ? _self.key : key // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,isRequired: null == isRequired ? _self.isRequired : isRequired // ignore: cast_nullable_to_non_nullable
as bool,minLength: freezed == minLength ? _self.minLength : minLength // ignore: cast_nullable_to_non_nullable
as int?,options: freezed == options ? _self.options : options // ignore: cast_nullable_to_non_nullable
as List<String>?,
  ));
}

}


/// Adds pattern-matching-related methods to [InspectionFormFieldSchemaDto].
extension InspectionFormFieldSchemaDtoPatterns on InspectionFormFieldSchemaDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _InspectionFormFieldSchemaDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _InspectionFormFieldSchemaDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _InspectionFormFieldSchemaDto value)  $default,){
final _that = this;
switch (_that) {
case _InspectionFormFieldSchemaDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _InspectionFormFieldSchemaDto value)?  $default,){
final _that = this;
switch (_that) {
case _InspectionFormFieldSchemaDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String key,  String type,  String label, @JsonKey(name: 'required')  bool isRequired,  int? minLength,  List<String>? options)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _InspectionFormFieldSchemaDto() when $default != null:
return $default(_that.key,_that.type,_that.label,_that.isRequired,_that.minLength,_that.options);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String key,  String type,  String label, @JsonKey(name: 'required')  bool isRequired,  int? minLength,  List<String>? options)  $default,) {final _that = this;
switch (_that) {
case _InspectionFormFieldSchemaDto():
return $default(_that.key,_that.type,_that.label,_that.isRequired,_that.minLength,_that.options);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String key,  String type,  String label, @JsonKey(name: 'required')  bool isRequired,  int? minLength,  List<String>? options)?  $default,) {final _that = this;
switch (_that) {
case _InspectionFormFieldSchemaDto() when $default != null:
return $default(_that.key,_that.type,_that.label,_that.isRequired,_that.minLength,_that.options);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _InspectionFormFieldSchemaDto implements InspectionFormFieldSchemaDto {
  const _InspectionFormFieldSchemaDto({required this.key, required this.type, required this.label, @JsonKey(name: 'required') this.isRequired = false, this.minLength, final  List<String>? options}): _options = options;
  factory _InspectionFormFieldSchemaDto.fromJson(Map<String, dynamic> json) => _$InspectionFormFieldSchemaDtoFromJson(json);

@override final  String key;
@override final  String type;
@override final  String label;
@override@JsonKey(name: 'required') final  bool isRequired;
@override final  int? minLength;
 final  List<String>? _options;
@override List<String>? get options {
  final value = _options;
  if (value == null) return null;
  if (_options is EqualUnmodifiableListView) return _options;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}


/// Create a copy of InspectionFormFieldSchemaDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$InspectionFormFieldSchemaDtoCopyWith<_InspectionFormFieldSchemaDto> get copyWith => __$InspectionFormFieldSchemaDtoCopyWithImpl<_InspectionFormFieldSchemaDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$InspectionFormFieldSchemaDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _InspectionFormFieldSchemaDto&&(identical(other.key, key) || other.key == key)&&(identical(other.type, type) || other.type == type)&&(identical(other.label, label) || other.label == label)&&(identical(other.isRequired, isRequired) || other.isRequired == isRequired)&&(identical(other.minLength, minLength) || other.minLength == minLength)&&const DeepCollectionEquality().equals(other._options, _options));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,key,type,label,isRequired,minLength,const DeepCollectionEquality().hash(_options));

@override
String toString() {
  return 'InspectionFormFieldSchemaDto(key: $key, type: $type, label: $label, isRequired: $isRequired, minLength: $minLength, options: $options)';
}


}

/// @nodoc
abstract mixin class _$InspectionFormFieldSchemaDtoCopyWith<$Res> implements $InspectionFormFieldSchemaDtoCopyWith<$Res> {
  factory _$InspectionFormFieldSchemaDtoCopyWith(_InspectionFormFieldSchemaDto value, $Res Function(_InspectionFormFieldSchemaDto) _then) = __$InspectionFormFieldSchemaDtoCopyWithImpl;
@override @useResult
$Res call({
 String key, String type, String label,@JsonKey(name: 'required') bool isRequired, int? minLength, List<String>? options
});




}
/// @nodoc
class __$InspectionFormFieldSchemaDtoCopyWithImpl<$Res>
    implements _$InspectionFormFieldSchemaDtoCopyWith<$Res> {
  __$InspectionFormFieldSchemaDtoCopyWithImpl(this._self, this._then);

  final _InspectionFormFieldSchemaDto _self;
  final $Res Function(_InspectionFormFieldSchemaDto) _then;

/// Create a copy of InspectionFormFieldSchemaDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? key = null,Object? type = null,Object? label = null,Object? isRequired = null,Object? minLength = freezed,Object? options = freezed,}) {
  return _then(_InspectionFormFieldSchemaDto(
key: null == key ? _self.key : key // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,isRequired: null == isRequired ? _self.isRequired : isRequired // ignore: cast_nullable_to_non_nullable
as bool,minLength: freezed == minLength ? _self.minLength : minLength // ignore: cast_nullable_to_non_nullable
as int?,options: freezed == options ? _self._options : options // ignore: cast_nullable_to_non_nullable
as List<String>?,
  ));
}


}


/// @nodoc
mixin _$InspectionFormSchemaDto {

 String get workOrderId; List<InspectionFormFieldSchemaDto> get fields;
/// Create a copy of InspectionFormSchemaDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$InspectionFormSchemaDtoCopyWith<InspectionFormSchemaDto> get copyWith => _$InspectionFormSchemaDtoCopyWithImpl<InspectionFormSchemaDto>(this as InspectionFormSchemaDto, _$identity);

  /// Serializes this InspectionFormSchemaDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is InspectionFormSchemaDto&&(identical(other.workOrderId, workOrderId) || other.workOrderId == workOrderId)&&const DeepCollectionEquality().equals(other.fields, fields));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,workOrderId,const DeepCollectionEquality().hash(fields));

@override
String toString() {
  return 'InspectionFormSchemaDto(workOrderId: $workOrderId, fields: $fields)';
}


}

/// @nodoc
abstract mixin class $InspectionFormSchemaDtoCopyWith<$Res>  {
  factory $InspectionFormSchemaDtoCopyWith(InspectionFormSchemaDto value, $Res Function(InspectionFormSchemaDto) _then) = _$InspectionFormSchemaDtoCopyWithImpl;
@useResult
$Res call({
 String workOrderId, List<InspectionFormFieldSchemaDto> fields
});




}
/// @nodoc
class _$InspectionFormSchemaDtoCopyWithImpl<$Res>
    implements $InspectionFormSchemaDtoCopyWith<$Res> {
  _$InspectionFormSchemaDtoCopyWithImpl(this._self, this._then);

  final InspectionFormSchemaDto _self;
  final $Res Function(InspectionFormSchemaDto) _then;

/// Create a copy of InspectionFormSchemaDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? workOrderId = null,Object? fields = null,}) {
  return _then(_self.copyWith(
workOrderId: null == workOrderId ? _self.workOrderId : workOrderId // ignore: cast_nullable_to_non_nullable
as String,fields: null == fields ? _self.fields : fields // ignore: cast_nullable_to_non_nullable
as List<InspectionFormFieldSchemaDto>,
  ));
}

}


/// Adds pattern-matching-related methods to [InspectionFormSchemaDto].
extension InspectionFormSchemaDtoPatterns on InspectionFormSchemaDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _InspectionFormSchemaDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _InspectionFormSchemaDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _InspectionFormSchemaDto value)  $default,){
final _that = this;
switch (_that) {
case _InspectionFormSchemaDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _InspectionFormSchemaDto value)?  $default,){
final _that = this;
switch (_that) {
case _InspectionFormSchemaDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String workOrderId,  List<InspectionFormFieldSchemaDto> fields)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _InspectionFormSchemaDto() when $default != null:
return $default(_that.workOrderId,_that.fields);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String workOrderId,  List<InspectionFormFieldSchemaDto> fields)  $default,) {final _that = this;
switch (_that) {
case _InspectionFormSchemaDto():
return $default(_that.workOrderId,_that.fields);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String workOrderId,  List<InspectionFormFieldSchemaDto> fields)?  $default,) {final _that = this;
switch (_that) {
case _InspectionFormSchemaDto() when $default != null:
return $default(_that.workOrderId,_that.fields);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _InspectionFormSchemaDto implements InspectionFormSchemaDto {
  const _InspectionFormSchemaDto({required this.workOrderId, required final  List<InspectionFormFieldSchemaDto> fields}): _fields = fields;
  factory _InspectionFormSchemaDto.fromJson(Map<String, dynamic> json) => _$InspectionFormSchemaDtoFromJson(json);

@override final  String workOrderId;
 final  List<InspectionFormFieldSchemaDto> _fields;
@override List<InspectionFormFieldSchemaDto> get fields {
  if (_fields is EqualUnmodifiableListView) return _fields;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_fields);
}


/// Create a copy of InspectionFormSchemaDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$InspectionFormSchemaDtoCopyWith<_InspectionFormSchemaDto> get copyWith => __$InspectionFormSchemaDtoCopyWithImpl<_InspectionFormSchemaDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$InspectionFormSchemaDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _InspectionFormSchemaDto&&(identical(other.workOrderId, workOrderId) || other.workOrderId == workOrderId)&&const DeepCollectionEquality().equals(other._fields, _fields));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,workOrderId,const DeepCollectionEquality().hash(_fields));

@override
String toString() {
  return 'InspectionFormSchemaDto(workOrderId: $workOrderId, fields: $fields)';
}


}

/// @nodoc
abstract mixin class _$InspectionFormSchemaDtoCopyWith<$Res> implements $InspectionFormSchemaDtoCopyWith<$Res> {
  factory _$InspectionFormSchemaDtoCopyWith(_InspectionFormSchemaDto value, $Res Function(_InspectionFormSchemaDto) _then) = __$InspectionFormSchemaDtoCopyWithImpl;
@override @useResult
$Res call({
 String workOrderId, List<InspectionFormFieldSchemaDto> fields
});




}
/// @nodoc
class __$InspectionFormSchemaDtoCopyWithImpl<$Res>
    implements _$InspectionFormSchemaDtoCopyWith<$Res> {
  __$InspectionFormSchemaDtoCopyWithImpl(this._self, this._then);

  final _InspectionFormSchemaDto _self;
  final $Res Function(_InspectionFormSchemaDto) _then;

/// Create a copy of InspectionFormSchemaDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? workOrderId = null,Object? fields = null,}) {
  return _then(_InspectionFormSchemaDto(
workOrderId: null == workOrderId ? _self.workOrderId : workOrderId // ignore: cast_nullable_to_non_nullable
as String,fields: null == fields ? _self._fields : fields // ignore: cast_nullable_to_non_nullable
as List<InspectionFormFieldSchemaDto>,
  ));
}


}

// dart format on
