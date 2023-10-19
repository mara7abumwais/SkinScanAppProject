import 'package:flutter/material.dart';



class home extends StatefulWidget {
  const home({super.key});

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                height: 230,
                child: Stack(
                  children: <Widget>[
                    Positioned(
                      top: -100,
                      height: 400,
                      width: width,
                      child: Container(
                        decoration:const  BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage('background.png'),
                                fit: BoxFit.contain)),
                      ),
                    ),
                  ],
                ),
              ),
              Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ElevatedButton.icon(
                      onPressed: () {
                        Navigator.pushNamed(context, '/scan');
                      },
                      icon: Icon(Icons.camera_alt),
                      label: Text('Scan New Spot'),
                      style: ElevatedButton.styleFrom(
                        primary: Color.fromARGB(200, 5, 88, 106),
                        minimumSize: Size(200, 60),
                      ),
                    ),
                    SizedBox(height: 20),
                    ElevatedButton.icon(
                      onPressed: () {
                        setState(() {
                          Navigator.pushNamed(context, '/Chatbot');
                        });
                      },
                      icon: Icon(Icons.chat),
                      label: Text('Use Chatbot'),
                      style: ElevatedButton.styleFrom(
                        primary: Color.fromARGB(200, 5, 88, 106),
                        minimumSize: Size(200, 60),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
