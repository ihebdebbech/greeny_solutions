import 'package:shared/domain/authentication/authentication_repository.dart';
import 'package:shared/domain/authentication/entity/user_entity.dart';

class LoginUsecase {
  final AuthenticationRepository _repository;

  LoginUsecase(this._repository);

  Future<bool> login(String email, String password) async {
    try {
      final user = await _repository.login(email, password);
      _repository.saveToken(user.token);
      return true;
    } catch (error) {
      throw error;
    }
  }
}
