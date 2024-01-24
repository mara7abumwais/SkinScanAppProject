import 'dart:io';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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

  @override
  void initState() {
    super.initState();
    userId = user.id;
  }

  Future<void> saveRecord() async {
    try {
      String recordId = FirebaseFirestore.instance.collection('records').doc().id;

      await FirebaseFirestore.instance.collection('records').doc(recordId).set({
        'record_id': recordId,
        'user_id': userId,
        'percent': widget.percentage,
        'dermatosis': widget.dermatosisName,
        'record_date': DateTime.now().toString(),
      });

      print('Record saved successfully.');
    } catch (error) {
      print('Error saving record: $error');
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
            if (widget.imageFile != null)
              Container(
                width: 300,
                height: 300,
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
              style: TextStyle(fontSize: 18, color: Color(0xff519e94),),
            ),
            SizedBox(height: 20),
            Text(
              'Percentage: ${widget.percentage.toStringAsFixed(2)}%',
              style: TextStyle(fontSize: 18, color: Color(0xff519e94),),
            ),
            SizedBox(height: 20),
            if (widget.percentage > 70)
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Color(0xff519e94)),
                onPressed: () {
                  // Navigate to treatment
                  Navigator.pushNamed(context, '/treatment');
                },
                child: Text('View Treatment'),
              )
            else
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Color(0xff519e94)),
                onPressed: () {
                  // Navigate to clinics
                  Navigator.pushNamed(context, '/clinics');
                },
                child: Text('Show Clinics'),
              ),
            SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Color(0xff519e94)),
              onPressed: () {
                saveRecord();
              },
              child: Text('Save Record'),
            ),
            SizedBox(height: 20),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Color(0xff519e94)),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('New Scan'),
                ),
                SizedBox(width: 30),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Color(0xff519e94)),
                  onPressed: () {
                    Navigator.pushNamed(context, '/Chatbot');
                  },
                  child: Text('Use Chatbot'),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
