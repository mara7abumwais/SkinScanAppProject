import 'package:firstseniorproject/contactUs.dart';
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
          backgroundColor: Color(0xff519e94),
          leading: BackButton(
            onPressed: (){
              Navigator.pop(context);
            },),
        ),
        body: Padding(
          padding:  EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Text(
                  'About SkinScan App:',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10),
                const Text(
                  'SkinScan is a mobile app designed to assist users in '
                      'detecting skin issues and dermatosis using image scanning. '
                      'The app uses advanced machine learning models to analyze '
                      'images of skin spots and provide potential dermatosis diagnoses '
                      'along with a percentage probability.',style: TextStyle(fontSize: 15),
                ),
                SizedBox(height: 20),
                const Text(
                  'Our Mission:',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10),
                const Text(
                  "Our mobile application, developed by a team of students at Arab American University,"
                      " marks a significant milestone in dermatological care. Marah Abumwais, our talented backend developer,"
                      " and Roba Abu Farha and Dalal Zakarneh, our skilled front-end developers, have put their expertise and passion into"
                      " creating a cutting-edge solution for dermatoses diagnosis "
                      "As students at Arab American University, this project is the culmination of our senior project, "
                      "representing our commitment to making a positive impact in the healthcare field. Our app harnesses the power of AI technology to offer "
                      "a precise and efficient diagnosis of dermatoses through a mobile device and an internet connection. "
                      "It is our mission to enhance accessibility to dermatological care, ensuring that individuals worldwide "
                      "can take control of their skin health and receive the guidance they need, no matter where they are."
                      "While our app is a valuable tool, it's important to emphasize that it is not a replacement for"
                      " a professional medical diagnosis. Users should always consult a dermatologist or a qualified healthcare provider"
                      " if they have health concerns."
                      "Join us on our journey to redefine dermatological care and bring about positive change in the lives of individuals everywhere.",
                  style: TextStyle(fontSize: 15),
                ),
                SizedBox(height: 40),
                Center(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xff519e94),
                      minimumSize: Size(200, 60),
                    ),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => ContactUsPage()
                          ));
                    },
                    child: Text('Contact Us',style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                  ),
                )
              ],
            ),
          )
        ),
      ),
    );
  }
}
