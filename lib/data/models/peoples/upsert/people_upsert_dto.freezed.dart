// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'people_upsert_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PeopleUpsertDto {

@JsonKey(name: 'first_name') String get firstName;@JsonKey(name: 'last_name') String? get lastName;@JsonKey(name: 'date_of_birth') String? get dateOfBirth;
/// Create a copy of PeopleUpsertDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PeopleUpsertDtoCopyWith<PeopleUpsertDto> get copyWith => _$PeopleUpsertDtoCopyWithImpl<PeopleUpsertDto>(this as PeopleUpsertDto, _$identity);

  /// Serializes this PeopleUpsertDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as PeopleUpsertDto;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PeopleUpsertDto&&(identical(other.firstName, _this.firstName) || other.firstName == _this.firstName)&&(identical(other.lastName, _this.lastName) || other.lastName == _this.lastName)&&(identical(other.dateOfBirth, _this.dateOfBirth) || other.dateOfBirth == _this.dateOfBirth));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as PeopleUpsertDto;
  return Object.hash(runtimeType,_this.firstName,_this.lastName,_this.dateOfBirth);
}

@override
String toString() {
  final _this = this as PeopleUpsertDto;
  return 'PeopleUpsertDto(firstName: ${_this.firstName}, lastName: ${_this.lastName}, dateOfBirth: ${_this.dateOfBirth})';
}


}

/// @nodoc
abstract mixin class $PeopleUpsertDtoCopyWith<$Res>  {
  factory $PeopleUpsertDtoCopyWith(PeopleUpsertDto value, $Res Function(PeopleUpsertDto) _then) = _$PeopleUpsertDtoCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'first_name') String firstName,@JsonKey(name: 'last_name') String? lastName,@JsonKey(name: 'date_of_birth') String? dateOfBirth
});




}
/// @nodoc
class _$PeopleUpsertDtoCopyWithImpl<$Res>
    implements $PeopleUpsertDtoCopyWith<$Res> {
  _$PeopleUpsertDtoCopyWithImpl(this._self, this._then);

  final PeopleUpsertDto _self;
  final $Res Function(PeopleUpsertDto) _then;

/// Create a copy of PeopleUpsertDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? firstName = null,Object? lastName = freezed,Object? dateOfBirth = freezed,}) {
  return _then(PeopleUpsertDto(
firstName: null == firstName ? _self.firstName : firstName // ignore: cast_nullable_to_non_nullable
as String,lastName: freezed == lastName ? _self.lastName : lastName // ignore: cast_nullable_to_non_nullable
as String?,dateOfBirth: freezed == dateOfBirth ? _self.dateOfBirth : dateOfBirth // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [PeopleUpsertDto].
extension PeopleUpsertDtoPatterns on PeopleUpsertDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PeopleUpsertDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PeopleUpsertDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PeopleUpsertDto value)  $default,){
final _that = this;
switch (_that) {
case _PeopleUpsertDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PeopleUpsertDto value)?  $default,){
final _that = this;
switch (_that) {
case _PeopleUpsertDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'first_name')  String firstName, @JsonKey(name: 'last_name')  String? lastName, @JsonKey(name: 'date_of_birth')  String? dateOfBirth)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PeopleUpsertDto() when $default != null:
return $default(_that.firstName,_that.lastName,_that.dateOfBirth);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'first_name')  String firstName, @JsonKey(name: 'last_name')  String? lastName, @JsonKey(name: 'date_of_birth')  String? dateOfBirth)  $default,) {final _that = this;
switch (_that) {
case _PeopleUpsertDto():
return $default(_that.firstName,_that.lastName,_that.dateOfBirth);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'first_name')  String firstName, @JsonKey(name: 'last_name')  String? lastName, @JsonKey(name: 'date_of_birth')  String? dateOfBirth)?  $default,) {final _that = this;
switch (_that) {
case _PeopleUpsertDto() when $default != null:
return $default(_that.firstName,_that.lastName,_that.dateOfBirth);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PeopleUpsertDto implements PeopleUpsertDto {
  const _PeopleUpsertDto({@JsonKey(name: 'first_name') required this.firstName, @JsonKey(name: 'last_name') required this.lastName, @JsonKey(name: 'date_of_birth') required this.dateOfBirth});
  factory _PeopleUpsertDto.fromJson(Map<String, dynamic> json) => _$PeopleUpsertDtoFromJson(json);

@override@JsonKey(name: 'first_name') final  String firstName;
@override@JsonKey(name: 'last_name') final  String? lastName;
@override@JsonKey(name: 'date_of_birth') final  String? dateOfBirth;

/// Create a copy of PeopleUpsertDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PeopleUpsertDtoCopyWith<_PeopleUpsertDto> get copyWith => __$PeopleUpsertDtoCopyWithImpl<_PeopleUpsertDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PeopleUpsertDtoToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _PeopleUpsertDto&&(identical(other.firstName, firstName) || other.firstName == firstName)&&(identical(other.lastName, lastName) || other.lastName == lastName)&&(identical(other.dateOfBirth, dateOfBirth) || other.dateOfBirth == dateOfBirth));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,firstName,lastName,dateOfBirth);
}

@override
String toString() {
    return 'PeopleUpsertDto(firstName: $firstName, lastName: $lastName, dateOfBirth: $dateOfBirth)';
}


}

/// @nodoc
abstract mixin class _$PeopleUpsertDtoCopyWith<$Res> implements $PeopleUpsertDtoCopyWith<$Res> {
  factory _$PeopleUpsertDtoCopyWith(_PeopleUpsertDto value, $Res Function(_PeopleUpsertDto) _then) = __$PeopleUpsertDtoCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'first_name') String firstName,@JsonKey(name: 'last_name') String? lastName,@JsonKey(name: 'date_of_birth') String? dateOfBirth
});




}
/// @nodoc
class __$PeopleUpsertDtoCopyWithImpl<$Res>
    implements _$PeopleUpsertDtoCopyWith<$Res> {
  __$PeopleUpsertDtoCopyWithImpl(this._self, this._then);

  final _PeopleUpsertDto _self;
  final $Res Function(_PeopleUpsertDto) _then;

/// Create a copy of PeopleUpsertDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? firstName = null,Object? lastName = freezed,Object? dateOfBirth = freezed,}) {
  return _then(_PeopleUpsertDto(
firstName: null == firstName ? _self.firstName : firstName // ignore: cast_nullable_to_non_nullable
as String,lastName: freezed == lastName ? _self.lastName : lastName // ignore: cast_nullable_to_non_nullable
as String?,dateOfBirth: freezed == dateOfBirth ? _self.dateOfBirth : dateOfBirth // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
