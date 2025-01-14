import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_tflite/flutter_tflite.dart';
import 'package:image/image.dart' as image_lib;
import 'package:image/image.dart' as img;

import 'package:camera/camera.dart';
import 'package:path_provider/path_provider.dart'; // Assuming you have this dependency

class Deseasedetectionmodel {
  final List<String> _classNames = [
    'Apple - Apple scab',
    'Apple - Black rot',
    'Apple - Cedar apple rust',
    'Apple - healthy',
    'Blueberry - healthy',
    'Cherry (including sour) - Powdery mildew',
    'Cherry (including sour) - healthy',
    'Corn (maize) - Cercospora leaf spot Gray leaf spot',
    'Corn (maize) - Common rust',
    'Corn (maize) - Northern Leaf Blight',
    'Corn (maize) - healthy',
    'Grape - Black rot',
    'Grape - Esca (Black Measles)',
    'Grape - Leaf blight (Isariopsis Leaf Spot)',
    'Grape - healthy',
    'Orange - Haunglongbing (Citrus greening)',
    'Peach - Bacterial spot',
    'Peach - healthy',
    'Pepper, bell - Bacterial spot',
    'Pepper, bell - healthy',
    'Potato - Early blight',
    'Potato - Late blight',
    'Potato - healthy',
    'Raspberry - healthy',
    'Soybean - healthy',
    'Squash - Powdery mildew',
    'Strawberry - Leaf scorch',
    'Strawberry - healthy',
    'Tomato - Bacterial spot',
    'Tomato - Early blight',
    'Tomato - Late blight',
    'Tomato - Leaf Mold',
    'Tomato - Septoria leaf spot',
    'Tomato - Spider mites Two-spotted spider mite',
    'Tomato - Target Spot',
    'Tomato - Tomato Yellow Leaf Curl Virus',
    'Tomato - Tomato mosaic virus',
    'Tomato - healthy'
  ];
  @override
  void dispose() {
    Tflite.close();
  }

  Future<void> tfLteInit() async {
    String? res = await Tflite.loadModel(
        model: "assets/model/version2.tflite",
        labels: "assets/model/labels.txt",
        numThreads: 1, // defaults to 1
        isAsset:
            true, // defaults to true, set to false to load resources outside assets
        useGpuDelegate:
            false // defaults to false, set to true to use GPU delegate
        );
    File imageFile =
        await loadImageFromAssets('assets/Images/AppleCedarRust2.JPG');

    var recognitions = await Tflite.runModelOnImage(
        path: imageFile.path, // required
        imageMean: 0.0, // defaults to 117.0
        imageStd: 1.0, // defaults to 1.0
        numResults: 5, // defaults to 5
        threshold: 0.1, // defaults to 0.1
        asynch: true // defaults to true
        );

    if (recognitions == null) {
      print("recognitions is Null");
      return;
    }
    print(recognitions.toString());
    var label = recognitions[0]['label'].toString();
    print(label);
  }

  Future<File> loadImageFromAssets(String assetPath) async {
    // Load image bytes from assets

    final byteData = await rootBundle.load(assetPath);

    // Decode and resize the image
    final image = img.decodeImage(byteData.buffer.asUint8List())!;
    final resizedImage = img.copyResize(image, width: 128, height: 128);

    // Get temporary directory and save resized image
    final directory = await getTemporaryDirectory();
    final resizedFile = File('${directory.path}/resized_image.png');
    await resizedFile.writeAsBytes(img.encodePng(resizedImage));

    return resizedFile;
  }
}
// class PlantDiseaseClassifier {
//   late Interpreter _interpreter;
//   final List<String> _classNames = [
//     'Apple - Apple scab',
//     'Apple - Black rot',
//     'Apple - Cedar apple rust',
//     'Apple - healthy',
//     'Blueberry - healthy',
//     'Cherry (including sour) - Powdery mildew',
//     'Cherry (including sour) - healthy',
//     'Corn (maize) - Cercospora leaf spot Gray leaf spot',
//     'Corn (maize) - Common rust',
//     'Corn (maize) - Northern Leaf Blight',
//     'Corn (maize) - healthy',
//     'Grape - Black rot',
//     'Grape - Esca (Black Measles)',
//     'Grape - Leaf blight (Isariopsis Leaf Spot)',
//     'Grape - healthy',
//     'Orange - Haunglongbing (Citrus greening)',
//     'Peach - Bacterial spot',
//     'Peach - healthy',
//     'Pepper, bell - Bacterial spot',
//     'Pepper, bell - healthy',
//     'Potato - Early blight',
//     'Potato - Late blight',
//     'Potato - healthy',
//     'Raspberry - healthy',
//     'Soybean - healthy',
//     'Squash - Powdery mildew',
//     'Strawberry - Leaf scorch',
//     'Strawberry - healthy',
//     'Tomato - Bacterial spot',
//     'Tomato - Early blight',
//     'Tomato - Late blight',
//     'Tomato - Leaf Mold',
//     'Tomato - Septoria leaf spot',
//     'Tomato - Spider mites Two-spotted spider mite',
//     'Tomato - Target Spot',
//     'Tomato - Tomato Yellow Leaf Curl Virus',
//     'Tomato - Tomato mosaic virus',
//     'Tomato - healthy'
//   ];

//   Future<void> loadModel2() async {
//     final modelPath = 'assets/model/version2.tflite';
//     _interpreter = await Interpreter.fromAsset(modelPath);
//   }
// static Future<ClassifierModel> _loadModel(String modelFileName) async {
//   // #1
//   final interpreter = await Interpreter.fromAsset(modelFileName);

//   // #2
//   final inputShape = interpreter.getInputTensor(0).shape;
//   final outputShape = interpreter.getOutputTensor(0).shape;

//   debugPrint('Input shape: $inputShape');
//   debugPrint('Output shape: $outputShape');

//   // #3
//   final inputType = interpreter.getInputTensor(0).type;
//   final outputType = interpreter.getOutputTensor(0).type;

//   debugPrint('Input type: $inputType');
//   debugPrint('Output type: $outputType');
  
//   return ClassifierModel(
//    interpreter: interpreter,
//    inputShape: inputShape,
//    outputShape: outputShape,
//    inputType: inputType,
//    outputType: outputType,
//   );
// }
//   Future<Map<String, double>> classifyImage(File imageFile) async {
//     final image = image_lib.decodeImage(imageFile.readAsBytesSync())!;
//     final resizedImage = image_lib.copyResize(image, width: 128, height: 128);

//     final input = _preprocessImage(resizedImage);

//     final output = List.generate(1, (_) => List.filled(38, 0.0));
//     _interpreter.run(input, output);

//     final result = _postprocessOutput(output);
//     return result;
//   }
// Uint8List grayscaleToByteListFloat32(img.Image image, int inputSize){
//   var convertedBytes = Float32List(inputSize * inputSize);
//   var buffer = Float32List.view(convertedBytes.buffer);
//   int pixelIndex = 0;
//   for (var i = 0; i < inputSize; i++) {
//     for (var j = 0; j < inputSize; j++) {
//       var pixel = image.getPixel(j, i);
//       buffer[pixelIndex++] = img.getLuminance(pixel) / 255.0;
//     }
//   }
//   return convertedBytes.buffer.asUint8List();
// }
// TensorImage _preProcessInput(Image image) {
//   // #1
//   final inputTensor = TensorImage(_model.inputType);
//   inputTensor.loadImage(image);

//   // #2
//   final minLength = min(inputTensor.height, inputTensor.width);
//   final cropOp = ResizeWithCropOrPadOp(minLength, minLength);

//   // #3
//   final shapeLength = _model.inputShape[1];
//   final resizeOp = ResizeOp(shapeLength, shapeLength, ResizeMethod.BILINEAR);

//   // #4
//   final normalizeOp = NormalizeOp(127.5, 127.5);

//   // #5
//   final imageProcessor = ImageProcessorBuilder()
//     .add(cropOp)
//     .add(resizeOp)
//     .add(normalizeOp)
//     .build();

//   imageProcessor.process(inputTensor);

//   // #6
//   return inputTensor;
//  }
//   Future<int> modelPrediction2(File imageFile) async {
//   ByteData data = await rootBundle.load('assets/Images/TomatoEarlyBlight4.JPG');
// image_lib.Image? sneaker_image = img.decodeImage(data.buffer.asUint8List());
// sneaker_image= img.grayscale(sneaker_image!);
// sneaker_image= img.copyResize(
//     sneaker_image, 
//     width: 28, 
//     height: 28, 
//     );
//     var recognitions = await _interpreter.runForMultipleInputs(
//     binary: grayscaleToByteListFloat32(image, 28),
//     numResults: 10,
//     threshold: 0,
//     asynch: false,
// );
//     return
//   }

//   Future<int> modelPrediction(File imageFile) async {
//     // Load and preprocess the image
//     Interpreter interpreter = _interpreter;
//     final img.Image image = img.decodeImage(await imageFile.readAsBytes())!;
//     final img.Image resizedImage =
//         img.copyResize(image, width: 128, height: 128);

//     // Convert image to a list of floats
//     final List<double> inputData = [];
//     for (int y = 0; y < resizedImage.height; y++) {
//       for (int x = 0; x < resizedImage.width; x++) {
//         final pixel = resizedImage.getPixel(x, y);
//         inputData.add((pixel & 0xFF) / 255.0); // Red
//         inputData.add(((pixel >> 8) & 0xFF) / 255.0); // Green
//         inputData.add(((pixel >> 16) & 0xFF) / 255.0); // Blue
//       }
//     }

//     // Get the input tensor
//     final inputTensor = interpreter.getInputTensor(0);
//     final inputShape = inputTensor.shape;
//     final inputSize = inputShape.reduce((a, b) => a * b);

//     // Ensure input data size matches tensor size
//     if (inputData.length != inputSize) {
//       throw Exception(
//           "Input data size (${inputData.length}) does not match tensor size ($inputSize).");
//     }

//     // Allocate tensors if not already done
//     interpreter.allocateTensors();

//     // Set the tensor data
//     final inputDataBuffer = Float32List.fromList(inputData);
//     inputTensor.setTo(inputDataBuffer);

//     // Run inference
//     interpreter.invoke();

//     // Retrieve output tensor
//     final outputTensor = interpreter.getOutputTensor(0);
//     final outputShape = outputTensor.shape;

//     // Ensure the output tensor shape is [1, 38]
//     if (outputShape.length != 2 ||
//         outputShape[0] != 1 ||
//         outputShape[1] != 38) {
//       throw Exception(
//           "Unexpected output tensor shape: ${outputShape.toString()}");
//     }

//     // Allocate a buffer for the output data with the correct shape
//     var outputData = List.generate(1, (_) => List.filled(38, 0.0));

//     // Debugging information
//     print('Output Tensor Shape: $outputShape');
//     print('Output Data Length: ${outputData.length}');

//     // Copy data from tensor to outputData
//     try {
//       outputTensor.copyTo(outputData);
//     } catch (e) {
//       print('Error copying output data: $e');
//       throw e;
//     }

//     // Reshape outputData to [1, 38] (i.e., a list containing one list of 38 elements)

//     // Find the index with the highest value
//     final List<double> flattenedOutputData = outputData[0];
//     print(flattenedOutputData);
//     print("bfb");
//     final int result = flattenedOutputData
//         .indexOf(flattenedOutputData.reduce((a, b) => a > b ? a : b));

//     final maxScore = flattenedOutputData.reduce((a, b) => a > b ? a : b);

//     // Find the index of the maximum score
//     final maxIndex = flattenedOutputData.indexOf(maxScore);

//     final classification = <String, double>{};

//     for (var i = 0; i < flattenedOutputData.length; i++) {
//       // Normalize score and map to class names
//       final score = flattenedOutputData[i];
//       if (score > 0) {
//         classification[_classNames[i]] = score;
//       }
//     }
//     flattenedOutputData.sort((a, b) => a.compareTo(b));
//     print(flattenedOutputData);
//     print(_classNames[maxIndex]);
//     print(classification.toString());

//     return result;
//   }
//   /* Future<Map<String, double>> classifyCameraImage(CameraImage cameraImage) async {
    
//     final resizedImage = image_lib.copyResize(image, width: 128, height: 128);

//     final input = _preprocessImage(resizedImage);

//     final output = List.filled(_classNames.length, 0);
//     _interpreter.run(input, output);

//     final result = _postprocessOutput(output);
//     return result;
//   }*/

//   List<List<List<List<double>>>> _preprocessImage(image_lib.Image image) {
//     image_lib.Image imageInput = image_lib.copyResize(
//       image!,
//       width: 128,
//       height: 128,
//     );
//     final imageMatrix = List.generate(
//       128,
//       (y) => List.generate(
//         128,
//         (x) {
//           final pixel = imageInput.getPixel(x, y);
//           final r = (image_lib.getRed(pixel) / 255.0).toDouble();
//           final g = (image_lib.getGreen(pixel) / 255.0).toDouble();
//           final b = (image_lib.getBlue(pixel) / 255.0).toDouble();
//           return [r, g, b];
//         },
//       ),
//     );

//     // Input shape [1, 128, 128, 3]
//     return [imageMatrix];
//   }

//   Map<String, double> _postprocessOutput(List<List<double>> output) {
//     // Flatten the output from [1, 38] to [38]
//     final flattenedOutput = output[0];

//     // Find the maximum score for normalization
//     final maxScore = flattenedOutput.reduce((a, b) => a > b ? a : b);

//     // Find the index of the maximum score
//     final maxIndex = flattenedOutput.indexOf(maxScore);

//     final classification = <String, double>{};

//     for (var i = 0; i < flattenedOutput.length; i++) {
//       // Normalize score and map to class names
//       final score = flattenedOutput[i];
//       if (score > 0) {
//         classification[_classNames[i]] = score / maxScore;
//       }
//     }
//     print(_classNames[maxIndex]);
//     return classification;
//   }
// }
// class ClassifierModel {
//  Interpreter interpreter;

//  List<int> inputShape;
//  List<int> outputShape;

//  TensorType inputType;
//  TensorType outputType;

//  ClassifierModel({
//   required this.interpreter,
//   required this.inputShape,
//   required this.outputShape,
//   required this.inputType,
//   required this.outputType,
//  });
// }
