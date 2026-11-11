// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'gift_upsert_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$GiftUpsertDto {

@JsonKey(name: 'gift_name') String get name;@JsonKey(name: 'gift_description') String? get description;@JsonKey(name: 'gift_year') int? get year; double get price; String? get link;@JsonKey(name: 'people_id') int get peopleId;
/// Create a copy of GiftUpsertDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GiftUpsertDtoCopyWith<GiftUpsertDto> get copyWith => _$GiftUpsertDtoCopyWithImpl<GiftUpsertDto>(this as GiftUpsertDto, _$identity);

  /// Serializes this GiftUpsertDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as GiftUpsertDto;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GiftUpsertDto&&(identical(other.name, _this.name) || other.name == _this.name)&&(identical(other.description, _this.description) || other.description == _this.description)&&(identical(other.year, _this.year) || other.year == _this.year)&&(identical(other.price, _this.price) || other.price == _this.price)&&(identical(other.link, _this.link) || other.link == _this.link)&&(identical(other.peopleId, _this.peopleId) || other.peopleId == _this.peopleId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as GiftUpsertDto;
  return Object.hash(runtimeType,_this.name,_this.description,_this.year,_this.price,_this.link,_this.peopleId);
}

@override
String toString() {
  final _this = this as GiftUpsertDto;
  return 'GiftUpsertDto(name: ${_this.name}, description: ${_this.description}, year: ${_this.year}, price: ${_this.price}, link: ${_this.link}, peopleId: ${_this.peopleId})';
}


}

/// @nodoc
abstract mixin class $GiftUpsertDtoCopyWith<$Res>  {
  factory $GiftUpsertDtoCopyWith(GiftUpsertDto value, $Res Function(GiftUpsertDto) _then) = _$GiftUpsertDtoCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'gift_name') String name,@JsonKey(name: 'gift_description') String? description,@JsonKey(name: 'gift_year') int? year, double price, String? link,@JsonKey(name: 'people_id') int peopleId
});




}
/// @nodoc
class _$GiftUpsertDtoCopyWithImpl<$Res>
    implements $GiftUpsertDtoCopyWith<$Res> {
  _$GiftUpsertDtoCopyWithImpl(this._self, this._then);

  final GiftUpsertDto _self;
  final $Res Function(GiftUpsertDto) _then;

/// Create a copy of GiftUpsertDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,Object? description = freezed,Object? year = freezed,Object? price = null,Object? link = freezed,Object? peopleId = null,}) {
  return _then(GiftUpsertDto(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,year: freezed == year ? _self.year : year // ignore: cast_nullable_to_non_nullable
as int?,price: null == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as double,link: freezed == link ? _self.link : link // ignore: cast_nullable_to_non_nullable
as String?,peopleId: null == peopleId ? _self.peopleId : peopleId // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [GiftUpsertDto].
extension GiftUpsertDtoPatterns on GiftUpsertDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _GiftUpsertDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _GiftUpsertDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _GiftUpsertDto value)  $default,){
final _that = this;
switch (_that) {
case _GiftUpsertDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _GiftUpsertDto value)?  $default,){
final _that = this;
switch (_that) {
case _GiftUpsertDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'gift_name')  String name, @JsonKey(name: 'gift_description')  String? description, @JsonKey(name: 'gift_year')  int? year,  double price,  String? link, @JsonKey(name: 'people_id')  int peopleId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _GiftUpsertDto() when $default != null:
return $default(_that.name,_that.description,_that.year,_that.price,_that.link,_that.peopleId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'gift_name')  String name, @JsonKey(name: 'gift_description')  String? description, @JsonKey(name: 'gift_year')  int? year,  double price,  String? link, @JsonKey(name: 'people_id')  int peopleId)  $default,) {final _that = this;
switch (_that) {
case _GiftUpsertDto():
return $default(_that.name,_that.description,_that.year,_that.price,_that.link,_that.peopleId);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'gift_name')  String name, @JsonKey(name: 'gift_description')  String? description, @JsonKey(name: 'gift_year')  int? year,  double price,  String? link, @JsonKey(name: 'people_id')  int peopleId)?  $default,) {final _that = this;
switch (_that) {
case _GiftUpsertDto() when $default != null:
return $default(_that.name,_that.description,_that.year,_that.price,_that.link,_that.peopleId);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _GiftUpsertDto implements GiftUpsertDto {
  const _GiftUpsertDto({@JsonKey(name: 'gift_name') required this.name, @JsonKey(name: 'gift_description') required this.description, @JsonKey(name: 'gift_year') required this.year, required this.price, required this.link, @JsonKey(name: 'people_id') required this.peopleId});
  factory _GiftUpsertDto.fromJson(Map<String, dynamic> json) => _$GiftUpsertDtoFromJson(json);

@override@JsonKey(name: 'gift_name') final  String name;
@override@JsonKey(name: 'gift_description') final  String? description;
@override@JsonKey(name: 'gift_year') final  int? year;
@override final  double price;
@override final  String? link;
@override@JsonKey(name: 'people_id') final  int peopleId;

/// Create a copy of GiftUpsertDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GiftUpsertDtoCopyWith<_GiftUpsertDto> get copyWith => __$GiftUpsertDtoCopyWithImpl<_GiftUpsertDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$GiftUpsertDtoToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _GiftUpsertDto&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description)&&(identical(other.year, year) || other.year == year)&&(identical(other.price, price) || other.price == price)&&(identical(other.link, link) || other.link == link)&&(identical(other.peopleId, peopleId) || other.peopleId == peopleId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,name,description,year,price,link,peopleId);
}

@override
String toString() {
    return 'GiftUpsertDto(name: $name, description: $description, year: $year, price: $price, link: $link, peopleId: $peopleId)';
}


}

/// @nodoc
abstract mixin class _$GiftUpsertDtoCopyWith<$Res> implements $GiftUpsertDtoCopyWith<$Res> {
  factory _$GiftUpsertDtoCopyWith(_GiftUpsertDto value, $Res Function(_GiftUpsertDto) _then) = __$GiftUpsertDtoCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'gift_name') String name,@JsonKey(name: 'gift_description') String? description,@JsonKey(name: 'gift_year') int? year, double price, String? link,@JsonKey(name: 'people_id') int peopleId
});




}
/// @nodoc
class __$GiftUpsertDtoCopyWithImpl<$Res>
    implements _$GiftUpsertDtoCopyWith<$Res> {
  __$GiftUpsertDtoCopyWithImpl(this._self, this._then);

  final _GiftUpsertDto _self;
  final $Res Function(_GiftUpsertDto) _then;

/// Create a copy of GiftUpsertDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? description = freezed,Object? year = freezed,Object? price = null,Object? link = freezed,Object? peopleId = null,}) {
  return _then(_GiftUpsertDto(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,year: freezed == year ? _self.year : year // ignore: cast_nullable_to_non_nullable
as int?,price: null == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as double,link: freezed == link ? _self.link : link // ignore: cast_nullable_to_non_nullable
as String?,peopleId: null == peopleId ? _self.peopleId : peopleId // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
