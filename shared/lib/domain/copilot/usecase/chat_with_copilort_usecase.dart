import 'package:shared/domain/authentication/authentication_repository.dart';
import 'package:shared/domain/copilot/copilot_repository.dart';
import 'package:shared/domain/userManagement/entity/user_entity.dart';

class ChatWithCopilortUsecase {
  final CopilotRepository _repository;

  ChatWithCopilortUsecase(this._repository);

  Future<String> getchatresponse(String question) async {
    try {
      final response = await _repository.getchatresponse(question);
     
      return response;
    } catch (error) {
      throw error;
    }
  }
    Future<String> getchatresponsedisease(String question) async {
    try {
      final response = await _repository.getchatresponsedisease(question);
     
      return response;
    } catch (error) {
      throw error;
    }
  }
}
