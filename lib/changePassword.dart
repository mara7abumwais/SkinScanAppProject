import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
    final emailcontroller=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(body: Padding(padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: SingleChildScrollView(child:Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 30,
          ),
          Text(
            "Reset password",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            "Enter the email associated with your account. We will send you an email with instructions to reset your password.",
            style: TextStyle(fontSize: 12, color: Colors.grey),
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            "Email Address",
            style: TextStyle(fontSize: 15),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.black12,
              ),
              color: Colors.grey[100],
              borderRadius: const BorderRadius.all(Radius.circular(10)),
            ),
            child:  TextFormField(
              controller: emailcontroller,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (email)=>
              email!=null && !EmailValidator.validate(email)?'enter a valid email':null,
              style: TextStyle(color: Colors.black54),
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'someone@example.com',
                hintStyle: TextStyle(color: Colors.black12),
                contentPadding: EdgeInsets.all(10),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          MaterialButton(
            color:  Color.fromARGB(255, 5, 88, 106),
            height: 40,
            minWidth: double.infinity,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: const Text(
              "Reset Password",
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
            onPressed: () {
              resetPassword();
            },
          ),
          SizedBox(
            height: 8,
          ),
        ],

      ) ,),)
    ));
  }
  Future resetPassword() async{
    showDialog(context: context, 
    barrierDismissible: false,
    builder: (context)=>Center(child: CircularProgressIndicator(),));
    try{
   await FirebaseAuth.instance.sendPasswordResetEmail(email: emailcontroller.text.trim());
   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('Password Rest Email Sent' ,style: TextStyle(color: Colors.white, ),),backgroundColor:Color.fromARGB(200, 5, 88, 106),
    ),);
    Navigator.of(context).popUntil((route) => route.settings.name == '/login');
    }on FirebaseAuthException catch(e){
    print(e);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(e.message!),
    ),);
    Navigator.of(context).pop();
  }
  }
}