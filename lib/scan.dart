import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image/image.dart' as img;
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:firstseniorproject/scanResult.dart';
import 'dart:typed_data';
import 'package:image_cropper/image_cropper.dart';

class CameraWidget extends StatefulWidget {
  const CameraWidget({super.key});

  @override
  _CameraWidgetState createState() => _CameraWidgetState();
}

class _CameraWidgetState extends State<CameraWidget> {
  File? imageFile;
  String body = "";
  String result = "";
  double percent = 0.0;


  Future<void> pickImage(ImageSource source) async {
    final picker = ImagePicker();
    final XFile? xFile =
        await picker.pickImage(source: source, imageQuality: 70);

    if (xFile != null) {
      final File imageFile = File(xFile.path);

      final int fileSizeKB =
          (await imageFile.length()) ~/ 1024; // File size in KB

      if (fileSizeKB < 20) {
        // Show a SnackBar if the file size is less than 200KB
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
                'Image quality is not sufficient. Please choose a higher-quality image.'),
          ),
        );
        setState(() {
          this.imageFile = null;
        });
      } else {
        // Resize the image
        final File resizedFile = await resizeImage(imageFile);

        // Crop the resized image
        final ImageCropper imageCropper = ImageCropper();
        final CroppedFile? croppedFile = await imageCropper.cropImage(
          sourcePath: resizedFile.path,
          compressQuality: 100,
          aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1),
          maxHeight: 200,
          maxWidth: 200,
        );

        if (croppedFile != null) {
          setState(() {
            this.imageFile = File(croppedFile.path!);
          });

          final Uint8List imageBytes = File(croppedFile.path).readAsBytesSync();
          final String base64Image = base64Encode(imageBytes);

          final Uri apiUrl = Uri.parse("http://10.0.2.2:5000/api");
          final http.Response response = await http.put(
            apiUrl,
            headers: {'Content-Type': 'application/json'},
            body: jsonEncode({'image': base64Image}),
          );

          try {
            print(response.body);
            setState(() {
              body = response.body;
            });
            Map<String, dynamic> jsonResponse = json.decode(body);
            String predictedClass = jsonResponse['predicted_class'];
            List<dynamic> rawPredictions = jsonResponse['raw_predictions'][0];
            double maxValue = rawPredictions
                .reduce((max, value) => max > value ? max : value);
            result=predictedClass;
            percent=maxValue*100;
          } catch (error) {
            print("Error: $error");
          }
        }
      }
    } else {
      setState(() {
        this.imageFile = null;
      });
    }
  }

  Future<File> resizeImage(File originalImage) async {
    final img.Image image = img.decodeImage(originalImage.readAsBytesSync())!;
    final img.Image resizedImage =
        img.copyResize(image, width: 300, height: 300);
    final File resizedFile = File(originalImage.path)
      ..writeAsBytesSync(img.encodePng(resizedImage));

    return resizedFile;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            body: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (imageFile != null)
                Container(
                  width: 300,
                  height: 300,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.white24,
                    border: Border.all(width: 8, color: Colors.black38),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Image.file(imageFile!),
                )
              else
                Container(
                  width: 640,
                  height: 400,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.white24,
                    border: Border.all(width: 8, color: Colors.black38),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Text('Your Image'),
                ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Expanded(
                      child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xff519e94)),
                    onPressed: () => pickImage(ImageSource.camera),
                    child: const Text('Capture Image'),
                  )),
                  SizedBox(
                    width: 20,
                  ),
                  Expanded(
                      child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xff519e94)),
                    onPressed: () => pickImage(ImageSource.gallery),
                    child: const Text('Select Image'),
                  ))
                ],
              ),
              Center(
                  child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xff519e94)),
                onPressed: () {
                  if (imageFile == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text('Please upload an image first')),
                    );
                  } else {
                    // Show the privacy and security alert
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text(
                            'Privacy and Security Alert:',
                            style: TextStyle(fontSize: 17),
                          ),
                          content: const SingleChildScrollView(
                            child: Column(
                              children: <Widget>[
                                Text(
                                  "By choosing to scan this image, you agree to our privacy and security policies."
                                  ' We pledge to protect your image and use it solely for the purpose of examining the disease. Your privacy and data security are of utmost importance to us.',
                                  style: TextStyle(fontSize: 14),
                                ),
                              ],
                            ),
                          ),
                          actions: <Widget>[
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Color(0xff519e94),
                                textStyle: TextStyle(
                                    color: Colors.white), // Set the text color
                              ),
                              onPressed: () {
                                Navigator.of(context).pop();
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ScanResultWidget(
                                      dermatosisName: result,
                                      percentage: percent,
                                      imageFile: imageFile,
                                    ),
                                  ),
                                );
                              },
                              child: Text('Agree and Scan'),
                            ),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Color(0xff519e94),
                                textStyle: TextStyle(
                                    color: Colors.white), // Set the text color
                              ),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text('Decline and Exit'),
                            ),
                          ],
                        );
                      },
                    );
                  }
                },
                child: const Text('Scan Image'),
              ))
            ],
          ),
        )));
  }
}