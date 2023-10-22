import 'dart:io';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'user_singleton.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

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

  const EditUserProfileScreen({Key? key, }) : super(key: key);

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
  String imagePath = "";
  bool hadChanged = false;
  bool isHovering = false;
  @override
  void initState() {
    super.initState();
    if (user != null) {
      userId = user!.id;
       fnamecontroller.text = user!.fname;
       lnamecontroller.text = user!.lname;
       agecontroller.text = user!.age.toString();
       citycontroller.text = user!.city[0].toUpperCase() + user!.city.substring(1);
       _loadLocalImagePath();
    }}

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Center(
            child: Container(
              width: 150,
              height: 150,
              decoration: const BoxDecoration(
                shape: BoxShape.circle
              ),
              child: Stack(
                children: [
                     !isHovering?
                     CircleAvatar(
                       radius: 70,
                       backgroundImage: _buildProfileImage(),)
                     :const CircleAvatar(
                          radius: 70,
                          backgroundColor: Colors.black26,
                     child: Center(
                       child: Icon(Icons.photo_outlined,color: Color.fromARGB(200, 5, 88, 106),),
                     ),),
                  InkWell(
                    hoverColor: Colors.transparent,
                    onTap: ()
                    {
                      setState(() {
                        _changeProfilePhoto();
                        print('marah');
                      });
                    },
                    onHover: (event)
                    {
                      setState(() {
                        isHovering = event;
                      });
                    },),
                ],
              ),
            )
          ),
          SizedBox(height: 20),
          TextField(
            controller: fnamecontroller,
            decoration: const InputDecoration(
              labelText: 'First Name',
            ),
          ),
          TextField(
            controller: lnamecontroller,
            decoration: const InputDecoration(
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

  void _changeProfilePhoto() async {
    try{
      final picker = ImagePicker();
      final XFile? xFile = await picker.pickImage(source: ImageSource.gallery);

      if (xFile != null) {
        final File imageFile = File(xFile.path);
        setState(() {
          imagePath = imageFile.path;
        });
        hadChanged = true;
      }
      else {
        setState(() {
          imagePath = "";
        });
      }
    }catch(error)
    {
      print(error);
      setState(() {
        imagePath = "";
      });
    }
  }

  ImageProvider<Object> _buildProfileImage() {
    if (imagePath != "") {
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
  }

  void _saveLocalImagePath(String path) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('${userId}_image', path);
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
       ScaffoldMessenger.of(context).showSnackBar(
         const SnackBar(content: Text("Changes Saved"))
       );
      if (imagePath != null && hadChanged == true) {
        _loadLocalImagePath();
        _saveLocalImagePath(imagePath!);
      }
       print('User information updated in Firestore.');
    } catch (e) {
       print('Error updating user information: $e');
    }
  }
}
