import 'package:shared/data/authentication/model/authentication_api_model.dart';
import 'package:shared/data/user_management/model/user_api_model.dart';

class UserEntity {
  final String username;
  final String firstname;
  final String lastname;
  final String? birthdate;
  final String email;
  final int phonenumber;
  final String? password;

  UserEntity(
      {required this.username,
      required this.firstname,
      required this.lastname,
      this.birthdate,
      required this.email,
      required this.phonenumber,
      this.password});

  @override
  String toString() {
    return 'UserEntity(username: $username, firstname: $firstname, lastname: $lastname, birthdate: $birthdate, email: $email, phonenumber: $phonenumber)';
  }

  factory UserEntity.fromApiModel(UserApiModel apiModel) {
    return UserEntity(
      username: apiModel.username,
      firstname: apiModel.firstname,
      lastname: apiModel.lastname,
      birthdate: apiModel.birthdate,
      email: apiModel.email,
      phonenumber: 0,
    );
  }
}
