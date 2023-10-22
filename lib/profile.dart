import 'package:flutter/material.dart';
import 'user_singleton.dart';

class Profile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {


    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('User Profile'),
          backgroundColor: Color.fromARGB(200, 5, 88, 106),
        ),
        body: UserProfileScreen(),
      ),
    );
  }
}

class UserProfileScreen extends StatefulWidget {
  UserProfileScreen();

  @override
  _UserProfileScreenState createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  @override
  Widget build(BuildContext context) {
    
    final user = UserSingleton().user;
    late String username;

    String firstName = user.fname;
    String lastName = user.lname;
    username = firstName + " " + lastName;
    String city = user.city;
    int age = user.age;
    String email = user.email;
    return Stack(
      children: [
        Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/profile2.jpg'),
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
            height: 400,
            decoration: const BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Color.fromARGB(200, 5, 88, 106),
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
                  // backgroundImage: AssetImage(widget.user.imageUrl),
                ),
                SizedBox(height: 20),
                Text(
                  username,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                Text(
                 email,
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(200, 5, 88, 106),
                  ),
                  onPressed: () {
                    setState(() {
                      Navigator.pushNamed(context, '/editProfile');
                    });
                  },
                  child: Text('Edit Profile'),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
