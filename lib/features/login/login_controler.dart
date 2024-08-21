import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:shared/domain/authentication/usecase/login_usecase.dart';
import 'package:shared/domain/authentication/entity/user_entity.dart';

class LoginController extends GetxController {
  var isLoading = false.obs;
  final LoginUsecase _authRepo = new LoginUsecase(Get.find());

  Rx<UserEntity?> user = Rx<UserEntity?>(null);
  Future<void> login(String email, String password) async {
    isLoading.value = true;
    try {
      final login = await _authRepo.login(email, password);
      Get.snackbar(
        "Success",
        "welcome Back ",
        snackPosition: SnackPosition.BOTTOM,
        colorText: Color.fromARGB(255, 0, 190, 92),
        duration: Duration(seconds: 3),
      );
    } catch (error) {
      Get.snackbar(
        "Login Failed",
        "please  try again",
        colorText: const Color.fromARGB(255, 198, 13, 0),
        snackPosition: SnackPosition.BOTTOM,
        duration: Duration(seconds: 3),
      );
    } finally {
      isLoading.value = false;
    }

    isLoading.value = false;
  }
}
