import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
// import 'FadeAnimation.dart';

void main() =>
    runApp(Login());

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool _showPassword = false;
  final emailcontroller=TextEditingController();
  final passwordcontroller=TextEditingController();


  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.transparent, // Make Scaffold background transparent
      body: Stack(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/login.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 40),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        child: const Text(
                          "Login",
                          style: TextStyle(
                              color: Color.fromARGB(200, 5, 88, 106),
                              fontWeight: FontWeight.bold,
                              fontSize: 30),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(vertical: 13, horizontal: 3),
                        child:const Text(
                          "Welcome back",
                          style: TextStyle(color: Colors.grey, fontSize: 15),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                            boxShadow: const[
                              BoxShadow(
                                color: Color.fromARGB(200, 5, 88, 106),
                                blurRadius: 20,
                                offset: Offset(0, 10),
                              )
                            ]),
                        child: Column(
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(),
                              child: TextField(
                                controller:emailcontroller,
                                style: TextStyle(color: Colors.black),
                                decoration:  InputDecoration(
                                  hintText: "Email address",
                                  //  suffixStyle: TextStyle(color: Colors.black),
                                  hintStyle: TextStyle(color: Colors.grey),
                                  prefixIcon: Icon(Icons.email),
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(10),
                              child: TextField(
                                controller: passwordcontroller,
                                style: TextStyle(color: Colors.black),
                                // controller: _passwordController,
                                decoration: InputDecoration(
                                  hintText: "Password",
                                  hintStyle: TextStyle(color: Colors.grey),
                                  prefixIcon: Icon(Icons.lock),
                                  suffixIcon: IconButton(
                                    icon: Icon(_showPassword
                                        ? Icons.visibility
                                        : Icons.visibility_off),
                                    onPressed: () {
                                      setState(() {
                                        _showPassword = !_showPassword;
                                      });
                                    },
                                  ),
                                ),
                                obscureText: !_showPassword,
                              ),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      GestureDetector(
                        onTap: ()
                        {
                          setState(() {
                            Navigator.pushNamed(context, '/forgetPassword');
                          });
                        },
                        child: const Center(
                            child: Text(
                              "Forgot Password?",
                              style: TextStyle(color: Color.fromARGB(200, 5, 88, 106)),
                            )),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      GestureDetector(
                        onTap:  () {
                          setState(() {
                            signIn();
                            // Navigator.pushNamed(context, '/tabNavigation');
                          });
                        },
                        child: Container(
                          // height: 60,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50.0),
                              color: Color.fromARGB(200,5, 88, 106)
                          ),
                          margin: EdgeInsets.symmetric(horizontal: 85),
                          padding: EdgeInsets.symmetric(vertical: 20,horizontal: 100),
                          child: const Text(
                            "Login",
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),),
                      ),
                      const SizedBox(
                        height: 30,),
                      Center(
                        child: ElevatedButton(
                          onPressed: () {
                            setState(() {
                              Navigator.pushNamed(context, '/signUp');
                            });
                          },
                          style: ButtonStyle(
                            backgroundColor:
                            MaterialStateColor.resolveWith((states) => Color.fromARGB(200, 5, 88, 106)),
                          ),
                          child: const Text(
                            "Create Account",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),),
                      const SizedBox(
                        height: 30,
                      ),
                    ],
                  ),
                )
              ],
            )
          ],
        ),
    );
  }
  Future signIn( )async{
  
    try{
  await FirebaseAuth.instance.signInWithEmailAndPassword(
    email: emailcontroller.text.trim(), password: passwordcontroller.text.trim());
    } on FirebaseAuthException catch(e){
      print(e);
    }

}
}

