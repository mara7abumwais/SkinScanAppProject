import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';

// import 'FadeAnimation.dart';

void main() =>
    runApp(MaterialApp(debugShowCheckedModeBanner: false, home: signUp()));

class signUp extends StatefulWidget {
  @override
  _signUpState createState() => _signUpState();
}

class _signUpState extends State<signUp> {
  bool _showPassword = true;
  final formKey = GlobalKey<FormState>();
  final namecontroller = TextEditingController();
  final agecontroller = TextEditingController();
  final emailcontroller = TextEditingController();
  final passwordcontroller = TextEditingController();
    final confpasswordcontroller = TextEditingController();

  final citycontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              height: 180,
              child: Stack(
                children: <Widget>[
                  Positioned(
                    top: -100,
                    height: 350,
                    width: width,
                    child: Container(
                      decoration: const BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage('background.png'),
                              fit: BoxFit.contain)),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(40, 0, 40, 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  // Container(
                  //   child: Text(
                  //    signUp
                  //     style: TextStyle(
                  //         color: Color.fromARGB(200, 5, 88, 106),
                  //         fontWeight: FontWeight.bold,
                  //         fontSize: 30),
                  //   ),
                  // ),

                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                        boxShadow: const [
                          BoxShadow(
                            color: Color.fromARGB(200, 5, 88, 106),
                            blurRadius: 20,
                            offset: Offset(0, 10),
                          )
                        ]),
                    child: Form(
                      key: formKey,
                      child: Column(
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 0, horizontal: 25),
                            decoration: BoxDecoration(),
                            child: TextField(
                              controller: namecontroller,
                              style: TextStyle(color: Colors.black),
                              decoration: InputDecoration(
                                hintText: "User Name",
                                hintStyle:
                                    TextStyle(color: Colors.grey, fontSize: 12),
                                prefixIcon: Icon(Icons.person),
                              ),
                            ),
                          ),
                          // Container(
                          //   padding: EdgeInsets.symmetric(vertical: 0,horizontal: 25),
                          //   decoration: BoxDecoration(),
                          //   child: TextField(
                          //     style: TextStyle(color: Colors.black),
                          //     decoration: InputDecoration(
                          //       hintText: "Last Name",
                          //       hintStyle: TextStyle(color: Colors.grey ,fontSize: 12),
                          //       prefixIcon: Icon(Icons.person),
                          //     ),
                          //   ),
                          // ),
                          Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 0, horizontal: 25),
                            decoration: BoxDecoration(),
                            child: TextField(
                              controller: agecontroller,
                              style: TextStyle(color: Colors.black),
                              decoration: InputDecoration(
                                hintText: "Age",
                                hintStyle:
                                    TextStyle(color: Colors.grey, fontSize: 12),
                                prefixIcon: Icon(Icons.person),
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 0, horizontal: 25),
                            decoration: BoxDecoration(),
                            child: TextFormField(
                              controller: emailcontroller,
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              validator: (email) => email != null &&
                                      !EmailValidator.validate(email)
                                  ? 'enter a valid email'
                                  : null,
                              style: TextStyle(color: Colors.black),
                              decoration: InputDecoration(
                                hintText: "Email address",
                                hintStyle:
                                    TextStyle(color: Colors.grey, fontSize: 10),
                                prefixIcon: Icon(Icons.email),
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 0, horizontal: 25),
                            child: TextFormField(
                              controller: passwordcontroller,
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              validator: (value) =>
                                  value != null && value.length < 6
                                      ? 'enter min. 6 characters'
                                      : null,
                              style: TextStyle(color: Colors.black),
                              decoration: InputDecoration(
                                hintText: "Password",
                                hintStyle:
                                    TextStyle(color: Colors.grey, fontSize: 12),
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
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 0, horizontal: 25),
                            child: TextFormField(
                              controller: confpasswordcontroller,
                              style: TextStyle(color: Colors.black),
                              // controller: _passwordController,
                              decoration: InputDecoration(
                                hintText: "Confirm Password",
                                hintStyle:
                                    TextStyle(color: Colors.grey, fontSize: 12),
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
                          ),
                          Container(
                            padding: EdgeInsets.fromLTRB(25, 0, 25, 15),
                            child: TextFormField(
                              controller: citycontroller,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'This field is required.';
                                }
                                return null;
                              },
                              style: TextStyle(color: Colors.black),
                              decoration: InputDecoration(
                                hintText: "City",
                                hintStyle:
                                    TextStyle(color: Colors.grey, fontSize: 12),
                                prefixIcon: Icon(Icons.location_on),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        signUp();
                      });
                    },
                    child: Container(
                      // height: 60,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50.0),
                          color: Color.fromARGB(200, 5, 88, 106)),
                      margin: EdgeInsets.symmetric(horizontal: 85),
                      padding:
                          EdgeInsets.symmetric(vertical: 20, horizontal: 80),
                      child: const Text(
                        "Sign Up",
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        Navigator.pushNamed(context, '/login');
                      });
                    },
                    child: const Center(
                        child: Text(
                      "Have an account ? Login",
                      style: TextStyle(color: Color.fromARGB(200, 5, 88, 106)),
                    )),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Future signUp() async {
    String password = passwordcontroller.text;
    String confirmPassword = confpasswordcontroller.text;
    bool match=false;

     if (password != confirmPassword) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Passwords do not match'),backgroundColor: Colors.red,
        ),
      );
    }else {
     match=true;
    }

    final isValid = formKey.currentState!.validate();
    if (!isValid && !match) return;


    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailcontroller.text.trim(),
          password: passwordcontroller.text.trim());
      addUserDetails();
      Navigator.pushNamed(context, '/introScreen');
    } on FirebaseAuthException catch (e) {
      print(e);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(e.message!),backgroundColor: Colors.red,
    ),);
    }
  }

  Future addUserDetails() async {
    await FirebaseFirestore.instance.collection('users').add({
      'username': namecontroller.text.trim(),
      'age': int.parse(agecontroller.text.trim()),
      'email': emailcontroller.text.trim(),
      'city': citycontroller.text.trim(),
    });
  }
}
