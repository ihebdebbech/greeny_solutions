import 'package:freezed_annotation/freezed_annotation.dart';
part 'sensor_data_api_model.freezed.dart';
part 'sensor_data_api_model.g.dart';

@freezed
class SensorDataApiModel with _$SensorDataApiModel {
  factory SensorDataApiModel({   required int id,
    required String type,
    required double value,
    required int roomId,
    required DateTime timestamp}) =
      _SensorDataApiModel;
  factory SensorDataApiModel.fromJson(Map<String, dynamic> json) =>
      _$SensorDataApiModelFromJson(json);
}
