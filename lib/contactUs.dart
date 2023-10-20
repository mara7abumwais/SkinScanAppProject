import 'package:flutter/material.dart';

class ContactUsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('Contact Us'),
          backgroundColor: Color.fromARGB(200, 5, 88, 106),
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
                  color: Color.fromARGB(200, 5, 88, 106),
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              TextFormField(
                decoration: InputDecoration(labelText: 'Your Name'),
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Your Email'),
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Subject'),
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Message'),
                maxLines: 4,
              ),
              SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(200, 5, 88, 106),
                    minimumSize: Size(200, 60),
                  ),
                  onPressed: () {
                    // Handle sending the message
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
