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
   bool isLogged  = false;
  String imagePath = "";
  late String userId ="";
  late String userName="";

   @override
   void initState() {
     super.initState();
     initializeData();
   }

   Future<void> initializeData() async {
     await getUserData();
     _loadLocalImagePath();
   }

  Future getUserData() async {
    String? uid = FirebaseAuth.instance.currentUser?.uid;
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
        userId = snapshot.docs.first.id;
        userName = userData['firstname'];
        User loggedInUser = User(
          id: snapshot.docs.first.id,
          fname: userData['firstname'],
          lname: userData['lastname'],
          city: userData['city'],
          age: userData['age'],
          email: userData['email'],
        );
        UserSingleton().user = loggedInUser;
        setState(() {
          isLogged = true;
        });
      } else {
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
          body: isLogged?
          Stack(
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
                    SizedBox(height: 5,),
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
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Color.fromRGBO(81, 158, 148, 0.8),
                          ),
                          child:   Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              CircleAvatar(
                                backgroundImage: _buildProfileImage(),
                                radius: 25,
                              ),
                              Text('My Medical Profile', style: TextStyle(color: Colors.white, fontSize: 20),)
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 130,),
                    Center(
                      child: Container(
                        margin: EdgeInsets.all(15),
                        padding: EdgeInsets.all(30),
                        width: 400,
                        height: 400,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(80),
                          color: Colors.white,
                          boxShadow: const [
                            BoxShadow(
                              color:Color(0xff519e94),
                              blurRadius: 4,
                              spreadRadius: 2,
                            ),
                          ],
                            ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                              Text("Welcome back ${userName}! You can start new scan or use Chatbot.",
                              textAlign: TextAlign.center,
                              style: const TextStyle(color: Color(0xff519e94),
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600),),
                            SizedBox(height: 30,),
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
                                  Color(0xff519e94),
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
                                Color(0xff519e94),
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
              :
              const Center(child: CircularProgressIndicator(),)
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
      imagePath = prefs.getString('${userId}_image') ?? "";
    });
  }
}