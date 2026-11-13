// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'gift_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$GiftDto {

 int get id;@JsonKey(name: 'gift_name') String get name;@JsonKey(name: 'gift_description') String? get description;@JsonKey(name: 'gift_year') int? get year; double get price; String? get link;@JsonKey(name: 'people_id') int get peopleId;@JsonKey(name: 'user_id') int get userId;@JsonKey(name: 'created_at') String get createdAt;@JsonKey(name: 'updated_at') String get updatedAt;
/// Create a copy of GiftDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GiftDtoCopyWith<GiftDto> get copyWith => _$GiftDtoCopyWithImpl<GiftDto>(this as GiftDto, _$identity);

  /// Serializes this GiftDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as GiftDto;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GiftDto&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.name, _this.name) || other.name == _this.name)&&(identical(other.description, _this.description) || other.description == _this.description)&&(identical(other.year, _this.year) || other.year == _this.year)&&(identical(other.price, _this.price) || other.price == _this.price)&&(identical(other.link, _this.link) || other.link == _this.link)&&(identical(other.peopleId, _this.peopleId) || other.peopleId == _this.peopleId)&&(identical(other.userId, _this.userId) || other.userId == _this.userId)&&(identical(other.createdAt, _this.createdAt) || other.createdAt == _this.createdAt)&&(identical(other.updatedAt, _this.updatedAt) || other.updatedAt == _this.updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as GiftDto;
  return Object.hash(runtimeType,_this.id,_this.name,_this.description,_this.year,_this.price,_this.link,_this.peopleId,_this.userId,_this.createdAt,_this.updatedAt);
}

@override
String toString() {
  final _this = this as GiftDto;
  return 'GiftDto(id: ${_this.id}, name: ${_this.name}, description: ${_this.description}, year: ${_this.year}, price: ${_this.price}, link: ${_this.link}, peopleId: ${_this.peopleId}, userId: ${_this.userId}, createdAt: ${_this.createdAt}, updatedAt: ${_this.updatedAt})';
}


}

/// @nodoc
abstract mixin class $GiftDtoCopyWith<$Res>  {
  factory $GiftDtoCopyWith(GiftDto value, $Res Function(GiftDto) _then) = _$GiftDtoCopyWithImpl;
@useResult
$Res call({
 int id,@JsonKey(name: 'gift_name') String name,@JsonKey(name: 'gift_description') String? description,@JsonKey(name: 'gift_year') int? year, double price, String? link,@JsonKey(name: 'people_id') int peopleId,@JsonKey(name: 'user_id') int userId,@JsonKey(name: 'created_at') String createdAt,@JsonKey(name: 'updated_at') String updatedAt
});




}
/// @nodoc
class _$GiftDtoCopyWithImpl<$Res>
    implements $GiftDtoCopyWith<$Res> {
  _$GiftDtoCopyWithImpl(this._self, this._then);

  final GiftDto _self;
  final $Res Function(GiftDto) _then;

/// Create a copy of GiftDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? description = freezed,Object? year = freezed,Object? price = null,Object? link = freezed,Object? peopleId = null,Object? userId = null,Object? createdAt = null,Object? updatedAt = null,}) {
  return _then(GiftDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,year: freezed == year ? _self.year : year // ignore: cast_nullable_to_non_nullable
as int?,price: null == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as double,link: freezed == link ? _self.link : link // ignore: cast_nullable_to_non_nullable
as String?,peopleId: null == peopleId ? _self.peopleId : peopleId // ignore: cast_nullable_to_non_nullable
as int,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as int,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [GiftDto].
extension GiftDtoPatterns on GiftDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _GiftDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _GiftDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _GiftDto value)  $default,){
final _that = this;
switch (_that) {
case _GiftDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _GiftDto value)?  $default,){
final _that = this;
switch (_that) {
case _GiftDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id, @JsonKey(name: 'gift_name')  String name, @JsonKey(name: 'gift_description')  String? description, @JsonKey(name: 'gift_year')  int? year,  double price,  String? link, @JsonKey(name: 'people_id')  int peopleId, @JsonKey(name: 'user_id')  int userId, @JsonKey(name: 'created_at')  String createdAt, @JsonKey(name: 'updated_at')  String updatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _GiftDto() when $default != null:
return $default(_that.id,_that.name,_that.description,_that.year,_that.price,_that.link,_that.peopleId,_that.userId,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id, @JsonKey(name: 'gift_name')  String name, @JsonKey(name: 'gift_description')  String? description, @JsonKey(name: 'gift_year')  int? year,  double price,  String? link, @JsonKey(name: 'people_id')  int peopleId, @JsonKey(name: 'user_id')  int userId, @JsonKey(name: 'created_at')  String createdAt, @JsonKey(name: 'updated_at')  String updatedAt)  $default,) {final _that = this;
switch (_that) {
case _GiftDto():
return $default(_that.id,_that.name,_that.description,_that.year,_that.price,_that.link,_that.peopleId,_that.userId,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id, @JsonKey(name: 'gift_name')  String name, @JsonKey(name: 'gift_description')  String? description, @JsonKey(name: 'gift_year')  int? year,  double price,  String? link, @JsonKey(name: 'people_id')  int peopleId, @JsonKey(name: 'user_id')  int userId, @JsonKey(name: 'created_at')  String createdAt, @JsonKey(name: 'updated_at')  String updatedAt)?  $default,) {final _that = this;
switch (_that) {
case _GiftDto() when $default != null:
return $default(_that.id,_that.name,_that.description,_that.year,_that.price,_that.link,_that.peopleId,_that.userId,_that.createdAt,_that.updatedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _GiftDto implements GiftDto {
  const _GiftDto({required this.id, @JsonKey(name: 'gift_name') required this.name, @JsonKey(name: 'gift_description') required this.description, @JsonKey(name: 'gift_year') required this.year, required this.price, required this.link, @JsonKey(name: 'people_id') required this.peopleId, @JsonKey(name: 'user_id') required this.userId, @JsonKey(name: 'created_at') required this.createdAt, @JsonKey(name: 'updated_at') required this.updatedAt});
  factory _GiftDto.fromJson(Map<String, dynamic> json) => _$GiftDtoFromJson(json);

@override final  int id;
@override@JsonKey(name: 'gift_name') final  String name;
@override@JsonKey(name: 'gift_description') final  String? description;
@override@JsonKey(name: 'gift_year') final  int? year;
@override final  double price;
@override final  String? link;
@override@JsonKey(name: 'people_id') final  int peopleId;
@override@JsonKey(name: 'user_id') final  int userId;
@override@JsonKey(name: 'created_at') final  String createdAt;
@override@JsonKey(name: 'updated_at') final  String updatedAt;

/// Create a copy of GiftDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GiftDtoCopyWith<_GiftDto> get copyWith => __$GiftDtoCopyWithImpl<_GiftDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$GiftDtoToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _GiftDto&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description)&&(identical(other.year, year) || other.year == year)&&(identical(other.price, price) || other.price == price)&&(identical(other.link, link) || other.link == link)&&(identical(other.peopleId, peopleId) || other.peopleId == peopleId)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,name,description,year,price,link,peopleId,userId,createdAt,updatedAt);
}

@override
String toString() {
    return 'GiftDto(id: $id, name: $name, description: $description, year: $year, price: $price, link: $link, peopleId: $peopleId, userId: $userId, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$GiftDtoCopyWith<$Res> implements $GiftDtoCopyWith<$Res> {
  factory _$GiftDtoCopyWith(_GiftDto value, $Res Function(_GiftDto) _then) = __$GiftDtoCopyWithImpl;
@override @useResult
$Res call({
 int id,@JsonKey(name: 'gift_name') String name,@JsonKey(name: 'gift_description') String? description,@JsonKey(name: 'gift_year') int? year, double price, String? link,@JsonKey(name: 'people_id') int peopleId,@JsonKey(name: 'user_id') int userId,@JsonKey(name: 'created_at') String createdAt,@JsonKey(name: 'updated_at') String updatedAt
});




}
/// @nodoc
class __$GiftDtoCopyWithImpl<$Res>
    implements _$GiftDtoCopyWith<$Res> {
  __$GiftDtoCopyWithImpl(this._self, this._then);

  final _GiftDto _self;
  final $Res Function(_GiftDto) _then;

/// Create a copy of GiftDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? description = freezed,Object? year = freezed,Object? price = null,Object? link = freezed,Object? peopleId = null,Object? userId = null,Object? createdAt = null,Object? updatedAt = null,}) {
  return _then(_GiftDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,year: freezed == year ? _self.year : year // ignore: cast_nullable_to_non_nullable
as int?,price: null == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as double,link: freezed == link ? _self.link : link // ignore: cast_nullable_to_non_nullable
as String?,peopleId: null == peopleId ? _self.peopleId : peopleId // ignore: cast_nullable_to_non_nullable
as int,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as int,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
