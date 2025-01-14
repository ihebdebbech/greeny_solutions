import 'package:shared/domain/authentication/authentication_repository.dart';
import 'package:shared/domain/room/room_repository.dart';
import 'package:shared/domain/roomManagement/entity/room_entity.dart';
import 'package:shared/domain/roomManagement/entity/sensor_data_entity.dart';
import 'package:shared/domain/userManagement/entity/user_entity.dart';

class ConsultSensorsHistoryUsecase {
  final RoomRepository _repository;

  ConsultSensorsHistoryUsecase(this._repository);

  Future<List<SensorDataEntity>> getPhHistoryData() async {
    try {
      final data = await _repository.getPhHistoryData();
      print(data);
      return data.map((room) => SensorDataEntity.fromApiModel(room)).toList();
    } catch (error) {
      throw error;
    }
  }
    Future<List<SensorDataEntity>> getEcHistoryData() async {
    try {
      final data = await _repository.getEcHistoryData();
      print(data);
      return data.map((room) => SensorDataEntity.fromApiModel(room)).toList();
    } catch (error) {
      throw error;
    }
  }
}
