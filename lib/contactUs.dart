import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';

class ContactUsPage extends StatefulWidget {
  const ContactUsPage({super.key});

  @override
  State<ContactUsPage> createState() => _ContactUsPageState();
}

class _ContactUsPageState extends State<ContactUsPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contact Us'),
        backgroundColor: Color(0xff519e94),
        leading: BackButton(),
      ),
      body: ContactForm(),
    );
  }

}

class ContactForm extends StatefulWidget {
  @override
  State<ContactForm> createState() => _ContactFormState();
}

class _ContactFormState extends State<ContactForm> {

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _subjectController = TextEditingController();
  final _messageController = TextEditingController();

  bool isLoading = false;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              controller: _nameController,
              decoration: InputDecoration(labelText: "Name"),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your name';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _emailController,
              decoration: InputDecoration(labelText: "Email"),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your email';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _subjectController,
              decoration: InputDecoration(labelText: "Subject"),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your subject';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _messageController,
              maxLines: 5,
              decoration: InputDecoration(labelText: "Message"),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your message';
                }
                return null;
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xff519e94),
                minimumSize: Size(200, 60),
              ),
              onPressed: submit,
              child: Text('Send Message'),
            ),
          ],
        ),
      )
    );
  }

  Future submit() async {
    if (_formKey.currentState?.validate() ?? false) {
      setState(() {
        isLoading = true;
      });

      await _sendEmail();

      setState(() {
        isLoading = false;
      });
    }
  }

  Future _sendEmail() async {
    const username = "marahabumwais@gmail.com";
    final password = dotenv.env['API_PASSWORD'];
    final smtpServer = gmail(username, password!);

    final message = Message()
      ..from = Address(username, _nameController.text)
      ..recipients.add("1652001.com@gmail.com")
      ..subject = _subjectController.text
      ..text = "This message from email: + ${_emailController.text}\n ${_messageController.text}";

    try {
      await send(message, smtpServer);
      _showSnackBar("Your email sent successfully! We will contact you soon.");
    } catch (e) {
      print(e);
      _showSnackBar('Error while sending email! Try later.');
    }
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message),duration: Duration(seconds: 5),
        backgroundColor: Color(0xff519e94),),
    );
  }

}