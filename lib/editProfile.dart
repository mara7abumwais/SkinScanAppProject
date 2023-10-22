


import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'user_singleton.dart';

class EditProfile extends StatefulWidget {
  EditProfile({Key? key}) : super(key: key);

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('Edit Profile'),
          backgroundColor: Color.fromARGB(200, 5, 88, 106),
        ),
        body: EditUserProfileScreen(),
      ),
    );
  }
}

class EditUserProfileScreen extends StatefulWidget {
  // final User? user;

  EditUserProfileScreen({Key? key, }) : super(key: key);

  @override
  _EditUserProfileScreenState createState() => _EditUserProfileScreenState();
}

class _EditUserProfileScreenState extends State<EditUserProfileScreen> {
  final fnamecontroller = TextEditingController();
  final lnamecontroller = TextEditingController();
  final agecontroller = TextEditingController();
  final citycontroller = TextEditingController();
  User? user = UserSingleton().user;

  late String userId ;

  @override
  void initState() {
    super.initState();
    if (user != null) {
  userId = user!.id;
  // String firstName = user!.fname;
  // String lastName = user!.lname;
  // String city = user!.city;
  // int age = user!.age;
  fnamecontroller.text = user!.fname;
      lnamecontroller.text = user!.lname;
      agecontroller.text = user!.age.toString();
     citycontroller.text = user!.city;

  // Use the user data as needed
}
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          CircleAvatar(
            radius: 70,
            // backgroundImage: AssetImage(widget.user.imageUrl),
          ),
          SizedBox(height: 20),
          TextField(
            controller: fnamecontroller,
            decoration: InputDecoration(
              labelText: 'First Name',
            ),
          ),
          TextField(
            controller: lnamecontroller,
            decoration: InputDecoration(
              labelText: 'Last Name',
            ),
          ),
          SizedBox(height: 10),
          TextField(
            controller: agecontroller,
            decoration: InputDecoration(
              labelText: 'Age',
            ),
          ),
          TextField(
            controller: citycontroller,
            decoration: InputDecoration(
              labelText: 'City',
            ),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromARGB(200, 5, 88, 106)),
            onPressed: () {
              updateUserInformation(userId);
              //Navigator.pop(context);
            },
            child: Text('Save Changes'),
          ),
        ],
      ),
    );
  }

  void updateUserInformation(String userId) async {
    try {
      Map<String, dynamic> updatedData = {
        'age': int.parse(agecontroller.text.trim()),
        'city': citycontroller.text.trim(),
        'firstname': fnamecontroller.text.trim(),
        'lastname': lnamecontroller.text.trim(),
      };
      CollectionReference userCollection =
          FirebaseFirestore.instance.collection('users');

      await userCollection.doc(userId).update(updatedData);

      print('User information updated in Firestore.');
    } catch (e) {
      print('Error updating user information: $e');
    }
  }
}
