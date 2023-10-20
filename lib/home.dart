import 'package:firstseniorproject/TabNavigation.dart';
import 'package:flutter/material.dart';



class home extends StatefulWidget {
  const home({super.key});

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              /* Container(
                height: 230,
                child: Stack(
                  children: <Widget>[
                    Positioned(
                      top: -110,
                      height: 400,
                      width: width,
                      child: Container(
                        decoration:const  BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage('assets/background.png'),
                                fit: BoxFit.contain)),
                      ),
                    ),
                  ],
                ),
              ),*/
              Center(
                child: GestureDetector(
                  onTap: ()
                  {
                    setState(() {
                      Navigator.pushNamed(context, '/profile');
                    });
                  },
                  child: Container(
                    width: 300,
                    height: 80,
                    margin: EdgeInsets.fromLTRB(30, 20, 30, 20),
                    padding:EdgeInsets.all(10) ,
                    color: Color.fromARGB(200, 5, 88, 106),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        CircleAvatar(
                          backgroundImage: AssetImage('assets/introScreen1.jpg'),
                          radius: 25,
                        ),
                        Text('My Medical Profile',style: TextStyle(color: Colors.white,fontSize: 20),)
                      ],
                    ),
                  ),
                ),
              ),
              //هون بنفحص اذا ما في ريكورد ما بنعرض هاي القائمة كلها
              //بنعرض العيادات
              Row(
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
              ),
              /*Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Clinics:',style: TextStyle(color: Color.fromARGB(200, 5, 88, 106) ,fontSize: 14),),
                  GestureDetector(
                      onTap: ()
                      {
                        setState(() {
                          Navigator.pushNamed(context, '/clinics');
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
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child:const Column(
                    children: [
                      ListTile(
                        title: Text(
                          "Dr. Doctor Name",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(200, 5, 88, 106)
                          ),
                        ),
                        subtitle: Text("Clinic Name",style: TextStyle(color: Colors.white),),
                        trailing: CircleAvatar(
                          radius: 25,
                          backgroundColor: Color.fromARGB(200, 5, 88, 106),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15),
                        child: Divider(
                          // color: Colors.black,
                          thickness: 1,
                          height: 20,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Row(
                            children: [
                              Text(
                                "Opening Hours:",
                                style: TextStyle(
                                  color: Color.fromARGB(200, 5, 88, 106),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.access_time_filled,
                                color: Color.fromARGB(200, 5, 88, 106),
                              ),
                              SizedBox(width: 5),
                              Text(
                                "10:30 AM - 3:00 ",
                                style: TextStyle(
                                  color:Color.fromARGB(200, 5, 88, 106),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.location_city,
                                color: Color.fromARGB(200, 5, 88, 106),
                              ),
                              SizedBox(width: 5),
                              Text(
                                "City",
                                style: TextStyle(
                                  color: Color.fromARGB(200, 5, 88, 106),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.location_on,
                                color: Color.fromARGB(200, 5, 88, 106),
                              ),
                              SizedBox(width: 5),
                              Text(
                                "Location",
                                style: TextStyle(
                                  color: Color.fromARGB(200, 5, 88, 106),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                    ],
                  ),
                ),
              ),*/
              Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
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
                        backgroundColor: Color.fromARGB(200, 5, 88, 106),
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
                        backgroundColor: Color.fromARGB(200, 5, 88, 106),
                        minimumSize: Size(200, 60),
                      ),
                    ),
                    SizedBox(height: 20,)
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
