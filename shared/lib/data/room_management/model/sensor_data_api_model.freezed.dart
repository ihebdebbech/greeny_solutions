// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'sensor_data_api_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

SensorDataApiModel _$SensorDataApiModelFromJson(Map<String, dynamic> json) {
  return _SensorDataApiModel.fromJson(json);
}

/// @nodoc
mixin _$SensorDataApiModel {
  int get id => throw _privateConstructorUsedError;
  String get type => throw _privateConstructorUsedError;
  double get value => throw _privateConstructorUsedError;
  int get roomId => throw _privateConstructorUsedError;
  DateTime get timestamp => throw _privateConstructorUsedError;

  /// Serializes this SensorDataApiModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SensorDataApiModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SensorDataApiModelCopyWith<SensorDataApiModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SensorDataApiModelCopyWith<$Res> {
  factory $SensorDataApiModelCopyWith(
          SensorDataApiModel value, $Res Function(SensorDataApiModel) then) =
      _$SensorDataApiModelCopyWithImpl<$Res, SensorDataApiModel>;
  @useResult
  $Res call(
      {int id, String type, double value, int roomId, DateTime timestamp});
}

/// @nodoc
class _$SensorDataApiModelCopyWithImpl<$Res, $Val extends SensorDataApiModel>
    implements $SensorDataApiModelCopyWith<$Res> {
  _$SensorDataApiModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SensorDataApiModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? type = null,
    Object? value = null,
    Object? roomId = null,
    Object? timestamp = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      value: null == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as double,
      roomId: null == roomId
          ? _value.roomId
          : roomId // ignore: cast_nullable_to_non_nullable
              as int,
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SensorDataApiModelImplCopyWith<$Res>
    implements $SensorDataApiModelCopyWith<$Res> {
  factory _$$SensorDataApiModelImplCopyWith(_$SensorDataApiModelImpl value,
          $Res Function(_$SensorDataApiModelImpl) then) =
      __$$SensorDataApiModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id, String type, double value, int roomId, DateTime timestamp});
}

/// @nodoc
class __$$SensorDataApiModelImplCopyWithImpl<$Res>
    extends _$SensorDataApiModelCopyWithImpl<$Res, _$SensorDataApiModelImpl>
    implements _$$SensorDataApiModelImplCopyWith<$Res> {
  __$$SensorDataApiModelImplCopyWithImpl(_$SensorDataApiModelImpl _value,
      $Res Function(_$SensorDataApiModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of SensorDataApiModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? type = null,
    Object? value = null,
    Object? roomId = null,
    Object? timestamp = null,
  }) {
    return _then(_$SensorDataApiModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      value: null == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as double,
      roomId: null == roomId
          ? _value.roomId
          : roomId // ignore: cast_nullable_to_non_nullable
              as int,
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SensorDataApiModelImpl implements _SensorDataApiModel {
  _$SensorDataApiModelImpl(
      {required this.id,
      required this.type,
      required this.value,
      required this.roomId,
      required this.timestamp});

  factory _$SensorDataApiModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$SensorDataApiModelImplFromJson(json);

  @override
  final int id;
  @override
  final String type;
  @override
  final double value;
  @override
  final int roomId;
  @override
  final DateTime timestamp;

  @override
  String toString() {
    return 'SensorDataApiModel(id: $id, type: $type, value: $value, roomId: $roomId, timestamp: $timestamp)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SensorDataApiModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.value, value) || other.value == value) &&
            (identical(other.roomId, roomId) || other.roomId == roomId) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, type, value, roomId, timestamp);

  /// Create a copy of SensorDataApiModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SensorDataApiModelImplCopyWith<_$SensorDataApiModelImpl> get copyWith =>
      __$$SensorDataApiModelImplCopyWithImpl<_$SensorDataApiModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SensorDataApiModelImplToJson(
      this,
    );
  }
}

abstract class _SensorDataApiModel implements SensorDataApiModel {
  factory _SensorDataApiModel(
      {required final int id,
      required final String type,
      required final double value,
      required final int roomId,
      required final DateTime timestamp}) = _$SensorDataApiModelImpl;

  factory _SensorDataApiModel.fromJson(Map<String, dynamic> json) =
      _$SensorDataApiModelImpl.fromJson;

  @override
  int get id;
  @override
  String get type;
  @override
  double get value;
  @override
  int get roomId;
  @override
  DateTime get timestamp;

  /// Create a copy of SensorDataApiModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SensorDataApiModelImplCopyWith<_$SensorDataApiModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
