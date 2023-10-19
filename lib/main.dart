import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firstseniorproject/firebase_options.dart';

import 'package:firstseniorproject/changePassword.dart';
import 'package:firstseniorproject/chatbot.dart';
import 'package:firstseniorproject/clinics.dart';
import 'package:firstseniorproject/createPassword.dart';
import 'package:firstseniorproject/records.dart';
import 'package:firstseniorproject/scan.dart';
import 'package:firstseniorproject/scanResult.dart';
import 'package:flutter/material.dart';
import 'TabNavigation.dart';
import 'signUp.dart';
import 'Login.dart';
import 'myAnimation.dart';
import 'IntroScreen.dart';

Future< void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp( options: DefaultFirebaseOptions.currentPlatform,);
  runApp(MyApp());
}
final NavigatorKey=GlobalKey<NavigatorState>();
class MyApp extends StatelessWidget {
  // This widget is the root of my application.
  @override

  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: NavigatorKey,
      debugShowCheckedModeBanner: false,
      title: 'SkinScan',
      theme: ThemeData(
          brightness: Brightness.dark
      ),
      routes: <String, WidgetBuilder>{
        '/': (BuildContext ctx) => MyAnimation(),
        '/signUp': (BuildContext ctx) =>signUp(),
        '/introScreen': (BuildContext ctx) => IntroScreen(),
        '/login':(BuildContext ctx)=>StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context,snapshot) {
            if(snapshot.connectionState==ConnectionState.waiting){
              return Center(child: CircularProgressIndicator(),);
            }else if(snapshot.hasError){
              return Center(child: Text('something went wrong!'),);
            }
           else if(snapshot.hasData){
              return TabNavigation();
            } else {
            return Login();

            }
          }
        ),
        '/tabNavigation': (BuildContext ctx) =>TabNavigation(),
        '/scan':(BuildContext ctx) => CameraWidget(),
        '/scanResult':(BuildContext ctx) => ScanResultWidget(dermatosisName: 'x', percentage: 90, clinics: "c1,c2", treatment: "t1"),
        '/Chatbot':(BuildContext ctx)=> ChatHome(),
        '/forgetPassword':(BuildContext ctx) => ForgotPassword(),
        '/records':(BuildContext ctx) => Records(),
        '/createPassword':(BuildContext ctx) => CreatePassword(),
        '/clinics':(BuildContext ctx) => Clinics(),
      },
    );
  }
}
