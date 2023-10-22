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
        backgroundColor: Color.fromARGB(200, 5, 88, 106),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
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
              ),
            Text(
              'Dermatosis Name: $dermatosisName',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 20),
            Text(
              'Percentage: ${percentage.toStringAsFixed(2)}%',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 20),
            Text(
              'Clinics: $clinics',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 20),
            Text(
              'Treatment: $treatment',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 20),
            ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor:Color.fromARGB(200, 5, 88, 106)),
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('New Scan'),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor:Color.fromARGB(200, 5, 88, 106)),
              onPressed: () {
                Navigator.pushNamed(context, '/Chatbot');
              },
              child: Text('Talk to Chatbot'),
            ),
          ],
        ),
      ),
    );
  }
}

