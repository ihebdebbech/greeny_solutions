import 'package:flutter/foundation.dart';
import 'package:shared/data/room_management/model/sensor_data_api_model.dart';



class SensorDataEntity {
  final int id; 
  final String type;
  final double value;
  final DateTime timestamp; 
  final int roomId; 

  // Constructor
  SensorDataEntity({
    required this.id,
    required this.type,
    required this.value,
    required this.timestamp,
    required this.roomId,
  });

  // Factory method to create a SensorDataEntity from JSON
 factory SensorDataEntity.fromApiModel(SensorDataApiModel apiModel) {
    return SensorDataEntity(
      id: apiModel.id,
      type: apiModel.type,
      value: apiModel.value,
      timestamp: apiModel.timestamp,
      roomId: apiModel.roomId,
   
    );
  }
}
