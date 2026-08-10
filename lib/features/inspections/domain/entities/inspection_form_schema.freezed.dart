// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'inspection_form_schema.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$InspectionFormFieldSchema {

 String get key; InspectionFormFieldType get type; String get label; bool get required; int? get minLength; List<String> get options;
/// Create a copy of InspectionFormFieldSchema
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$InspectionFormFieldSchemaCopyWith<InspectionFormFieldSchema> get copyWith => _$InspectionFormFieldSchemaCopyWithImpl<InspectionFormFieldSchema>(this as InspectionFormFieldSchema, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is InspectionFormFieldSchema&&(identical(other.key, key) || other.key == key)&&(identical(other.type, type) || other.type == type)&&(identical(other.label, label) || other.label == label)&&(identical(other.required, required) || other.required == required)&&(identical(other.minLength, minLength) || other.minLength == minLength)&&const DeepCollectionEquality().equals(other.options, options));
}


@override
int get hashCode => Object.hash(runtimeType,key,type,label,required,minLength,const DeepCollectionEquality().hash(options));

@override
String toString() {
  return 'InspectionFormFieldSchema(key: $key, type: $type, label: $label, required: $required, minLength: $minLength, options: $options)';
}


}

/// @nodoc
abstract mixin class $InspectionFormFieldSchemaCopyWith<$Res>  {
  factory $InspectionFormFieldSchemaCopyWith(InspectionFormFieldSchema value, $Res Function(InspectionFormFieldSchema) _then) = _$InspectionFormFieldSchemaCopyWithImpl;
@useResult
$Res call({
 String key, InspectionFormFieldType type, String label, bool required, int? minLength, List<String> options
});




}
/// @nodoc
class _$InspectionFormFieldSchemaCopyWithImpl<$Res>
    implements $InspectionFormFieldSchemaCopyWith<$Res> {
  _$InspectionFormFieldSchemaCopyWithImpl(this._self, this._then);

  final InspectionFormFieldSchema _self;
  final $Res Function(InspectionFormFieldSchema) _then;

/// Create a copy of InspectionFormFieldSchema
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? key = null,Object? type = null,Object? label = null,Object? required = null,Object? minLength = freezed,Object? options = null,}) {
  return _then(_self.copyWith(
key: null == key ? _self.key : key // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as InspectionFormFieldType,label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,required: null == required ? _self.required : required // ignore: cast_nullable_to_non_nullable
as bool,minLength: freezed == minLength ? _self.minLength : minLength // ignore: cast_nullable_to_non_nullable
as int?,options: null == options ? _self.options : options // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}

}


/// Adds pattern-matching-related methods to [InspectionFormFieldSchema].
extension InspectionFormFieldSchemaPatterns on InspectionFormFieldSchema {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _InspectionFormFieldSchema value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _InspectionFormFieldSchema() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _InspectionFormFieldSchema value)  $default,){
final _that = this;
switch (_that) {
case _InspectionFormFieldSchema():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _InspectionFormFieldSchema value)?  $default,){
final _that = this;
switch (_that) {
case _InspectionFormFieldSchema() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String key,  InspectionFormFieldType type,  String label,  bool required,  int? minLength,  List<String> options)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _InspectionFormFieldSchema() when $default != null:
return $default(_that.key,_that.type,_that.label,_that.required,_that.minLength,_that.options);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String key,  InspectionFormFieldType type,  String label,  bool required,  int? minLength,  List<String> options)  $default,) {final _that = this;
switch (_that) {
case _InspectionFormFieldSchema():
return $default(_that.key,_that.type,_that.label,_that.required,_that.minLength,_that.options);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String key,  InspectionFormFieldType type,  String label,  bool required,  int? minLength,  List<String> options)?  $default,) {final _that = this;
switch (_that) {
case _InspectionFormFieldSchema() when $default != null:
return $default(_that.key,_that.type,_that.label,_that.required,_that.minLength,_that.options);case _:
  return null;

}
}

}

/// @nodoc


class _InspectionFormFieldSchema implements InspectionFormFieldSchema {
  const _InspectionFormFieldSchema({required this.key, required this.type, required this.label, this.required = false, this.minLength, final  List<String> options = const []}): _options = options;
  

@override final  String key;
@override final  InspectionFormFieldType type;
@override final  String label;
@override@JsonKey() final  bool required;
@override final  int? minLength;
 final  List<String> _options;
@override@JsonKey() List<String> get options {
  if (_options is EqualUnmodifiableListView) return _options;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_options);
}


/// Create a copy of InspectionFormFieldSchema
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$InspectionFormFieldSchemaCopyWith<_InspectionFormFieldSchema> get copyWith => __$InspectionFormFieldSchemaCopyWithImpl<_InspectionFormFieldSchema>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _InspectionFormFieldSchema&&(identical(other.key, key) || other.key == key)&&(identical(other.type, type) || other.type == type)&&(identical(other.label, label) || other.label == label)&&(identical(other.required, required) || other.required == required)&&(identical(other.minLength, minLength) || other.minLength == minLength)&&const DeepCollectionEquality().equals(other._options, _options));
}


@override
int get hashCode => Object.hash(runtimeType,key,type,label,required,minLength,const DeepCollectionEquality().hash(_options));

@override
String toString() {
  return 'InspectionFormFieldSchema(key: $key, type: $type, label: $label, required: $required, minLength: $minLength, options: $options)';
}


}

/// @nodoc
abstract mixin class _$InspectionFormFieldSchemaCopyWith<$Res> implements $InspectionFormFieldSchemaCopyWith<$Res> {
  factory _$InspectionFormFieldSchemaCopyWith(_InspectionFormFieldSchema value, $Res Function(_InspectionFormFieldSchema) _then) = __$InspectionFormFieldSchemaCopyWithImpl;
@override @useResult
$Res call({
 String key, InspectionFormFieldType type, String label, bool required, int? minLength, List<String> options
});




}
/// @nodoc
class __$InspectionFormFieldSchemaCopyWithImpl<$Res>
    implements _$InspectionFormFieldSchemaCopyWith<$Res> {
  __$InspectionFormFieldSchemaCopyWithImpl(this._self, this._then);

  final _InspectionFormFieldSchema _self;
  final $Res Function(_InspectionFormFieldSchema) _then;

/// Create a copy of InspectionFormFieldSchema
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? key = null,Object? type = null,Object? label = null,Object? required = null,Object? minLength = freezed,Object? options = null,}) {
  return _then(_InspectionFormFieldSchema(
key: null == key ? _self.key : key // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as InspectionFormFieldType,label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,required: null == required ? _self.required : required // ignore: cast_nullable_to_non_nullable
as bool,minLength: freezed == minLength ? _self.minLength : minLength // ignore: cast_nullable_to_non_nullable
as int?,options: null == options ? _self._options : options // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}


}

/// @nodoc
mixin _$InspectionFormSchema {

 String get workOrderId; List<InspectionFormFieldSchema> get fields;
/// Create a copy of InspectionFormSchema
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$InspectionFormSchemaCopyWith<InspectionFormSchema> get copyWith => _$InspectionFormSchemaCopyWithImpl<InspectionFormSchema>(this as InspectionFormSchema, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is InspectionFormSchema&&(identical(other.workOrderId, workOrderId) || other.workOrderId == workOrderId)&&const DeepCollectionEquality().equals(other.fields, fields));
}


@override
int get hashCode => Object.hash(runtimeType,workOrderId,const DeepCollectionEquality().hash(fields));

@override
String toString() {
  return 'InspectionFormSchema(workOrderId: $workOrderId, fields: $fields)';
}


}

/// @nodoc
abstract mixin class $InspectionFormSchemaCopyWith<$Res>  {
  factory $InspectionFormSchemaCopyWith(InspectionFormSchema value, $Res Function(InspectionFormSchema) _then) = _$InspectionFormSchemaCopyWithImpl;
@useResult
$Res call({
 String workOrderId, List<InspectionFormFieldSchema> fields
});




}
/// @nodoc
class _$InspectionFormSchemaCopyWithImpl<$Res>
    implements $InspectionFormSchemaCopyWith<$Res> {
  _$InspectionFormSchemaCopyWithImpl(this._self, this._then);

  final InspectionFormSchema _self;
  final $Res Function(InspectionFormSchema) _then;

/// Create a copy of InspectionFormSchema
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? workOrderId = null,Object? fields = null,}) {
  return _then(_self.copyWith(
workOrderId: null == workOrderId ? _self.workOrderId : workOrderId // ignore: cast_nullable_to_non_nullable
as String,fields: null == fields ? _self.fields : fields // ignore: cast_nullable_to_non_nullable
as List<InspectionFormFieldSchema>,
  ));
}

}


/// Adds pattern-matching-related methods to [InspectionFormSchema].
extension InspectionFormSchemaPatterns on InspectionFormSchema {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _InspectionFormSchema value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _InspectionFormSchema() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _InspectionFormSchema value)  $default,){
final _that = this;
switch (_that) {
case _InspectionFormSchema():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _InspectionFormSchema value)?  $default,){
final _that = this;
switch (_that) {
case _InspectionFormSchema() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String workOrderId,  List<InspectionFormFieldSchema> fields)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _InspectionFormSchema() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String workOrderId,  List<InspectionFormFieldSchema> fields)  $default,) {final _that = this;
switch (_that) {
case _InspectionFormSchema():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String workOrderId,  List<InspectionFormFieldSchema> fields)?  $default,) {final _that = this;
switch (_that) {
case _InspectionFormSchema() when $default != null:
return $default(_that.workOrderId,_that.fields);case _:
  return null;

}
}

}

/// @nodoc


class _InspectionFormSchema extends InspectionFormSchema {
  const _InspectionFormSchema({required this.workOrderId, required final  List<InspectionFormFieldSchema> fields}): _fields = fields,super._();
  

@override final  String workOrderId;
 final  List<InspectionFormFieldSchema> _fields;
@override List<InspectionFormFieldSchema> get fields {
  if (_fields is EqualUnmodifiableListView) return _fields;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_fields);
}


/// Create a copy of InspectionFormSchema
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$InspectionFormSchemaCopyWith<_InspectionFormSchema> get copyWith => __$InspectionFormSchemaCopyWithImpl<_InspectionFormSchema>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _InspectionFormSchema&&(identical(other.workOrderId, workOrderId) || other.workOrderId == workOrderId)&&const DeepCollectionEquality().equals(other._fields, _fields));
}


@override
int get hashCode => Object.hash(runtimeType,workOrderId,const DeepCollectionEquality().hash(_fields));

@override
String toString() {
  return 'InspectionFormSchema(workOrderId: $workOrderId, fields: $fields)';
}


}

/// @nodoc
abstract mixin class _$InspectionFormSchemaCopyWith<$Res> implements $InspectionFormSchemaCopyWith<$Res> {
  factory _$InspectionFormSchemaCopyWith(_InspectionFormSchema value, $Res Function(_InspectionFormSchema) _then) = __$InspectionFormSchemaCopyWithImpl;
@override @useResult
$Res call({
 String workOrderId, List<InspectionFormFieldSchema> fields
});




}
/// @nodoc
class __$InspectionFormSchemaCopyWithImpl<$Res>
    implements _$InspectionFormSchemaCopyWith<$Res> {
  __$InspectionFormSchemaCopyWithImpl(this._self, this._then);

  final _InspectionFormSchema _self;
  final $Res Function(_InspectionFormSchema) _then;

/// Create a copy of InspectionFormSchema
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? workOrderId = null,Object? fields = null,}) {
  return _then(_InspectionFormSchema(
workOrderId: null == workOrderId ? _self.workOrderId : workOrderId // ignore: cast_nullable_to_non_nullable
as String,fields: null == fields ? _self._fields : fields // ignore: cast_nullable_to_non_nullable
as List<InspectionFormFieldSchema>,
  ));
}


}

// dart format on
