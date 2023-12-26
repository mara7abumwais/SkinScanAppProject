import 'dart:io';
import 'package:firstseniorproject/contactUs.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:babstrap_settings_screen/babstrap_settings_screen.dart';
import 'package:firebase_auth/firebase_auth.dart' as FirebaseAuth;
import 'package:shared_preferences/shared_preferences.dart';
import 'user_singleton.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  String username = '';
  final user = UserSingleton().user;

  late String imagePath = "";
  late String userId;

  @override
  void initState() {
    super.initState();
    String firstName = user.fname;
    String lastName = user.lname;
    userId = user.id;
    username = firstName + " " + lastName;
    _loadLocalImagePath();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white.withOpacity(.94),
        body: Padding(
          padding: const EdgeInsets.all(10),
          child: ListView(
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    fit: BoxFit.contain, // Center crop the image
                    image: _buildProfileImage(),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Center(
                  child: Text(
                    username,
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: const Center(
                  child: Text(
                    'Settings',
                    style: TextStyle(color: Colors.black, fontSize: 18),
                  ),
                ),
              ),
              SettingsGroup(
                items: [
                  SettingsItem(
                    onTap: () {
                      setState(() {
                        Navigator.pushNamed(context, '/editProfile');
                      });
                    },
                    icons: CupertinoIcons.person_crop_circle_fill,
                    iconStyle: IconStyle(
                      iconsColor: Colors.white,
                      withBackground: true,
                      backgroundColor: Color(0xff519e94),
                    ),
                    title: 'Edit your profile',
                  ),
                  SettingsItem(
                    onTap: () {
                      setState(() {
                        Navigator.pushNamed(context, '/clinics');
                      });
                    },
                    icons:
                        //CupertinoIcons.rectangle_fill_on_rectangle_angled_fill,
                        Icons.health_and_safety_outlined,
                    iconStyle: IconStyle(
                      iconsColor: Colors.white,
                      withBackground: true,
                      backgroundColor: Color(0xff519e94),
                    ),
                    title: 'Clinics',
                  ),
                  SettingsItem(
                    onTap: () {
                      setState(() {
                        Navigator.pushNamed(context, '/createPassword');
                      });
                    },
                    icons: Icons.admin_panel_settings_sharp,
                    iconStyle: IconStyle(
                      iconsColor: Colors.white,
                      withBackground: true,
                      backgroundColor: Color(0xff519e94),
                    ),
                    title: 'Change Password',
                  ),
                  SettingsItem(
                   onTap: () {
                    },
                    icons: Icons.dark_mode_rounded,
                    iconStyle: IconStyle(
                      iconsColor: Colors.white,
                      withBackground: true,
                      backgroundColor: Color(0xff519e94),
                    ),
                    title: 'Dark mode',
                    subtitle: "Automatic",
                    subtitleStyle: TextStyle(fontSize: 12),
                    trailing: Switch.adaptive(
                      value: false,
                      onChanged: (value) {},
                    ),
                  ),
                  SettingsItem(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => ContactUsPage()
                          ));
                    },
                    icons: Icons.contact_phone_rounded,
                    iconStyle: IconStyle(
                      iconsColor: Colors.white,
                      withBackground: true,
                      backgroundColor: Color(0xff519e94),
                    ),
                    title: 'Contact us',
                    subtitle: "Contact with the technical support team",
                    subtitleStyle: TextStyle(fontSize: 12),
                  ),
                  SettingsItem(
                    onTap: () {
                      setState(() {
                        Navigator.pushNamed(context, '/privacyAndSecurity');
                      });
                    },
                    icons: Icons.privacy_tip,
                    iconStyle: IconStyle(
                      iconsColor: Colors.white,
                      withBackground: true,
                      backgroundColor: Color(0xff519e94),
                    ),
                    title: 'Privacy and Security',
                    subtitle: "Read our privacy and security information",
                    subtitleStyle: TextStyle(fontSize: 12),
                  ),
                  SettingsItem(
                    onTap: () {
                      Navigator.pushNamed(context, '/aboutUs');
                    },
                    icons: Icons.account_box_outlined,
                    iconStyle: IconStyle(
                      backgroundColor: Color(0xff519e94),
                    ),
                    title: 'About',
                    subtitle: "Learn more about SkinScan",
                    subtitleStyle: TextStyle(fontSize: 12),
                  ),
                ],
              ),

              // You can add a settings title
              SettingsGroup(
                settingsGroupTitle: "Account",
                items: [
                  SettingsItem(
                    onTap: () {
                      setState(() {
                        FirebaseAuth.FirebaseAuth.instance.signOut();
                        Navigator.pushNamed(context, '/login');
                      });
                    },
                    icons: Icons.exit_to_app_rounded,
                    title: "Sign Out",
                  ),
                  SettingsItem(
                   onTap: ()
                    {
                      setState(() {
                        _deleteAccount();
                      });
                    },
                    icons: CupertinoIcons.delete_solid,
                    title: "Delete account",
                    titleStyle: const TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
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
      imagePath = prefs.getString('${userId}_image') ?? "";
    });
  }

  void _deleteAccount() async {
    try {
      FirebaseAuth.User? user = FirebaseAuth.FirebaseAuth.instance.currentUser;
      if (user != null) {
         await FirebaseFirestore.instance.collection('users').doc(userId).delete();
        await user.delete();
        Navigator.pushNamed(context, '/login');
      }
    } catch (error) {
      print('Error occurred while deleting account: $error');
    }
  }

}
