import 'dart:io';
import 'package:firstseniorproject/editProfile.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'user_singleton.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final user = UserSingleton().user;

  late String username;
  late String userId;
  late String firstName;
  late String lastName;
  late String city;
  late int age;
  late String email ;
  late String imagePath = "";

  @override
  void initState() {
    super.initState();
    if (user != null) {
      userId = user.id;
      firstName = user.fname;
      lastName= user.lname;
      age = user.age;
      city = user.city[0].toUpperCase() + user.city.substring(1);
      email = user.email;
      username = firstName + " " + lastName;
      _loadLocalImagePath();
    }}

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('User Profile'),
          backgroundColor: Color(0xff519e94),
          leading: BackButton(
            onPressed: (){
              setState(() {
                Navigator.pop(context);
              });
            },
          ),
        ),
        body: Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/profile.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: 80),
            Center(
              child: Container(
                margin: EdgeInsets.all(15),
                padding: EdgeInsets.all(30),
                width: 300,
                height: 450,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Color(0xff519e94),
                      blurRadius: 30,
                      offset: Offset(0, 10),
                    )
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(height: 20),
                    CircleAvatar(
                      radius: 70,
                      backgroundImage: _buildProfileImage(),
                    ),
                    SizedBox(height: 20),
                    Text(
                      username,
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),
                    Text(
                      email,
                      style: TextStyle(fontSize: 16, color: Colors.black54,fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "Age: "+ age.toString(),
                      style: TextStyle(fontSize: 16, color: Colors.black54,fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "City: "+ city,
                      style: TextStyle(fontSize: 16, color: Colors.black54,fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xff519e94),
                        textStyle: TextStyle(fontSize: 20),
                        padding: EdgeInsets.all(15)
                      ),
                      onPressed: () {
                        setState(() {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => EditProfile()
                              ));
                        });
                      },
                      child: Text('Edit Profile'),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  ImageProvider<Object> _buildProfileImage() {
    if (imagePath != "") {
      return FileImage(File(imagePath)); // Load image from file
    } else {
      return AssetImage("assets/testUser.jpg"); // Load a default image from assets
    }
  }
  void _loadLocalImagePath() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      imagePath = prefs.getString('${userId}_image')!;
    });
  }

}

