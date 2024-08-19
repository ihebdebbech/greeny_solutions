import 'package:core/data/network_client.dart';
import 'package:shared/data/authentication/model/user_api_model.dart';

class AuthenticationRemoteService {
  final NetworkClient _networkClient;

  AuthenticationRemoteService(this._networkClient);

  Future<UserApiModel> login(String email, String password) async {
    print("in service");
    //final response = await _networkClient.getRequest("path");

    //return UserApiModel.fromJson(response.data);
    return UserApiModel(token: "token done");
  }
}
