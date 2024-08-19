import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:shared/domain/authentication/authentication_repository.dart';
import 'package:shared/domain/authentication/entity/user_entity.dart';

class LoginController extends GetxController {
  final AuthenticationRepository _authRepo =
      Get.find<AuthenticationRepository>();
  Rx<UserEntity?> user = Rx<UserEntity?>(null);
  Future<void> login(String email, String password) async {
   user.value = await _authRepo.login(email, password);
  }
}
