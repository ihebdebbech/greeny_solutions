import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:shared/domain/authentication/usecase/login_usecase.dart';

class LoginController extends GetxController {
  var isLoading = false.obs;
  final LoginUsecase _loginUsecase = new LoginUsecase(Get.find());
  Future<bool> login(String email, String password) async {
    isLoading.value = true;
    try {
      final login = await _loginUsecase.login(email, password);
      isLoading.value = false;
      return true;
    } catch (error) {
      isLoading.value = false;
      return false;
    }
  }
}
