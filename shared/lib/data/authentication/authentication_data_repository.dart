import 'package:shared/data/authentication/authentication_remote_service.dart';
import 'package:shared/domain/authentication/authentication_repository.dart';
import 'package:shared/domain/authentication/entity/user_entity.dart';

class AuthenticationDataRepository implements AuthenticationRepository {
  final AuthenticationRemoteService _remoteService ;

  AuthenticationDataRepository(this._remoteService);

  @override
  Future<UserEntity> login(String email, String password) async {
    // TODO: implement login
       final userApiModel = await _remoteService.login(email, password);
    return UserEntity.fromlocalmodel(userApiModel);
  }
  
}
