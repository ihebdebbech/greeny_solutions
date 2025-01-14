import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared/domain/room/usecase/consult_rooms_usecase.dart';
import 'package:shared/domain/roomManagement/entity/room_entity.dart';

class HomeController extends GetxController {
  var isLoading = false.obs;
  var rooms = <RoomEntity>[].obs; // Observable list of RoomEntity
  RxDouble _opacityThermometer = 0.0.obs;
  final ConsultRoomUsecase _consultRoomUsecase =
      new ConsultRoomUsecase(Get.find());
  @override
  Future<void> onInit() async {
    super.onInit();
    await fetchRooms();
  }

  Future<void> fetchRooms() async {
    isLoading.value = true;
    try {
      final fetchedRooms = await _consultRoomUsecase.getRooms();
      rooms.assignAll(fetchedRooms); // Update the observable list
    } catch (error) {
      print(error);
      rooms.clear();
    } finally {
      isLoading.value = false;
    }
  }
}
