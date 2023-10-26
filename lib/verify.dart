import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import "IntroScreen.dart";
import 'package:flutter/material.dart';

class VerifyScreen extends StatefulWidget {
  @override
  _VerifyScreenState createState() => _VerifyScreenState();
}

class _VerifyScreenState extends State<VerifyScreen> {
  bool isEmailVerify=false;
  final auth = FirebaseAuth.instance;
  User? user;
  Timer? timer;

  @override
  void initState() {
    user = auth.currentUser;
    user!.sendEmailVerification();

    timer = Timer.periodic(Duration(seconds: 5), (timer) {
      checkEmailVerified();
    });
    super.initState();
  }

  @override
  void dispose() {
    timer!.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Verify Email',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 22),),
                SizedBox(height: 20,),
                Icon(Icons.mark_email_unread,color: Color(0xff519e94),size: 80,),
                SizedBox(height: 20,),
                Text('An email has been sent to ${user!.email} please verify',textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 18,
                    )),
                SizedBox(height: 20,),
                ElevatedButton(onPressed:()=>user!.sendEmailVerification(),
                  style: ElevatedButton.styleFrom(backgroundColor: Color(0xff519e94)),
                  child: Text('Resent Email',style: TextStyle(color: Colors.white),),),
                SizedBox(height: 20,),
                ElevatedButton(onPressed:()=>FirebaseAuth.instance.signOut() ,
                  style: ElevatedButton.styleFrom(backgroundColor: Color(0xff519e94),),
                  child: Text('cancel',style: TextStyle(color: Colors.white))),
              ],
            ),
          )),
    );
  }

  Future<void> checkEmailVerified() async {
    user = auth.currentUser;
    await user!.reload();
    if (user!.emailVerified) {
      timer!.cancel();
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) =>IntroScreen() ));
    }
  }
}