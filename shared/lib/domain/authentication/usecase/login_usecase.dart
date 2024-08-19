import 'package:shared/domain/authentication/authentication_repository.dart';
import 'package:shared/domain/authentication/entity/user_entity.dart';

class LoginUsecase {
  final AuthenticationRepository _repository;

  LoginUsecase(this._repository);

  Future<UserEntity> login(String email, String password) =>
      _repository.login(email, password);
      

}
