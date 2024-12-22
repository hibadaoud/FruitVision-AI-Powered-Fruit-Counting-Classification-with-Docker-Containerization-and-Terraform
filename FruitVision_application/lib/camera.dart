  import 'package:flutter/material.dart';
import 'package:moodmuse/main.dart';
import 'dart:async';
import 'prediction.dart';
import 'package:image_picker/image_picker.dart'; // Add this line for image picking

import 'package:camera/camera.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';



class Camera extends StatefulWidget {

  const Camera({super.key});
  @override
  State<Camera> createState() => _CameraState();
}

class _CameraState extends State<Camera> {
  CameraController? _camcontroller;
  List<CameraDescription>? _cameras;
  int _selectedCameraIdx = 0;
  List<dynamic> historyData = [];
  final  MODEL_API = dotenv.env['MODEL_API'];
  final  HISTORY_API = dotenv.env['HISTORY_API'];

  @override
  void initState() {
    super.initState();
    _initCamera();
  }

  Future<void> _initCamera() async {
    _cameras = await availableCameras();
    if (_cameras != null && _cameras!.isNotEmpty) {
      _camcontroller = CameraController(
        _cameras![_selectedCameraIdx],
        ResolutionPreset.ultraHigh,
      );
      await _camcontroller!.initialize().then((_) {
        if (!mounted) return;

        // Set flash mode to off after initialization
        _camcontroller!.setFlashMode(FlashMode.off);
        setState(() {});
      }).catchError((e) {
        print('Error initializing camera: $e');
      });
    } else {
      print('No camera found');
    }
  }

  Future<void> _pickImageFromGallery(BuildContext context) async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery); // or ImageSource.camera

    if (image != null) {
      File imageFile = File(image.path); // Create a File instance
      await _sendImageToServer(imageFile); // Call your upload function
    } else {
      print('No image selected');
    }
  }

  Future<void> _takePicture(BuildContext context) async {
    // Check if the camera is initialized
    if (_camcontroller == null || !_camcontroller!.value.isInitialized) {
      print("Error: Camera is not initialized.");
      return;
    }
    // Check if a picture capture is pending
    if (_camcontroller!.value.isTakingPicture) {
      print("Error: Capture is pending.");
      return;
    }

    try {
      // Take a picture and get an XFile object representing the image
      final XFile picture = await _camcontroller!.takePicture();
      File imageFile = File(picture.path);
      await _sendImageToServer(imageFile);
    } catch (e) {
      // Handle exceptions
      print('Exception: $e');
    }
  }



  Future<void> _sendImageToServer(File imageFile) async {
    try {
      final uri = Uri.parse(MODEL_API! + '/analyze/');
      final request = http.MultipartRequest('POST', uri)
        ..files.add(await http.MultipartFile.fromPath(
          'file',
          imageFile.path,
        ));

      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        final analysisResults = responseData['analysis'];
        final type = analysisResults['most_common_type'];
        final resultText = analysisResults['result_text'];
        final full_url = responseData['image_url'];  // Assurez-vous que c'est le bon champ pour l'URL

        // Vérification améliorée pour identifier quelle valeur est nulle
        if (type == null) {
          print('Error: Type is null');
        } else if (resultText == null) {
          print('Error: Result text is null');
        } else if (full_url == null) {
          print('Error: Image URL is null');
        } else {
          // Toutes les valeurs sont non-nulles, envoyez les données
          await sendData(type, resultText, full_url);
        }
        final imagePath = responseData['image_url'];
        if (imagePath != null && analysisResults != null) {

          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DisplayAnalysisResultsScreen(
                imagePath: imagePath,
                type: type,
                resultText: resultText,
              ),
            ),
          );
        } else {
          // Handle the case where imagePath or analysisResults is null
          print('Image path or analysis results is null');
        }

      } else {
        print('Error: ${response.statusCode}');
      }
    } catch (e) {
      print('Exception: $e');
    }
  }



// Add this function to your _CameraState class
  Future<void> sendData(String type, String resultText, String? full_url) async {
    try {
      if (full_url == null) {
        print('full_url null');
      }
      final numberMatch = RegExp(r'\d+').firstMatch(resultText);
      String? number = numberMatch != null ? numberMatch.group(0) : 'No number found';
      final uri = Uri.parse(HISTORY_API! + '/api/history'); // Update with your server's URL
      final headers = {"Content-Type": "application/json"};
      final body = jsonEncode({
        "type": type,
        "resultText": number,
        "full_url": full_url,
      });

      final response = await http.post(uri, headers: headers, body: body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        print('Data sent successfully');
      } else {
        print('Failed to send data: ${response.statusCode}');
      }
    } catch (e) {
      print('Exception when sending data: $e');
    }
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: _camcontroller == null || !_camcontroller!.value.isInitialized
                ? Center(child: CircularProgressIndicator())
                : CameraPreview(_camcontroller!),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 110.0), // Adjust the left padding here
                    child: IconButton(
                      onPressed: () => _takePicture(context),
                      icon: Icon(Icons.circle_outlined, size: 75),
                      color: Colors.white, // Set the color of the camera icon
                    ),
                  ),
                  Spacer(), // Spacer to create space between the buttons
                  IconButton(
                    onPressed: () => _pickImageFromGallery(context),
                    icon: Icon(Icons.photo_library, size: 35),
                    color: Colors.white, // Set the color of the library icon
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
