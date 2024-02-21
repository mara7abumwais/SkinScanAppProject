import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';

class CreatePassword extends StatelessWidget {
  const CreatePassword({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Change Password"),
          leading: BackButton(
            onPressed: (){
                Navigator.pop(context);
            },),
          backgroundColor: Color(0xff519e94),
          ),
        body: CreatePasswordBody(),
      ),
    );
  }
}


class CreatePasswordBody extends StatefulWidget {

  @override
  State<CreatePasswordBody> createState() => _CreatePasswordBodyState();
}

class _CreatePasswordBodyState extends State<CreatePasswordBody> {
  final password = TextEditingController();
  final Confirmapassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 50,
            ),
            const Text(
              "Create New Password",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
            ),
            SizedBox(
              height: 10,
            ),
            const Text(
              "Your password must be different from previous used passwords",
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
            SizedBox(
              height: 20,
            ),
            const Text(
              "New Password",
              style: TextStyle(fontSize: 12),
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
                  borderRadius: const BorderRadius.all(Radius.circular(10))),
              child: TextField(
                controller: password,
                obscureText: true,
                decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Enter New Password',
                    contentPadding: EdgeInsets.all(10)),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            const Text(
              "Confirm Password",
              style: TextStyle(fontSize: 12),
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
                  borderRadius: const BorderRadius.all(Radius.circular(10))),
              child: TextField(
                controller: Confirmapassword,
                obscureText: true,
                decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Enter Confirm Password',
                    contentPadding: EdgeInsets.all(10)),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            MaterialButton(
              color: Color(0xff519e94),
              height: 20,
              minWidth: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 20),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  side: BorderSide(color: Theme.of(context).primaryColor)),
              child: const Text(
                "Reset Password ",
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
              onPressed: () {
                _changePassword();
              },
            ),
            SizedBox(
              height: 8,
            ),
          ],
        ),
      ),
    );
  }

 void _changePassword() async {
  if (password.text != Confirmapassword.text) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Passwords do not match'),
        backgroundColor: Colors.red,
      ),
    );
  } else {
    try {
      User? user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        await user.updatePassword(password.text);

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Password changed successfully'),
            backgroundColor: Color(0xff519e94),
          ),
        );
      }
    } catch (error) {
      print('Error occurred while changing password: $error');
      // Handle the error
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Failed to change password. Please try again.'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}

}


