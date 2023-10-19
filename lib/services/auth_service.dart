import 'package:firebase_auth/firebase_auth.dart';
import 'package:firstseniorproject/TabNavigation.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../Login.dart';

class AuthService {
  handelAuthState(){
    return StreamBuilder(
      stream:  FirebaseAuth.instance.authStateChanges(),
      builder: (BuildContext context, snapchot) {
        if(snapchot.hasData)
        {
          return TabNavigation();
        }
        else{
          return Login();
        }
      },
    );
  }

  signInWithGoogle ()async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn(
        scopes: <String>["email"]).signIn();

    final GoogleSignInAuthentication googleAuth = await googleUser!.authentication;

    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }
  signOut()
  {
    FirebaseAuth.instance.signOut();
  }
}
