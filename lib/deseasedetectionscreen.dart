import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:greeny_solution/deseasedetectionmodel.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:image/image.dart' as image_lib;

class DiseaseDetectionScreen extends StatefulWidget {
  @override
  _DiseaseDetectionScreenState createState() => _DiseaseDetectionScreenState();
}

class _DiseaseDetectionScreenState extends State<DiseaseDetectionScreen> {
  final Deseasedetectionmodel diseaseHelper = Deseasedetectionmodel();
  String _prediction = '';

  @override
  void initState() {
    super.initState();
  }

  Future<File> loadImageFromAssets(String assetPath) async {
    // Load the image from assets
    final ByteData data = await rootBundle.load(assetPath);
    final buffer = data.buffer.asUint8List();

    // Get the temporary directory
    final directory = await getTemporaryDirectory();

    // Create a file in the temporary directory
    final file = File('${directory.path}/temp_image.jpg');

    // Write the byte data to the file
    await file.writeAsBytes(buffer);

    return file;
  }

  Future<void> _loadImageAndClassify() async {
    final picker = ImagePicker();
    // final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    // if (pickedFile != null) {
    await diseaseHelper.tfLteInit();
    File imageFile =
        await loadImageFromAssets('assets/Images/TomatoEarlyBlight4.JPG');

    final imageBytes = await imageFile.readAsBytes();
    final image = image_lib.decodeImage(imageBytes)!;

    // Run the inference on the image
   // final results = await diseaseHelper.classifyImage(imageFile);
    // final res2 = diseaseHelper.modelPrediction(imageFile);
    // print("Predictions: $res2");
    // Print the predictions
    //print("Predictions: $results");
    setState(() {
      // _prediction = _model.getDiseaseName(result);
    });
    //}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Plant Disease Detection')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Prediction: $_prediction'),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _loadImageAndClassify,
              child: Text('Select and Classify Image'),
            ),
          ],
        ),
      ),
    );
  }
}
