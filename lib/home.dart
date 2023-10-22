import 'package:firstseniorproject/TabNavigation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart' hide User;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'user_singleton.dart';

class home extends StatefulWidget {
  const home({super.key});

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
  @override
  void initState() {
    super.initState();
    // Call getUserData when the page is opened
    getUserData();
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
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              CircleAvatar(
                                backgroundImage:
                                    AssetImage('assets/testUser.jpg'),
                                radius: 25,
                              ),
                              Text(
                                'My Medical Profile',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20),
                              )
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
                            SizedBox(
                              height: 20,
                            ),
                          ],
                        ),
                      ),
                      //هون بنفحص اذا ما في ريكورد ما بنعرض هاي القائمة كلها
                      //بنعرض العيادات
                      /*Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Last Record:',style: TextStyle(color: Color.fromARGB(200, 5, 88, 106) ,fontSize: 14),),
                            GestureDetector(
                                onTap: ()
                                {
                                  setState(() {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => TabNavigation(1),
                                      ),
                                    );
                                  });
                                },
                                child: Container(
                                  margin: EdgeInsets.only(top: 10,bottom: 15),
                                  child: const Row(
                                    children: [
                                      Text('See all',style: TextStyle(color: Color.fromARGB(200, 5, 88, 106),fontSize: 12 )),
                                      Icon(Icons.arrow_forward, color:Color.fromARGB(200, 5, 88, 106),size: 10, ),
                                    ],
                                  ),
                                )
                            )
                          ],
                        ),
                        Container(
                          padding:const EdgeInsets.symmetric(vertical: 5),
                          margin:const EdgeInsets.symmetric(vertical: 13,horizontal: 10),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow:const [
                              BoxShadow(
                                color: Color.fromARGB(200, 5, 88, 106),
                                blurRadius: 3,
                                spreadRadius: 4,
                              ),
                            ],
                          ),
                          child: ListTile(
                            leading: Image.asset(
                              'assets/introScreen1.jpg',
                              width: 50,
                              height: 50,
                              fit: BoxFit.cover,
                            ),
                            title: Text('Dermatosis 1'),
                            subtitle: Text('Percentage: 60%'),
                            trailing: Text('Date: 2023-8-16'),
                          ),
                        ),*/
                    ),
                  ],
                ),
              ),
            ],
          )),
    );
  }
}
