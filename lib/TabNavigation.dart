import 'package:firstseniorproject/chatbot.dart';
import 'package:firstseniorproject/scan.dart';
import 'package:flutter/cupertino.dart';
import 'package:firstseniorproject/records.dart';
import 'package:flutter/material.dart';
import 'home.dart';
import 'profile.dart';

class TabNavigation extends StatelessWidget {
  @override
  String appBarName = 'SkinScan';

  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        appBar: AppBar(
          title: Text(appBarName),
          backgroundColor: Color.fromARGB(200, 5, 88, 106),
          actions: const [
            Icon(Icons.notifications),
            SizedBox(width: 5.0,),
          ],
        ),
        body: TabBarView(
          children: <Widget>[
            home(),
            Records(),
            CameraWidget(),
            ChatBody(),
            Profile(),
          ],
        ),
        bottomNavigationBar: Material(
          color: Color.fromARGB(200, 5, 88, 106),
          child: TabBar(tabs:<Widget>[
            const Tab(icon: Icon(Icons.home)),
            const Tab(icon: Icon(CupertinoIcons.rectangle_fill_on_rectangle_angled_fill,),),
            Tab(
              child: Container(
                decoration: const  BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.white,
                      spreadRadius: 6,
                    ),
                  ],
                ),
                child: const Center(
                  child: Icon(CupertinoIcons.camera,color: Color.fromARGB(200, 5, 88, 106),size: 28,),
                ),
              ),
            ),
            const Tab(icon: Icon(Icons.chat_rounded),),
            const Tab(icon: Icon(Icons.account_circle_outlined)),
          ]),
        ),
      ),
    );
  }
}
