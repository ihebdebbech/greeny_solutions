import 'package:core/app_config.dart';
import 'package:core/data/local_storage.dart';
import 'package:core/data/network_client.dart';
import 'package:get/get.dart';
import 'package:greeny_solution/features/Copilot/copilot_controller.dart';
import 'package:greeny_solution/features/Profile/profile_controller.dart';
import 'package:greeny_solution/features/deseaseDetection/desease_detection_controller.dart';
import 'package:greeny_solution/features/home/homepageController.dart';
import 'package:greeny_solution/features/notification/Notification_controller.dart';
import 'package:greeny_solution/features/premium/payment_controller.dart';
import 'package:greeny_solution/features/roomsmanagement/room_controller.dart';
import 'package:shared/data/authentication/authentication_data_repository.dart';

import 'package:shared/data/authentication/authentication_service.dart';
import 'package:shared/data/copilot/copilot_data_repository.dart';
import 'package:shared/data/copilot/copilot_data_service.dart';
import 'package:shared/data/notification/notification_data_repository.dart';
import 'package:shared/data/notification/notification_data_service.dart';
import 'package:shared/data/room_management/room_management_data_repository.dart';
import 'package:shared/data/room_management/room_management_service.dart';
import 'package:shared/data/user_management/user_managament_service.dart';
import 'package:shared/domain/authentication/authentication_repository.dart';
import 'package:shared/domain/copilot/copilot_repository.dart';
import 'package:shared/domain/notification/Notification_repository.dart';
import 'package:shared/domain/payment/payment_repository.dart';
import 'package:shared/domain/payment/usecase/check_subscription_usecase.dart';
import 'package:shared/domain/room/room_repository.dart';
import 'package:shared/domain/room/usecase/consult_rooms_usecase.dart';
import 'package:shared/data/payment/payment_data_repository.dart';
import 'package:shared/data/payment/payment_service.dart';
import 'package:shared/domain/userManagement/usecase/consult_user_details.dart';
import 'package:shared/domain/userManagement/user_repository.dart';
import 'package:shared/data/user_management/user_management_data_repository.dart';
import 'package:shared/domain/room/usecase/callibrate_sensor_usecase.dart';
import 'package:shared/domain/room/usecase/consult_sensors_history_usecase.dart';

class DI extends Bindings {
  @override
  void dependencies() {
    Get.put<AppConfig>(ProdConfiguration());
    Get.put<LocalStorage>(LocalStorage(Get.find()));
    Get.put<NetworkClient>(NetworkClient(Get.find(), Get.find()));
    Get.lazyPut<AuthenticationService>(
        () => AuthenticationService(Get.find(), Get.find()));
    Get.put<AuthenticationRepository>(AuthenticationDataRepository(Get.find()));
    Get.lazyPut<RoomManagementService>(
        () => RoomManagementService(Get.find(), Get.find()));
    Get.put<RoomRepository>(RoomManagementDataRepository(Get.find()));
    Get.lazyPut<NotificationDataService>(
        () => NotificationDataService(Get.find(), Get.find()));
    Get.put<NotificationRepository>(NotificationDataRepository(Get.find()));
    Get.lazyPut<HomeController>(() => HomeController());
    Get.put<NotificationController>(NotificationController());
    Get.lazyPut<CopilotDataService>(
        () => CopilotDataService(Get.find(), Get.find()));
    Get.put<CopilotRepository>(CopilotDataRepository(Get.find()));
    Get.put<CopilotController>(CopilotController());
     Get.lazyPut<ConsultSensorsHistoryUsecase>(() => ConsultSensorsHistoryUsecase(Get.find()));
          Get.lazyPut<CallibrateSensorUsecase>(() => CallibrateSensorUsecase(Get.find()));

    Get.lazyPut<ConsultRoomUsecase>(() => ConsultRoomUsecase(Get.find()));
    Get.lazyPut<roomController>(() => roomController());
    Get.put<DeseaseDetectionController>(DeseaseDetectionController());
    Get.lazyPut<PaymentService>(() => PaymentService(Get.find(), Get.find()),
        fenix: true);
    Get.lazyPut<PaymentRepository>(() => PaymentDataRepository(Get.find()),
        fenix: true);
    Get.lazyPut<CheckSubscriptionUsecase>(
        () => CheckSubscriptionUsecase(Get.find()),
        fenix: true);
    Get.lazyPut<PaymentController>(() => PaymentController(), fenix: true);
    Get.lazyPut<UserManagamentService>(
        () => UserManagamentService(Get.find(), Get.find()),
        fenix: true);
    Get.lazyPut<UserRepository>(() => UserManagementDataRepository(Get.find()),
        fenix: true);

    Get.lazyPut<ConsultUserDetails>(() => ConsultUserDetails(Get.find()),
        fenix: true);
    Get.lazyPut<ProfileController>(() => ProfileController(), fenix: true);
  }
}
