import 'package:flutter/material.dart';

class User {
  String name;
  String age;
  String imageUrl;

  User({
    required this.name,
    required this.age,
    required this.imageUrl,
  });
}

class EditProfile extends StatelessWidget {
  final User user = User(
    name: 'John Doe',
    age: 'johndoe@example.com',
    imageUrl: 'assets/testUser.jpg',
  );

  EditProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('Edit Profile'),
          backgroundColor: Color.fromARGB(200, 5, 88, 106),
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
  late TextEditingController ageController;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.user.name);
    ageController = TextEditingController(text: widget.user.age);
  }

  @override
  void dispose() {
    nameController.dispose();
    ageController.dispose();
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
            controller: ageController,
            decoration: InputDecoration(
              labelText: 'age',
            ),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Color.fromARGB(200, 5, 88, 106)),
            onPressed: () {
              widget.user.name = nameController.text;
              widget.user.age = ageController.text;
              //Navigator.pop(context);
            },
            child: Text('Save Changes'),
          ),
        ],
      ),
    );
  }
}
