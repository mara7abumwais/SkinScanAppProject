import 'package:flutter/material.dart';

class User {
  String name;
  String email;
  String imageUrl;

  User({
    required this.name,
    required this.email,
    required this.imageUrl,
  });
}

class EditProfile extends StatelessWidget {
  final User user = User(
    name: 'John Doe',
    email: 'johndoe@example.com',
    imageUrl: 'assets/introScreen1.jpg',
  );

  EditProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('Edit Profile'),
        ),
        body: EditUserProfileScreen(user: user),
      ),
    );
  }
}

class EditUserProfileScreen extends StatefulWidget {
  final User user;

  EditUserProfileScreen({required this.user});

  @override
  _EditUserProfileScreenState createState() => _EditUserProfileScreenState();
}

class _EditUserProfileScreenState extends State<EditUserProfileScreen> {
  late TextEditingController nameController;
  late TextEditingController emailController;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.user.name);
    emailController = TextEditingController(text: widget.user.email);
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    super.dispose();
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
            backgroundImage: AssetImage(widget.user.imageUrl),
          ),
          SizedBox(height: 20),
          TextField(
            controller: nameController,
            decoration: InputDecoration(
              labelText: 'Name',
            ),
          ),
          SizedBox(height: 10),
          TextField(
            controller: emailController,
            decoration: InputDecoration(
              labelText: 'Email',
            ),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              // Save the updated user profile
              widget.user.name = nameController.text;
              widget.user.email = emailController.text;
              // Implement the logic to save this data to your storage or API
              // You can also navigate back to the user profile screen.
              Navigator.pop(context);
            },
            child: Text('Save Changes'),
          ),
        ],
      ),
    );
  }
}
