import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import "IntroScreen.dart";
import 'package:flutter/material.dart';
// import 'package:login_app/src/screens/home.dart';

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
              children: [
                Text('An email has been sent to ${user!.email} please verify',
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    )),
                ElevatedButton(onPressed:()=>user!.sendEmailVerification(), child: Text('Resent Email'),),

                ElevatedButton(onPressed:()=>FirebaseAuth.instance.signOut() , child: Text('cancel'),)
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