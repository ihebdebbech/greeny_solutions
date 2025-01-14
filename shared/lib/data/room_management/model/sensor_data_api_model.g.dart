// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sensor_data_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SensorDataApiModelImpl _$$SensorDataApiModelImplFromJson(
        Map<String, dynamic> json) =>
    _$SensorDataApiModelImpl(
      id: (json['id'] as num).toInt(),
      type: json['type'] as String,
      value: (json['value'] as num).toDouble(),
      roomId: (json['roomId'] as num).toInt(),
      timestamp: DateTime.parse(json['timestamp'] as String),
    );

Map<String, dynamic> _$$SensorDataApiModelImplToJson(
        _$SensorDataApiModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'value': instance.value,
      'roomId': instance.roomId,
      'timestamp': instance.timestamp.toIso8601String(),
    };
