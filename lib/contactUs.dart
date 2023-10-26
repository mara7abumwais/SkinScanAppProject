import 'package:flutter/material.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';

class ContactUsPage extends StatelessWidget {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _subjectController = TextEditingController();
  final _messageController = TextEditingController();

  Future sendEmail() async {
    const email = "1652001.com@gmail.com";


   // final stmpServer = gmailSaslXoauth2(email, accessToken);
    final message = Message()
      ..from = Address(_emailController.text, _nameController.text)
      ..recipients.add('marahabumwais@gmail.com')
      ..subject = _subjectController.text
      ..text = 'Message from:';

    try {
 //     await send(message, smtpServer);
      print('s');
    } on MailerException catch (e) {
      print('Message not sent. Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('Contact Us'),
          backgroundColor: Color(0xff519e94),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: 20),
              const Text(
                'Send us a Message:',
                style: TextStyle(
                  fontSize: 20,
                  color: Color(0xff519e94),
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Your Name'),
              ),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(labelText: 'Your Email'),
              ),
              TextFormField(
                controller: _subjectController,
                decoration: InputDecoration(labelText: 'Subject'),
              ),
              TextFormField(
                controller: _messageController,
                decoration: InputDecoration(labelText: 'Message'),
                maxLines: 4,
              ),
              SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xff519e94),
                    minimumSize: Size(200, 60),
                  ),
                  onPressed: sendEmail, // Call the sendEmail function
                  child: Text('Send Message'),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
