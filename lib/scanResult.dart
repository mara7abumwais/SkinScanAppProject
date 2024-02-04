import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firstseniorproject/TabNavigation.dart';
import 'package:firstseniorproject/treatment.dart';
import 'package:flutter/material.dart';
import 'clinics.dart';
import 'user_singleton.dart';

class ScanResultWidget extends StatefulWidget {
  final String dermatosisName;
  final double percentage;
  final File? imageFile;

  ScanResultWidget({
    required this.dermatosisName,
    required this.percentage,
    required this.imageFile,
  });

  @override
  _ScanResultWidgetState createState() => _ScanResultWidgetState();
}

class _ScanResultWidgetState extends State<ScanResultWidget> {
  final user = UserSingleton().user;
  late String userId;
  late String city;

  @override
  void initState() {
    super.initState();
    if (user != null) {
      userId = user.id;
      city = user.city[0].toUpperCase() + user.city.substring(1);
      print(city);
    }
  }

  Future<void> saveRecord() async {
    try {
      String recordId = FirebaseFirestore.instance.collection('records').doc().id;

      // Upload image to Firebase Storage
      String imageUrl = await uploadImage(widget.imageFile!, recordId);

      // Save record details in Firestore
      await FirebaseFirestore.instance.collection('records').doc(recordId).set({
        'record_id': recordId,
        'user_id': userId,
        'percent': widget.percentage,
        'dermatosis': widget.dermatosisName,
        'record_date': DateTime.now().toString(),
        'image_url': imageUrl, // Save image URL along with other details
      });

      print('Record saved successfully.');
    } catch (error) {
      print('Error saving record: $error');
    }
  }

  Future<String> uploadImage(File imageFile, String recordId) async {
    try {
      // Create a reference to the image in Firebase Storage
      Reference storageReference = FirebaseStorage.instance.ref().child('images/$recordId.jpg');

      // Upload the image to Firebase Storage
      UploadTask uploadTask = storageReference.putFile(imageFile);
      TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => null);

      // Get the download URL of the uploaded image
      String imageUrl = await taskSnapshot.ref.getDownloadURL();

      return imageUrl;
    } catch (error) {
      print('Error uploading image: $error');
      throw error;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Scan Result'),
        backgroundColor: Color(0xff519e94),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(20),
              margin: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Color(0xff519e94),width: 5),
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                      color: Color(0xff519e94),
                      blurRadius: 7.0,
                      offset: Offset(7,7)
                  )
                ],
              ),
              child: Column(
                children: [
                  if (widget.imageFile != null)
                    Container(
                      width: 224,
                      height: 224,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.white24,
                        border: Border.all(width: 8, color: Colors.black38),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Image.file(widget.imageFile!),
                    ),
                  SizedBox(height: 20,),
                  Text(
                      'Dermatosis Name: ${widget.dermatosisName}',
                      style: TextStyle(fontSize: 22, color: Colors.black87,fontWeight: FontWeight.bold)
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Percentage: ${widget.percentage.toStringAsFixed(2)}%',
                    style: TextStyle(fontSize: 22, color: Colors.black87,fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 20),
                 if (widget.percentage > 70)
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xff519e94),
                          textStyle: TextStyle(fontSize: 18,fontWeight: FontWeight.w600),
                          padding: EdgeInsets.all(15)
                      ),                      onPressed: () {
                        // Navigate to clinics with the specified cityName
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => treatment(dermatosisName: 'Eczema'),
                          ),
                        );
                      },
                      child: Text('View Treatment'),
                    )
                  else
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xff519e94),
                          textStyle: TextStyle(fontSize: 18,fontWeight: FontWeight.w600),
                          padding: EdgeInsets.all(15)
                      ),
                      onPressed: () {
                        // Navigate to clinics with the specified cityName
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Clinics(cityName: city),
                          ),
                        );
                      },
                      child: Text('Show Clinics'),
                    ),
                  SizedBox(height: 20),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xff519e94),
                            textStyle: TextStyle(fontSize: 18,fontWeight: FontWeight.w600),
                            padding: EdgeInsets.all(15)
                        ),                  onPressed: () {
                        Navigator.of(context).pop();
                      },
                        child: Text('New Scan'),
                      ),
                      SizedBox(width: 30),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xff519e94),
                            textStyle: TextStyle(fontSize: 18,fontWeight: FontWeight.w600),
                            padding: EdgeInsets.all(15)
                        ),                  onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => TabNavigation(3)));
                      },
                        child: Text('Use Chatbot'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 30),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white54,
                  side: BorderSide(width: 2,color: Color(0xff519e94)),
                  textStyle: TextStyle(fontSize: 18,fontWeight: FontWeight.w600),
                  padding: EdgeInsets.all(15)
              ),              onPressed: () {
              saveRecord();
            },
              child: Text('Save Record',style: TextStyle(color: Color(0xff519e94),
                  fontWeight: FontWeight.bold,
                  fontSize: 20
              ),),
            ),
          ],
        ),
      ),
    );
  }
}
