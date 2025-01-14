import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:shared/domain/copilot/usecase/chat_with_copilort_usecase.dart'; 

class CopilotController extends GetxController {
  var responses = <String>[].obs;
  var isLoading = false.obs;
  final messages = <Map<String, String>>[].obs;
  final TextEditingController questioncontroller = TextEditingController();

  final ChatWithCopilortUsecase _chatWithCopilortUsecase =
      new ChatWithCopilortUsecase(Get.find());

  Future<void> getchatresponse(String question) async {
    try {
      if (questioncontroller.text.isNotEmpty) {
        messages.add({'user': questioncontroller.text});
      }

      isLoading(true);
      final response = await _chatWithCopilortUsecase.getchatresponse(question);
      
    
        messages.add({'bot': response});
    
      questioncontroller.clear();
    } catch (e) {
      print('Error: $e');
    } finally {
      isLoading(false);
    }
  }

  @override
  void onInit() {
    super.onInit();
  }
}
