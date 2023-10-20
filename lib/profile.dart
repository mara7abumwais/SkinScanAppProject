import 'package:flutter/material.dart';

class User {
  final String name;
  final String email;
  final String imageUrl;

  User({
    required this.name,
    required this.email,
    required this.imageUrl,
  });
}

class Profile extends StatelessWidget {
  final User user = User(
    name: 'John Doe',
    email: 'johndoe@example.com',
    imageUrl: 'assets/introScreen1.jpg', // You should place your image in the assets folder
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('User Profile'),
        ),
        body: UserProfileScreen(user: user),
      ),
    );
  }
}

class UserProfileScreen extends StatelessWidget {
  final User user;

  UserProfileScreen({required this.user});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        SizedBox(height: 20),
        CircleAvatar(
          radius: 70,
          backgroundImage: AssetImage(user.imageUrl),
        ),
        SizedBox(height: 20),
        Text(
          user.name,
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        Text(
          user.email,
          style: TextStyle(fontSize: 16, color: Colors.grey),
        ),
        SizedBox(height: 20),
        ElevatedButton(
          onPressed: () {
            Navigator.pushNamed(context, '/editProfile');
          },
          child: Text('Edit Profile'),
        ),
      ],
    );
  }
}
