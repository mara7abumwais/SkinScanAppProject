import 'dart:io';

import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:image_picker/image_picker.dart';

class CameraWidget extends StatefulWidget {
  @override
  _CameraWidgetState createState() => _CameraWidgetState();
}

class _CameraWidgetState extends State<CameraWidget> {

  File? imageFile;

  Future getImageFromCamera() async{
    final file = await ImagePicker().pickImage(source: ImageSource.camera,
    );
    if(imageFile == null)
      return;
    setState(() {
      imageFile = File(file!.path);
    });
  }

  Future getImageFromGallery() async{
    final file = await ImagePicker().pickImage(source: ImageSource.gallery,
    );
    if(imageFile == null)
      return;
    setState(() {
      imageFile = File(file!.path);
    });
  }

  @override
  void initState() {
    super.initState();}

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
                  /*Container(
                  width: 640,
                  height: 400,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.white24,
                    image: DecorationImage(
                      image: FileImage(imageFile!),
                      fit: BoxFit.cover,
                    ),
                    border: Border.all(width: 8, color: Colors.black38),
                    borderRadius: BorderRadius.circular(12),
                  ),
                )*/
                    Image.file(imageFile!)
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
                            style: ElevatedButton.styleFrom(backgroundColor: Color.fromARGB(200, 5, 8, 106)),
                            onPressed: ()=> getImageFromCamera(),
                            child: const Text('Capture Image'),
                          )
                      ),
                      SizedBox(width: 20,),
                      Expanded(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(backgroundColor: Color.fromARGB(200, 5, 8, 106)),
                            onPressed: ()=> getImageFromGallery(),
                            child: const Text('Select Image'),
                          )
                      )
                    ],
                  )
                ],
              ),
            )
        )
    );
  }

}