import 'package:core/data/local_storage.dart';
import 'package:core/data/local_storage_keys.dart';
import 'package:core/data/network_client.dart';
import 'package:shared/data/authentication/model/authentication_api_model.dart';
import 'package:shared/data/notification/model/notification_api_model.dart';
import 'package:shared/data/room_management/model/room_api_model.dart';
import 'package:shared/data/user_management/model/user_api_model.dart';
import 'package:shared/domain/roomManagement/entity/room_entity.dart';
import 'package:shared/domain/userManagement/entity/user_entity.dart';

class CopilotDataService {
  final NetworkClient _networkClient;
  final LocalStorage _localStorage;

  CopilotDataService(this._networkClient, this._localStorage);

  Future<String> getchatresponse(String question) async {
         final Map<String, dynamic> requestData = {
        "question": question ,
     };
    try {
      final response = await _networkClient
          .postCopilotRequest(requestData);
      print(response.data["message"]);
      return response.data["message"].toString();
        
    } catch (error) {
      throw error;
    }
  }
   Future<String> getchatresponsedisease(String question) async {
         final Map<String, dynamic> requestData = {
       "question": "leaf "+question +" in 1-2 lines give me information about  it focusing on causes, solutions and recommended pesticides, keep in mind that my plant is in hydronic system",

     };
    try {
      final response = await _networkClient
          .postCopilotRequest(requestData);
      print(response.data["message"]);
      return response.data["message"].toString();
        
    } catch (error) {
      throw error;
    }
  }
}
