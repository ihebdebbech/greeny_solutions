import 'package:core/app_config.dart';
import 'package:core/data/local_storage.dart';
import 'package:core/data/network_client.dart';
import 'package:get/get.dart';
import 'package:shared/data/authentication/authentication_data_repository.dart';

import 'package:shared/data/authentication/authentication_service.dart';
import 'package:shared/domain/authentication/authentication_repository.dart';

class DI extends Bindings {
  @override
  void dependencies() {
    Get.put<AppConfig>(DevConfiguration());
    Get.put<LocalStorage>(LocalStorage(Get.find()));
    Get.put<NetworkClient>(NetworkClient(Get.find(), Get.find()));
    Get.lazyPut<AuthenticationService>(
        () => AuthenticationService(Get.find(), Get.find()));
    Get.put<AuthenticationRepository>(AuthenticationDataRepository(Get.find()));
  }
}
