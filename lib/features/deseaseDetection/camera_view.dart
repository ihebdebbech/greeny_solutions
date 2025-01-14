import 'dart:io';

import 'package:camera/camera.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:greeny_solution/features/deseaseDetection/Helper/desease_detection_helper.dart';
import 'package:greeny_solution/features/deseaseDetection/desease_detection_controller.dart';
import 'package:greeny_solution/features/deseaseDetection/desease_detection_screen.dart';
import 'package:image_picker/image_picker.dart';

import 'package:shared/ui/theme/app_color.dart';
import 'package:image/image.dart' as img;

class CameraView extends GetView<DeseaseDetectionController> {
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      body: GetBuilder<DeseaseDetectionController>(
        builder: (controller) {
          // Check if the camera is initialized
          if (controller.controllercam.value.isInitialized) {
            return Stack(
              children: [
                Positioned.fill(
                  child: CameraPreview(controller.controllercam),
                ),
                Positioned(
                  left: context.widthmedia(0.015),
                  top: context.Heightmedia(0.055),
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back_ios_new_rounded,
                        color: Colors.white),
                    iconSize: 35,
                    onPressed: () {
                      Navigator.pop(context); // Go back to retake the picture
                    },
                  ),
                ),
                // Positioned button in the view
                Positioned(
                  left: context.widthmedia(0.39),
                  bottom: 50,
                  child: IconButton(
                    onPressed: () {
                      _takePicture(context);
                    },
                    icon: const Icon(Icons.circle_outlined),
                    color: Colors.white,
                    iconSize: 80,
                  ),
                ),
                Positioned(
                  left: 20,
                  bottom: 60,
                  child: IconButton(
                    icon: const Icon(
                      Icons.photo_album_rounded,
                    ),
                    color: Colors.white,
                    iconSize: 50,
                    onPressed: () async {
                      final picker = ImagePicker();
                      final pickedFile =
                          await picker.pickImage(source: ImageSource.gallery);

                      if (pickedFile != null) {
                        controller.imageFile.value = File(pickedFile.path);
                        // Proceed to disease detection screen
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => FullscreenImageView(
                              imageFile: File(pickedFile.path),
                            ),
                          ),
                        );
                      }
                    },
                  ),
                ),
              ],
            );
          } else {
            // Display a loading indicator or message
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

  Future<File> _correctImageOrientation(File file) async {
    final imageBytes = await file.readAsBytes();
    final img.Image? originalImage = img.decodeImage(imageBytes);

    if (originalImage == null) {
      return file;
    }

    // Manually rotate the image if needed
    final img.Image rotatedImage =
        img.copyRotate(originalImage, 0); // Rotate by 90 degrees
    int cropSize = rotatedImage.width < rotatedImage.height
        ? rotatedImage.width
        : rotatedImage.height;

    final img.Image croppedImage = img.copyCrop(
      rotatedImage,
      (rotatedImage.width - cropSize) ~/ 2,
      (rotatedImage.height - cropSize) ~/ 2,
      cropSize,
      cropSize,
    );
    final rotatedBytes = img.encodeJpg(croppedImage);
    final correctedImageFile = await file.writeAsBytes(rotatedBytes);

    return correctedImageFile;
  }

  void _takePicture(BuildContext context) async {
    try {
      final XFile picture = await controller.controllercam.takePicture();
      final orientedpic = await _correctImageOrientation(File(picture!.path));
      controller.imageFile.value = orientedpic;

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => FullscreenImageView(
            imageFile: File(orientedpic.path),
          ),
        ),
      );
    } catch (e) {
      print("Error taking picture: $e");
    }
  }
}

class FullscreenImageView extends GetView<DeseaseDetectionController> {
  final File imageFile;

  const FullscreenImageView({super.key, required this.imageFile});

  Future<void> processImage(File imageFile) async {
    try {
      print("process :");
      final detectionHelper = DiseaseDetectionHelper();
await detectionHelper.loadModel();
      String output = await detectionHelper.predict(imageFile);

      print("predict : $output");
      controller.predictedResult.value = output;
    } catch (err) {
      print("err:" + err.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.file(
              imageFile,
              fit: BoxFit.contain,
            ),
          ),
          Positioned(
            left: context.widthmedia(0.03),
            top: context.Heightmedia(0.035),
            child: IconButton(
              icon: const Icon(Icons.close_sharp, color: Colors.white),
              iconSize: 40,
              onPressed: () {
                Navigator.pop(context); // Go back to retake the picture
              },
            ),
          ),
          Positioned(
            right: 20,
            bottom: 40,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.white,
              ),
              onPressed: () async {
                await processImage(imageFile);
                await controller
                    .getchatresponse(controller.predictedResult.value);
                
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DeseaseDetectionScreen(),
                  ),
                );
              },
              child: const Icon(
                Icons.arrow_forward_ios_rounded,
                color: AppColors.primary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
