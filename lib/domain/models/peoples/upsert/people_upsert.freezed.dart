// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'people_upsert.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$PeopleUpsert {

 String get firstName; String? get lastName; DateTime? get dateOfBirth;
/// Create a copy of PeopleUpsert
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PeopleUpsertCopyWith<PeopleUpsert> get copyWith => _$PeopleUpsertCopyWithImpl<PeopleUpsert>(this as PeopleUpsert, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as PeopleUpsert;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PeopleUpsert&&(identical(other.firstName, _this.firstName) || other.firstName == _this.firstName)&&(identical(other.lastName, _this.lastName) || other.lastName == _this.lastName)&&(identical(other.dateOfBirth, _this.dateOfBirth) || other.dateOfBirth == _this.dateOfBirth));
}


@override
int get hashCode {
  final _this = this as PeopleUpsert;
  return Object.hash(runtimeType,_this.firstName,_this.lastName,_this.dateOfBirth);
}

@override
String toString() {
  final _this = this as PeopleUpsert;
  return 'PeopleUpsert(firstName: ${_this.firstName}, lastName: ${_this.lastName}, dateOfBirth: ${_this.dateOfBirth})';
}


}

/// @nodoc
abstract mixin class $PeopleUpsertCopyWith<$Res>  {
  factory $PeopleUpsertCopyWith(PeopleUpsert value, $Res Function(PeopleUpsert) _then) = _$PeopleUpsertCopyWithImpl;
@useResult
$Res call({
 String firstName, String? lastName, DateTime? dateOfBirth
});




}
/// @nodoc
class _$PeopleUpsertCopyWithImpl<$Res>
    implements $PeopleUpsertCopyWith<$Res> {
  _$PeopleUpsertCopyWithImpl(this._self, this._then);

  final PeopleUpsert _self;
  final $Res Function(PeopleUpsert) _then;

/// Create a copy of PeopleUpsert
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? firstName = null,Object? lastName = freezed,Object? dateOfBirth = freezed,}) {
  return _then(PeopleUpsert(
firstName: null == firstName ? _self.firstName : firstName // ignore: cast_nullable_to_non_nullable
as String,lastName: freezed == lastName ? _self.lastName : lastName // ignore: cast_nullable_to_non_nullable
as String?,dateOfBirth: freezed == dateOfBirth ? _self.dateOfBirth : dateOfBirth // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [PeopleUpsert].
extension PeopleUpsertPatterns on PeopleUpsert {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PeopleUpsert value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PeopleUpsert() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PeopleUpsert value)  $default,){
final _that = this;
switch (_that) {
case _PeopleUpsert():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PeopleUpsert value)?  $default,){
final _that = this;
switch (_that) {
case _PeopleUpsert() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String firstName,  String? lastName,  DateTime? dateOfBirth)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PeopleUpsert() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String firstName,  String? lastName,  DateTime? dateOfBirth)  $default,) {final _that = this;
switch (_that) {
case _PeopleUpsert():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String firstName,  String? lastName,  DateTime? dateOfBirth)?  $default,) {final _that = this;
switch (_that) {
case _PeopleUpsert() when $default != null:
return $default(_that.firstName,_that.lastName,_that.dateOfBirth);case _:
  return null;

}
}

}

/// @nodoc


class _PeopleUpsert implements PeopleUpsert {
  const _PeopleUpsert({required this.firstName, required this.lastName, required this.dateOfBirth});
  

@override final  String firstName;
@override final  String? lastName;
@override final  DateTime? dateOfBirth;

/// Create a copy of PeopleUpsert
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PeopleUpsertCopyWith<_PeopleUpsert> get copyWith => __$PeopleUpsertCopyWithImpl<_PeopleUpsert>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _PeopleUpsert&&(identical(other.firstName, firstName) || other.firstName == firstName)&&(identical(other.lastName, lastName) || other.lastName == lastName)&&(identical(other.dateOfBirth, dateOfBirth) || other.dateOfBirth == dateOfBirth));
}


@override
int get hashCode {
    return Object.hash(runtimeType,firstName,lastName,dateOfBirth);
}

@override
String toString() {
    return 'PeopleUpsert(firstName: $firstName, lastName: $lastName, dateOfBirth: $dateOfBirth)';
}


}

/// @nodoc
abstract mixin class _$PeopleUpsertCopyWith<$Res> implements $PeopleUpsertCopyWith<$Res> {
  factory _$PeopleUpsertCopyWith(_PeopleUpsert value, $Res Function(_PeopleUpsert) _then) = __$PeopleUpsertCopyWithImpl;
@override @useResult
$Res call({
 String firstName, String? lastName, DateTime? dateOfBirth
});




}
/// @nodoc
class __$PeopleUpsertCopyWithImpl<$Res>
    implements _$PeopleUpsertCopyWith<$Res> {
  __$PeopleUpsertCopyWithImpl(this._self, this._then);

  final _PeopleUpsert _self;
  final $Res Function(_PeopleUpsert) _then;

/// Create a copy of PeopleUpsert
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? firstName = null,Object? lastName = freezed,Object? dateOfBirth = freezed,}) {
  return _then(_PeopleUpsert(
firstName: null == firstName ? _self.firstName : firstName // ignore: cast_nullable_to_non_nullable
as String,lastName: freezed == lastName ? _self.lastName : lastName // ignore: cast_nullable_to_non_nullable
as String?,dateOfBirth: freezed == dateOfBirth ? _self.dateOfBirth : dateOfBirth // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
