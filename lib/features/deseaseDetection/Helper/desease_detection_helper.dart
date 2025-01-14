import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter_tflite/flutter_tflite.dart';
import 'package:image/image.dart' as img;
import 'package:path_provider/path_provider.dart';

class DiseaseDetectionHelper {
  late String? _interpreter;

  Future<void> loadModel() async {
    try {
      _interpreter = await Tflite.loadModel(
          model: "assets/model/model.tflite",
          labels: "assets/model/labels.txt",
          numThreads: 2,
          isAsset: true,
          useGpuDelegate: false);
    } catch (e) {
      print('Error loading model: $e');
    }
  }


  Future<String> predict(File pickedImage) async {
    try {
      File imageFile = await resizePickedImage(pickedImage);

      var recognitions = await Tflite.runModelOnImage(
          path: imageFile.path,
          imageMean: 0.0,
          imageStd: 255.0,
          numResults: 5,
          threshold: 0.1,
          asynch: true);

      if (recognitions == null) {
        print("recognitions is Null");
        return "please try again";
      }
      print(recognitions.toString());
      var label = recognitions[0]['label'].toString();
      print(label);
      
      return label;
    } catch (err) {
      print(err);
      return "please try again";
    }
  }

  Future<File> resizePickedImage(File imageFile) async {
    final image = img.decodeImage(imageFile.readAsBytesSync())!;

    final resizedImage = img.copyResize(image, width: 512, height: 512);
    final directory = await getTemporaryDirectory();
    final resizedFile = File('${directory.path}/resized_image.png');

    await resizedFile.writeAsBytes(img.encodePng(resizedImage));

    return resizedFile;
  }
}
