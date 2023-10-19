import 'package:flutter/material.dart';

class ScanResultWidget extends StatelessWidget {
  final String dermatosisName;
  final double percentage;
  final String clinics;
  final String treatment;

  ScanResultWidget({
    required this.dermatosisName,
    required this.percentage,
    required this.clinics,
    required this.treatment,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Scan Result'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
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
            SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                // Navigate to the screen for a new scan
                Navigator.of(context).pop();
              },
              child: Text('New Scan'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Navigate to the chatbot screen
                // Replace 'ChatbotScreen' with the actual screen where you implement the chatbot functionality
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


void main() => runApp(MaterialApp(home: ScanResultWidget(
  dermatosisName: 'Sample Dermatosis',
  percentage: 85.5,
  clinics: 'Sample Clinics',
  treatment: 'Sample Treatment',
)));
