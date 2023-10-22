import 'dart:io';
import 'package:firstseniorproject/scanResult.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image/image.dart' as img;


class CameraWidget extends StatefulWidget {
  const CameraWidget({super.key});

  @override
  _CameraWidgetState createState() => _CameraWidgetState();
}

class _CameraWidgetState extends State<CameraWidget> {

  File? imageFile;

  pickImage(ImageSource source) async {
    final picker = ImagePicker();
    final XFile? xFile = await picker.pickImage(source: source, imageQuality: 85);

    if (xFile != null) {
      final File imageFile = File(xFile.path);

      final int fileSizeKB = (await imageFile.length()) ~/ 1024; // File size in KB

      if (fileSizeKB < 200) {
        // Show a SnackBar if the file size is less than 200KB
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Image quality is not sufficient. Please choose a higher-quality image.'),
          ),
        );
        setState(() {
          this.imageFile = null;
        });
      } else {
        final img.Image? originalImage = img.decodeImage(imageFile.readAsBytesSync());

        if (originalImage != null) {
          final img.Image resizedImage = img.copyResize(originalImage, width: 200, height: 200);
          final File resizedFile = File(imageFile.path)
            ..writeAsBytesSync(img.encodePng(resizedImage));

          setState(() {
            this.imageFile = resizedFile;
          });
        }
      }
    } else {
      setState(() {
        this.imageFile = null;
      });
    }
  }

/*
pickImage(ImageSource source)
  {
    AppImagePicker(source: source).pick(onPick: (File? imageFile)
    {
       setState(() {
         this.imageFile = imageFile;
       });
    });
  }
 */
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
                  width: 640,
                  height: 400,
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
                  const SizedBox(height: 20,),
                  Row(
                    children: [
                      Expanded(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(backgroundColor: Color.fromARGB(200, 5, 88, 106)),
                            onPressed: ()=> pickImage(ImageSource.camera),
                            child: const Text('Capture Image'),
                          )
                      ),
                      SizedBox(width: 20,),
                      Expanded(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(backgroundColor: Color.fromARGB(200, 5, 88, 106)),
                            onPressed: ()=> pickImage(ImageSource.gallery),
                            child: const Text('Select Image'),
                          )
                      )
                    ],
                  ),
                  Center(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(backgroundColor: Color.fromARGB(200, 5, 88, 106)),
                        onPressed: ()
                        {
                          if(imageFile== null)
                            {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Please upload image first'))
                              );
                            }else{
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ScanResultWidget(
                                  dermatosisName: 'Eczema',
                                  percentage: 90,
                                  clinics: "Jenin Clinic, Nablus Clinic",
                                  treatment: "treatment 1",
                                  imageFile: imageFile,
                                ),
                              ),
                            );
                          }
                        },
                        child: const Text('Scan Image'),
                      )
                  )
                ],
              ),
            )
        )
    );
  }
}

/*
class AppImagePicker{
  ImageSource source;

  AppImagePicker({required this.source});

  pick({onPick})async
  {
    final ImagePicker picker = ImagePicker();
    final image =  await picker.pickImage(source: source,imageQuality: 90);

    if(image != null)
      {
        onPick(File(image.path));
      }
    else
      {
        onPick(null);
      }
  }
}*/