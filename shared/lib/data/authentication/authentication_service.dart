import 'package:core/data/local_storage.dart';
import 'package:core/data/local_storage_keys.dart';
import 'package:core/data/network_client.dart';
import 'package:shared/data/authentication/model/user_api_model.dart';

class AuthenticationService {
  final NetworkClient _networkClient;
  final LocalStorage _localStorage;

  AuthenticationService(this._networkClient, this._localStorage);

  Future<UserApiModel> login(String email, String password) async {
    try {
      final Map<String, dynamic> requestData = {
        "email": email,
        "password": password,
      };

      final response =
          await _networkClient.postRequest("auth/login", requestData);

      return UserApiModel.fromJson(response.data);
    } catch (error) {
      throw error;
    }
  }

  void saveToken(String token) {
    _localStorage.setString(StringKey.tokenKey, token);
  }
}
