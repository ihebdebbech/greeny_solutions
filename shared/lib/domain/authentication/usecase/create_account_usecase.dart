import 'package:shared/domain/authentication/authentication_repository.dart';
import 'package:shared/domain/userManagement/entity/user_entity.dart';

class CreateAccountUsecase {
  final AuthenticationRepository _repository;

  CreateAccountUsecase(this._repository);

  Future<bool> CreateAccount(UserEntity user,String fcmtoken) async {
    try {
      final authApi = await _repository.CreateAccount(user,fcmtoken);
      _repository.saveToken(authApi.token);
      return true;
    } catch (error) {
      throw error;
    }
  }
}
