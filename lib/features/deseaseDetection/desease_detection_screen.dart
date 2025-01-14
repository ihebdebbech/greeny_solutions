
import 'dart:io';
import 'dart:typed_data';

import 'dart:ui' as ui;

import 'package:core/core.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import 'package:greeny_solution/features/deseaseDetection/desease_detection_controller.dart';

import 'package:fab_circular_menu/fab_circular_menu.dart';
import 'package:path_provider/path_provider.dart';
import 'package:get/get.dart';

import 'package:image/image.dart' as img;


class DeseaseDetectionScreen extends GetView<DeseaseDetectionController> {
  final GlobalKey<FabCircularMenuState> fabKey = GlobalKey();
  File? processedImage;

  Future<void> processImage() async {
    if (controller.imageFile.value != null) {
      try {
        // Resize and process the image
        processedImage = await createimg();
   
      } catch (e) {
        print("Error processing image: $e");
      }
    }
  }

  Future<File> createimg() async {
    File imageresize = File(controller.imageFile.value!.path);
    img.Image image = img.decodeImage(imageresize.readAsBytesSync())!;
    //img.Image resizedImage = img.copyResize(image, width: 128, height: 128);
        img.Image resizedImage = img.copyResize(image, width: 512, height: 512);

    List<int> resizedImageData = img.encodePng(resizedImage);
    Uint8List resizedImageBytes = Uint8List.fromList(resizedImageData);
    final tempDir = await getTemporaryDirectory();
    String uniqueFileName = "${DateTime.now().millisecondsSinceEpoch}_image.png";
  File file = File("${tempDir.path}/$uniqueFileName");
    await file.writeAsBytes(resizedImageBytes);
    return file;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(/* App bar configuration */),
        body: Column(
          children: [
            SizedBox(height: context.Heightmedia(0.07)),
            Obx(
              () {
                return Container(
                  alignment: Alignment.center,
                  child: FutureBuilder(
                    future: processImage(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return CircularProgressIndicator(); // Loading indicator
                      } else if (snapshot.hasError) {
                        return Text(
                            'Error: ${snapshot.error}'); // Error handling
                      } else if (processedImage != null) {
                        return Image.file(
                            processedImage!); // Display processed image
                      } else {
                        return Text('No image available'.tr);
                      }
                    },
                  ),
                );
              },
            ),
            SizedBox(height: 20),
            Text("Based on our AI:".tr, style: TextStyle(fontSize: 25)),
            Text("Your plant: ${controller.predictedResult}".tr,
                style: TextStyle(fontSize: 15)),
                  SizedBox(height: context.Heightmedia(0.05)),
                  Padding(padding: EdgeInsets.only(left: context.widthmedia(0.05),right: context.widthmedia(0.05) ),child: 
                    Text("Description: ${controller.deseaseDescription}",
                style: TextStyle(fontSize: 15)),
                  ),
          ],
        ),
      ),
    );
  }
}
