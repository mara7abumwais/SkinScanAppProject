import 'dart:io';
import 'package:firstseniorproject/TabNavigation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart' hide User;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'user_singleton.dart';

class home extends StatefulWidget {
  const home({super.key});

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {

  //late String imagePath;
  //late String userId;

  @override
  void initState() {
    super.initState();
    getUserData();
//    _loadLocalImagePath();
  }

  Future getUserData() async {
    String? uid = FirebaseAuth.instance.currentUser?.uid;
  //  userId = uid!;
    try {
      QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
          .instance
          .collection('users')
          .where('id', isEqualTo: uid)
          .limit(1)
          .get();

      if (snapshot.docs.isNotEmpty) {
        // User document exists
        Map<String, dynamic> userData = snapshot.docs.first.data();
        print(userData);
        User loggedInUser = User(
          id: snapshot.docs.first.id,
          fname: userData['firstname'],
          lname: userData['lastname'],
          city: userData['city'],
          age: userData['age'],
          email: userData['email'],
        );
        UserSingleton().user = loggedInUser;
      } else {
        // User document does not exist
        print('User not found');
      }
    } catch (e) {
      print('Error retrieving user data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          backgroundColor: Colors.white,
          body: Stack(
            children: [
              Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/home.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      height: 20,
                    ),
                    Center(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            Navigator.pushNamed(context, '/profile');
                          });
                        },
                        child: Container(
                          width: 300,
                          height: 80,
                          margin: EdgeInsets.fromLTRB(30, 20, 30, 20),
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Color.fromARGB(200, 5, 88, 106),
                          ),
                          child: const  Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              CircleAvatar(
                                backgroundImage: AssetImage('assets/testUser.jpg'),
                                radius: 25,
                              ),
                               Text('My Medical Profile', style: TextStyle(color: Colors.white, fontSize: 20),)
                            ],
                          ),
                        ),
                      ),
                    ),
                    Center(
                      child: Container(
                        margin: EdgeInsets.all(15),
                        padding: EdgeInsets.all(30),
                        width: 300,
                        height: 400,
                        decoration: const BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Color.fromARGB(200, 5, 88, 106),
                                blurRadius: 30,
                                offset: Offset(0, 10),
                              )
                            ]),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton.icon(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => TabNavigation(2),
                                  ),
                                );
                              },
                              icon: Icon(Icons.camera_alt),
                              label: Text('Scan New Spot'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                Color.fromARGB(200, 5, 88, 106),
                                minimumSize: Size(200, 60),
                              ),
                            ),
                            SizedBox(height: 20),
                            ElevatedButton.icon(
                              onPressed: () {
                                setState(() {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => TabNavigation(3),
                                    ),
                                  );
                                });
                              },
                              icon: Icon(Icons.chat),
                              label: Text('Use Chatbot'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                Color.fromARGB(200, 5, 88, 106),
                                minimumSize: Size(200, 60),
                              ),
                            ),
                            SizedBox(height: 20,),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          )
      ),
    );
  }
  /*ImageProvider<Object> _buildProfileImage() {
    if (imagePath != null) {
      return FileImage(File(imagePath!)); // Load image from file
    } else {
      return AssetImage("assets/testUser.jpg"); // Load a default image from assets
    }
  }
  void _loadLocalImagePath() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      imagePath = prefs.getString('${userId}_image')!;
    });
  }*/
}
