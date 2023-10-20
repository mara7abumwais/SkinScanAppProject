import 'package:flutter/material.dart';

class AboutUsPage extends StatelessWidget {
  const AboutUsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home:  Scaffold(
        appBar: AppBar(
          title: Text('About Us'),
          backgroundColor: Color.fromARGB(200, 5, 88, 106),
        ),
        body: Padding(
          padding:  EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text(
                'About SkinScan App:',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              const Text(
                'SkinScan is a mobile app designed to assist users in '
                    'detecting skin issues and dermatosis using image scanning. '
                    'The app uses advanced machine learning models to analyze '
                    'images of skin spots and provide potential dermatosis diagnoses '
                    'along with a percentage probability.',
              ),
              SizedBox(height: 20),
              const Text(
                'Our Mission:',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              const Text(
                'Our mission is to empower individuals to take control of their skin health. '
                    'SkinScan app aims to provide accessible and accurate skin scan results to '
                    'users, promoting early detection and timely care for dermatological conditions.',
              ),
              SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(200, 5, 88, 106),
                    minimumSize: Size(200, 60),
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, '/contactUs');
                  },
                  child: Text('Contact Us'),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
