import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firstseniorproject/aboutUs.dart';
import 'package:firstseniorproject/contactUs.dart';
import 'package:firstseniorproject/editProfile.dart';
import 'package:firstseniorproject/myAnimation.dart';
import 'package:firstseniorproject/privacyAndSecurity.dart';
import 'package:firstseniorproject/services/firebase_options.dart';
import 'package:firstseniorproject/changePassword.dart';
import 'package:firstseniorproject/clinics.dart';
import 'package:firstseniorproject/createPassword.dart';
import 'package:firstseniorproject/profile.dart';
import 'package:firstseniorproject/records.dart';
import 'package:firstseniorproject/scan.dart';
import 'package:flutter/material.dart';
import 'TabNavigation.dart';
import 'signUp.dart';
import 'Login.dart';
import 'IntroScreen.dart';
import 'verify.dart';

Future< void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp( options: DefaultFirebaseOptions.currentPlatform,);
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
        '/': (BuildContext ctx) => Login(),
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
        '/clinics':(BuildContext ctx) => Clinics(),
        '/profile':(BuildContext ctx) => Profile(),
        '/editProfile':(BuildContext ctx) => EditProfile(),
        '/contactUs':(BuildContext ctx)=> ContactUsApp(),
        '/aboutUs':(BuildContext ctx)=> const AboutUsPage(),
        '/verify':(BuildContext ctx)=>  VerifyScreen(),
        '/privacyAndSecurity':(BuildContext ctx)=> PrivacyAndSecurityPage(),
      },
    );
  }
}

//pink
//Color.fromRGBO(228, 147, 147, 1.0)

//Beige
//Color.fromARGB(200, 220, 206, 184)


