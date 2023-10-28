import 'package:flutter/material.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';

void main() => runApp(ContactUsApp());

class ContactUsApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ContactUsPage(),
    );
  }
}

class ContactUsPage extends StatefulWidget {
  const ContactUsPage({super.key});

  @override
  State<ContactUsPage> createState() => _ContactUsPageState();
}

final _nameController = TextEditingController();
final _emailController = TextEditingController();
final _subjectController = TextEditingController();
final _messageController = TextEditingController();
bool showSnack = false;
late String messageS;

class _ContactUsPageState extends State<ContactUsPage> {
  Future sendEmail(BuildContext context) async {
    const username = "marahabumwais@gmail.com";
    const password = "kmxc jloa wdlo hnux";
    final smtpServer = gmail(username, password);
    final message = Message()
      ..from = Address(username, _nameController.text)
      ..recipients.add("1652001.com@gmail.com")
      ..subject = _subjectController.text
      ..text = "This message from email: + ${_emailController.text}\n $_messageController";

    try {
      await send(message, smtpServer);
      messageS = "Your email sent successfully";
    } catch (e) {
      messageS = "Error happened, try later!";
    }
    showSnack = true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contact Us'),
        backgroundColor: Color(0xff519e94),
      ),
      body: SingleChildScrollView(
        child: Padding(
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
                  onPressed: () async {
                    await sendEmail(context);
                    if (showSnack) {
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(messageS),backgroundColor: Color(0xff519e94),showCloseIcon: true,));
                    }
                  },
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
