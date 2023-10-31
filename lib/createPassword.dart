import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';

class CreatePassword extends StatefulWidget {
  const CreatePassword({super.key});

  @override
  State<CreatePassword> createState() => _CreatePasswordState();
}

class _CreatePasswordState extends State<CreatePassword> {
  final password = TextEditingController();
  final Confirmapassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: Padding(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 30,
            ),
            const Text(
              "Create New Password",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
            ),
            SizedBox(
              height: 10,
            ),
            const Text(
              "Your password must be diffrent from previous used passwords",
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
            SizedBox(
              height: 20,
            ),
            const Text(
              "Password",
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
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Enter Password',
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
                controller: password,
                obscureText: true,
                decoration: InputDecoration(
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
                _changePassword;
              },
            ),
            SizedBox(
              height: 8,
            ),
          ],
        ),
      ),
    )));
  }

  void _changePassword(String newPassword) async {
    if (password != Confirmapassword) {
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
          await user.updatePassword(newPassword);
          Navigator.of(context)
              .popUntil((route) => route.settings.name == '/login');
        }
      } catch (error) {
        print('Error occurred while changing password: $error');
        // Handle the error
      }
    }
  }
}
