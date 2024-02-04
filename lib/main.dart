import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firstseniorproject/aboutUs.dart';
import 'package:firstseniorproject/contactUs.dart';
import 'package:firstseniorproject/dermatosisInsight.dart';
import 'package:firstseniorproject/editProfile.dart';
import 'package:firstseniorproject/myAnimation.dart';
import 'package:firstseniorproject/privacyAndSecurity.dart';
import 'package:firstseniorproject/services/firebase_options.dart';
import 'package:firstseniorproject/forgetPassword.dart';
import 'package:firstseniorproject/clinics.dart';
import 'package:firstseniorproject/createPassword.dart';
import 'package:firstseniorproject/profile.dart';
import 'package:firstseniorproject/records.dart';
import 'package:firstseniorproject/scan.dart';
import 'package:firstseniorproject/userGuide.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'TabNavigation.dart';
import 'signUp.dart';
import 'Login.dart';
import 'IntroScreen.dart';
import 'verify.dart';
import 'chatbot.dart';
import 'addt.dart';
import 'treatment.dart';


Future< void> main() async {
  await dotenv.load(fileName: ".env");
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp( options: DefaultFirebaseOptions.currentPlatform,);
  runApp(MyApp());
  runApp(MyApp());
}
final NavigatorKey=GlobalKey<NavigatorState>();
class MyApp extends StatelessWidget {
  @override

  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: NavigatorKey,
      debugShowCheckedModeBanner: false,
      title: 'SkinScan',
      theme: ThemeData(
         brightness: Brightness.light
      ),
      routes: <String, WidgetBuilder>{
        '/': (BuildContext ctx) => MyAnimation(),
        //'/': (BuildContext ctx) => UserGuide(),
        '/signUp': (BuildContext ctx) =>StreamBuilder(
            stream: FirebaseAuth.instance.authStateChanges(), builder: (context,snapshot){
          if(snapshot.hasData){
            return VerifyScreen();
          } else {
            return signUp();
          }
            }),
        '/introScreen': (BuildContext ctx) => IntroScreen(),
        '/login':(BuildContext ctx)=>StreamBuilder(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context,snapshot) {
              if(snapshot.connectionState==ConnectionState.waiting){
                return Center(child: CircularProgressIndicator(),);
              }else if(snapshot.hasError){
                return Center(child: Text('something went wrong!'),);
              }
              else {
                return Login();
              }
            }),
        '/tabNavigation': (BuildContext ctx) =>TabNavigation(0),
        '/scan':(BuildContext ctx) => CameraWidget(),
        '/forgetPassword':(BuildContext ctx) => ForgotPassword(),
        '/records':(BuildContext ctx) => Records(),
        '/createPassword':(BuildContext ctx) => CreatePassword(),
        '/clinics':(BuildContext ctx) => Clinics(cityName: 'All Cities',),
        '/profile':(BuildContext ctx) => Profile(),
        '/editProfile':(BuildContext ctx) => EditProfile(),
        '/contactUs':(BuildContext ctx)=> ContactUsPage(),
        '/aboutUs':(BuildContext ctx)=> AboutUsPage(),
        '/verify':(BuildContext ctx)=>  VerifyScreen(),
        '/dermatosisInsight':(BuildContext ctx)=>DermatosisInsight(),
        '/privacyAndSecurity':(BuildContext ctx)=> PrivacyAndSecurityPage(),
        '/Chatbot':(BuildContext ctx)=> ChatBody(),
      },
    );
  }
}

