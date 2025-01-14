import 'package:shared/data/authentication/model/authentication_api_model.dart';
import 'package:shared/domain/userManagement/entity/user_entity.dart';

abstract class CopilotRepository {
  Future<String> getchatresponse(String question);
  Future<String> getchatresponsedisease(String question);
}
