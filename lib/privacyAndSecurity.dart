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
                '- Improve our services and develop new features.',
                style: TextStyle(fontSize: 14),
              ),
              Text(
                '2. Data Security',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'We take data security seriously and have implemented measures to protect your information from unauthorized access. This includes encryption, secure data storage, and access controls.',
                style: TextStyle(fontSize: 14),
              ),
              Text(
                '3. Data Sharing',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'We do not share your personal information and uploaded data with third parties unless required by law or with your explicit consent.',
                style: TextStyle(fontSize: 14),
              ),
              Text(
                '4. Changes to Privacy Policy',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'We may update this privacy policy from time to time. You will be notified of any changes, and the updated policy will be posted on our website and within the app.',
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
                '1. Encryption:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Text(
                'All data transmitted between your device and our servers is encrypted using industry-standard encryption protocols to prevent interception by third parties.',
                style: TextStyle(fontSize: 14),
              ),
              Text(
                '2. Secure Data Storage:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Text(
                'Your personal information and uploaded data are stored securely on our servers. Access to this data is strictly controlled and monitored.',
                style: TextStyle(fontSize: 14),
              ),
              Text(
                '3. Access Controls:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Text(
                'Access to user data is restricted to authorized personnel only. Our team undergoes regular security training to ensure the safety of your information.',
                style: TextStyle(fontSize: 14),
              ),
              Text(
                '4. Data Retention Policy:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Text(
                'We retain your data only for as long as necessary to provide our services. When your data is no longer needed, it is securely deleted.',
                style: TextStyle(fontSize: 14),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
