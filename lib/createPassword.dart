import 'package:flutter/material.dart';


class CreatePassword extends StatefulWidget {
  const CreatePassword({super.key});

  @override
  State<CreatePassword> createState() => _CreatePasswordState();
}

class _CreatePasswordState extends State<CreatePassword> {
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
            "Create New Password",
            style:
            TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            "Your password must be diffrent from previous used passwords",
            style: TextStyle(fontSize: 12, color: Colors.grey),
          ),
          SizedBox(
            height: 20,
          ),
          Text(
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
                borderRadius:
                const BorderRadius.all(Radius.circular(10))),
            child: const TextField(
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
          Text(
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
                borderRadius:
                const BorderRadius.all(Radius.circular(10))),
            child: const TextField(
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
            color:Color.fromARGB(255, 5, 88, 106),
            height: 20,
            minWidth: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 20),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
                side: BorderSide(color: Theme.of(context).primaryColor)),
            child: Text(
              "Reset Password ",
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
            onPressed: () {
              Navigator.pushNamed(context, '/tabNavigation');
            },
          ),
          SizedBox(
            height: 8,
          ),
        ],

      ) ,),)
    ));
  }
}

