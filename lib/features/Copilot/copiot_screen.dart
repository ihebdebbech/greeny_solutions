import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:greeny_solution/features/Copilot/copilot_controller.dart';
import 'package:shared/shared.dart';

class CopiotScreen extends GetView<CopilotController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: context.Heightmedia(0.08),
        backgroundColor: Colors.white,
        automaticallyImplyLeading: true,
        shadowColor: const Color(0xFF17233D),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            color: AppColors.white,
            boxShadow: [
              BoxShadow(
                blurRadius: 10,
                color: Color.fromARGB(40, 0, 0, 0),
                offset: Offset(0, 3),
                spreadRadius: 0,
              )
            ],
          ),
          child:  FlexibleSpaceBar(
            titlePadding: EdgeInsets.only(top: 30),
            title: Align(
              alignment: Alignment.center,
              child: Padding(
                padding: EdgeInsets.only(bottom: 2.0),
                child: Text(
                  'QuickChat Copilot'.tr,
                  style: TextStyle(
                      color: AppColors.primary,
                      fontWeight: FontWeight.w800,
                      fontSize: 25),
                ),
              ),
            ),
          ),
        ),
        leading: Padding(
          padding: EdgeInsets.only(
              top: context.Heightmedia(0.02), left: context.widthmedia(0.015)),
          child: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios_new_rounded,
              size: 30,
            ),
            color: AppColors.primary,
            onPressed: () {
              Get.back();
            },
          ),
        ),
        
      ),
      body: 
                Column(
        children: <Widget>[
          Expanded(
            child: Obx(
              () => Column(
                children: <Widget>[
                  Expanded(
                    child: ListView.builder(
                      padding: EdgeInsets.all(8.0),
                      itemCount: controller.messages.length,
                      itemBuilder: (context, index) {
                        final message = controller.messages[index];
                        return Row(
                          mainAxisAlignment: message.containsKey('user')
                              ? MainAxisAlignment.end
                              : MainAxisAlignment.start,
                          children: <Widget>[
                            Flexible(
                              child: Container(
                                margin: EdgeInsets.symmetric(vertical: 4.0),
                                padding: EdgeInsets.all(10.0),
                                decoration: BoxDecoration(
                                  color: message.containsKey('user')
                                      ? AppColors.primary
                                      : AppColors.secondary,
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                child: Text(
                                  message.values.first,
                                  style: TextStyle(
                                    color: message.containsKey('user')
                                        ? Colors.white
                                        : Colors.black,
                                  ),
                                  softWrap: true, // Text wrapping
                                  overflow: TextOverflow.visible,
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                  // Display loading indicator when fetching a response
                  if (controller.isLoading.value)
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          CircularProgressIndicator(), // Loading spinner
                          SizedBox(width: 10),
                          Text('Loading...'.tr),
                        ],
                      ),
                    ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
                bottom: 30.0, left: 15, right: 8, top: 10),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: TextField(
                    controller: controller.questioncontroller,
                    decoration: InputDecoration(
                      hintText: "Type a message...".tr,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(40.0),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 8.0),
                IconButton(
                  icon: Icon(
                    Icons.send,
                    color: AppColors.primary,
                  ),
                  onPressed: () async {
                    if (controller.questioncontroller.text.isNotEmpty) {
                      await controller.getchatresponse(controller.questioncontroller.text);
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
      
    );
  }
}
