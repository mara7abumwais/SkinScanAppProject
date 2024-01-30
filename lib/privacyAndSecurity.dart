import 'package:flutter/material.dart';


class PrivacyAndSecurityPage extends StatelessWidget {
  const PrivacyAndSecurityPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Privacy and Security'),
        backgroundColor: Color(0xff519e94), // Your app's color
      ),
      body: const Padding(
        padding: const EdgeInsets.all(14.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Center(
                child: Text(
                  'Privacy Policy',
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Your privacy is important to us. This privacy policy explains how we collect, use, and protect your personal information when you use our application.',
                style: TextStyle(fontSize: 14),
              ),
              Text(
                '1. Information Collection and Use',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'We may collect information that you provide when using our app, including but not limited to:',
                style: TextStyle(fontSize: 14),
              ),
              Text(
                '- Personal information such as your name and email address.',
                style: TextStyle(fontSize: 14),
              ),
              Text(
                '- Images and data you voluntarily upload for dermatological analysis.',
                style: TextStyle(fontSize: 14),
              ),
              Text(
                'We use this information to:',
                style: TextStyle(fontSize: 14),
              ),
              Text(
                '- Provide dermatological analysis services.',
                style: TextStyle(fontSize: 14),
              ),
              Text(
                '2. Data Sharing',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'We do not share your personal information and uploaded data with third parties',
                style: TextStyle(fontSize: 14),
              ),
              SizedBox(height: 20),
              Center(
                child: Text(
                  'Security Measures',
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 10),
              Text(
                'We take your data security seriously and have implemented the following security measures to protect your information from unauthorized access:',
                style: TextStyle(fontSize: 14),
              ),
              Text(
                '1. Secure Data Storage:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Text(
                'Your personal information and uploaded data are stored securely on our servers. Access to this data is strictly controlled and monitored.',
                style: TextStyle(fontSize: 14),
              ),
              Text(
                '2. Access Controls:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Text(
                'Access to user data is restricted to authorized personnel only. Our team undergoes regular security training to ensure the safety of your information.',
                style: TextStyle(fontSize: 14),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
