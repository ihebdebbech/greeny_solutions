import 'package:core/data/local_storage.dart';
import 'package:core/data/local_storage_keys.dart';
import 'package:core/data/network_client.dart';
import 'package:shared/data/authentication/model/authentication_api_model.dart';
import 'package:shared/data/user_management/model/user_api_model.dart';
import 'package:shared/domain/userManagement/entity/user_entity.dart';

class AuthenticationService {
  final NetworkClient _networkClient;
  final LocalStorage _localStorage;

  AuthenticationService(this._networkClient, this._localStorage);

  Future<AuthenticationApiModel> login(String email, String password) async {
    try {
      final Map<String, dynamic> requestData = {
        "email": email,
        "password": password,
      };

      final response =
          await _networkClient.postRequest("auth/login", requestData);

      return AuthenticationApiModel.fromJson(response.data);
    } catch (error) {
      throw error;
    }
  }

  void saveToken(String token) {
    _localStorage.setString(StringKey.tokenKey, token);
  }

  Future<AuthenticationApiModel> CreateAccount(UserEntity user) async {
    try {
      final Map<String, dynamic> requestData = {
        "username": user.username,
        "firstname": user.firstname,
        "lastname": user.lastname,
        "email": user.email,
        "phonenumber": user.phonenumber,
        "birthdate": user.birthdate,
        "password": user.password,
      };

      final response =
          await _networkClient.postRequest("auth/create-account", requestData);
      return AuthenticationApiModel.fromJson(response.data);
    } catch (error) {
      throw error;
    }
  }
}
