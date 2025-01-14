import 'dart:ffi';

import 'package:shared/domain/authentication/authentication_repository.dart';
import 'package:shared/domain/room/room_repository.dart';
import 'package:shared/domain/roomManagement/entity/room_entity.dart';
import 'package:shared/domain/userManagement/entity/user_entity.dart';

class CallibrateSensorUsecase {
  final RoomRepository _repository;

  CallibrateSensorUsecase(this._repository);

  Future<bool> CalibratePh(RoomEntity room) async {
    try {
      final rooms = await _repository.CalibratePh( room);
      print(rooms);
      return true;
    } catch (error) {
      throw error;
    
    }
  }
  Future<bool> CalibrateEc(RoomEntity room) async {
    try {
      final rooms = await _repository.CalibrateEc( room);
      print(rooms);
      return true;
    } catch (error) {
      throw error;
    
    }
  }
}
