import 'package:shared/domain/authentication/entity/user_entity.dart';

abstract class AuthenticationRepository {
  Future<UserEntity> login(String email, String password);
}
