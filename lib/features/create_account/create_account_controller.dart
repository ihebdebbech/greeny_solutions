import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:shared/domain/authentication/usecase/create_account_usecase.dart';
import 'package:shared/domain/authentication/usecase/login_usecase.dart';
import 'package:shared/domain/userManagement/entity/user_entity.dart';

class createAcountController extends GetxController {
  var isLoading = false.obs;
  final CreateAccountUsecase _CreateAccountUsecase =
      new CreateAccountUsecase(Get.find());
  Future<bool> createAcount(UserEntity user) async {
    isLoading.value = true;
    try {
       final firebaseInstance = FirebaseMessaging.instance;
    String? fcmToken = await firebaseInstance.getToken();
    
      final userCreated = await _CreateAccountUsecase.CreateAccount(user,fcmToken ?? "2IXEfdXQD2qwmy43iM0u-:APA91bEvuWym6S46aEMCyR_F8bnfUB9YftHeVwga6GQ2leEtce15CMpLhPAJVBztzCzEtEYzy88SCfdRKr9AU1Gli3MH8oz2yOIC40uESNzfvSfqsoRO7oJhvvjtw-AY1er9VYjARZoQ");

      isLoading.value = false;
      return true;
    } catch (error) {
      print(error);
      isLoading.value = false;
      return false;
    }
  }
}
