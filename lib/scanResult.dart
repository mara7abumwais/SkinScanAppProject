import 'dart:io';
import 'package:flutter/material.dart';

class ScanResultWidget extends StatelessWidget {
  final String dermatosisName;
  final double percentage;
  final String clinics;
  final String treatment;
  final File? imageFile;

  ScanResultWidget({
    required this.dermatosisName,
    required this.percentage,
    required this.clinics,
    required this.treatment,
    required this.imageFile
  });

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
              ),
            SizedBox(height: 20,),
            Text(
              'Dermatosis Name: $dermatosisName',
              style: TextStyle(fontSize: 18,color: Color(0xff519e94),)
            ),
            SizedBox(height: 20),
            Text(
              'Percentage: ${percentage.toStringAsFixed(2)}%',
              style:TextStyle(fontSize: 18,color: Color(0xff519e94),)
            ),
            SizedBox(height: 20),
            Text(
              'Clinics: $clinics',
              style: TextStyle(fontSize: 18,color: Color(0xff519e94),)
            ),
            SizedBox(height: 20),
            Text(
              'Treatment: $treatment',
              style:TextStyle(fontSize: 18,color: Color(0xff519e94),)
            ),
            SizedBox(height: 20),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor:Color(0xff519e94)),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('New Scan'),
                ),
                SizedBox(width: 30),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor:Color(0xff519e94)),
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

