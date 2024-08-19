import 'package:shared/data/authentication/model/user_api_model.dart';

class UserEntity {
  final String id;
  final String name;
  final String email;
  final String token;
  final DateTime createdAt;
  final DateTime updatedAt;

  UserEntity({
    required this.id,
    required this.name,
    required this.email,
    required this.token,
    required this.createdAt,
    required this.updatedAt,
  });

  // Optionally, add methods for business logic related to the user.

  @override
  String toString() {
    return 'UserEntity(id: $id, name: $name, email: $email, token: $token, createdAt: $createdAt, updatedAt: $updatedAt)';
  }
  factory UserEntity.fromApiModel(UserApiModel apiModel) {
    // Assuming UserApiModel contains relevant fields or methods to extract data.
    return UserEntity(
      id: 'extracted_id', // Replace with actual extraction logic
      name: 'extracted_name',
      email: 'extracted_email',
      token: apiModel.token,
      createdAt: DateTime.now(), // Replace with actual data if available
      updatedAt: DateTime.now(), // Replace with actual data if available
    );
  }
  factory UserEntity.fromlocalmodel(UserApiModel apiModel) {
    // Assuming UserApiModel contains relevant fields or methods to extract data.
    return UserEntity(
      id: 'extracted_id', // Replace with actual extraction logic
      name: 'extracted_name',
      email: 'extracted_email',
      token: apiModel.token,
      createdAt: DateTime.now(), // Replace with actual data if available
      updatedAt: DateTime.now(), // Replace with actual data if available
    );
  }
  
}
