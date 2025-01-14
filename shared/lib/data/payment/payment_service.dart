import 'package:core/data/local_storage.dart';
import 'package:core/data/local_storage_keys.dart';
import 'package:core/data/network_client.dart';
import 'package:shared/data/authentication/model/authentication_api_model.dart';
import 'package:shared/data/room_management/model/room_api_model.dart';
import 'package:shared/data/user_management/model/user_api_model.dart';
import 'package:shared/domain/roomManagement/entity/room_entity.dart';
import 'package:shared/domain/userManagement/entity/user_entity.dart';

class PaymentService {
  final NetworkClient _networkClient;
  final LocalStorage _localStorage;

  PaymentService(this._networkClient, this._localStorage);

  Future<bool> getSubcriptionStatus() async {
    try {
      final response = await _networkClient.getRequest(
          "user/getusersubscriptionstatus",
          requiresAuthentication: true);

     

      // Map each item in the list to a RoomApiModel instance
      return response.data['premiumstatus'];
    } catch (error) {
      return false;
      
    }
  }

  Future<String> initpayment() async {
    try {
      final Map<String, dynamic> requestData = {
        "amount": 49000,
      };

      final response = await _networkClient.postRequest(
          "payment/init-payment", requestData,
          requiresAuthentication: true);
      
      return response.data['data']['payUrl'];
    } catch (error) {
      throw error;
    }
  }
}
