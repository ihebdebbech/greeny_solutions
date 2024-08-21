import 'package:shared/data/authentication/authentication_service.dart';
import 'package:shared/domain/authentication/authentication_repository.dart';
import 'package:shared/domain/authentication/entity/user_entity.dart';

class AuthenticationDataRepository implements AuthenticationRepository {
  final AuthenticationService _service;

  AuthenticationDataRepository(this._service);

  @override
  Future<UserEntity> login(String email, String password) async {
    try {
      final userApiModel = await _service.login(email, password);
      final user = UserEntity.fromlocalmodel(userApiModel);
      return user;
    } catch (error) {
      throw error;
    }
  }

  @override
  void saveToken(String token) {
    _service.saveToken(token);
  }
}
