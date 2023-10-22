import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Clinics extends StatefulWidget {
  const Clinics({Key? key}) : super(key: key);

  @override
  _ClinicsState createState() => _ClinicsState();
}

class _ClinicsState extends State<Clinics> {
  List<String> tabList = ['All Cities', 'Jenin', 'Ramallah', 'Nablus', 'Hebron', 'Tulkarem'];
  List<Map<String, dynamic>> tabList1 = [
    {'city': 'All Cities', 'clinics': ['Default Clinic']},
    {'city': 'Jenin', 'clinics': ['Jenin Clinic 1', 'Jenin Clinic 2']},
    {'city': 'Ramallah', 'clinics': ['Ramallah Clinic 1', 'Ramallah Clinic 2']},
    {'city': 'Nablus', 'clinics': ['Nablus Clinic 1', 'Nablus Clinic 2']},
    {'city': 'Hebron', 'clinics': ['Hebron Clinic 1', 'Hebron Clinic 2']},
    {'city': 'Tulkarem', 'clinics': ['Tulkarem Clinic 1', 'Tulkarem Clinic 2']},
  ];
  int selectedTab = 0;
  List<String> clinics = [];
  
    //List<DocumentSnapshot> clinicss = [];


  @override
  void initState() {
    super.initState();
    clinics = tabList1[0]['clinics']!;
        //fetchClinics();

  }
//   Future<void> fetchClinics() async {
//     try {
//       final querySnapshot =
//           await FirebaseFirestore.instance.collection('clinics').get();
//       setState(() {
//         clinicss = querySnapshot.docs;
//       });
//       for (var clinicSnapshot in clinicss) {
// Map<String, dynamic>? clinicData = clinicSnapshot.data() as Map<String, dynamic>?;  
//   String clinicName = clinicData!['clinicName'];
//   String clinicLocation = clinicData['location'];
//   print(clinicLocation);

// }
//     } catch (error) {
//       // Handle error
//       print('Error fetching clinics: $error');
//     }
//   }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Clinics"),
          backgroundColor: Color.fromARGB(200, 5, 88, 106),
          actions: const [
            Icon(Icons.notifications),
            SizedBox(width: 5.0,),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: tabList.asMap().entries.map((entry) {
                    final index = entry.key;
                    final tabText = entry.value;
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedTab = index;
                          if (index == 0) {
                            clinics = tabList1
                                .sublist(1)
                                .expand((city) => city['clinics'] as List<String>)
                                .toList();
                          } else {
                            clinics = tabList1[index]['clinics'] as List<String>;
                          }
                        });
                      },
                      child: Container(
                        margin: const EdgeInsets.only(top: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(32),
                          color: selectedTab == index ? Color.fromARGB(200, 5, 88, 106) : Colors.transparent,
                        ),
                        padding: EdgeInsets.all(8),
                        child: Row(
                          children: [
                            Text(
                              tabText,
                              style: TextStyle(
                                fontSize: 20,
                                color: selectedTab == index ? Colors.white : Color.fromARGB(200, 5, 88, 106),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
              SizedBox(height: 20),
              Container(
                margin: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(100),
                  border: Border.all(color: Color.fromARGB(200, 5, 88, 106)),
                ),
                padding: EdgeInsets.symmetric(horizontal: 8),
                child: const TextField(
                  style: TextStyle(color: Color.fromARGB(200, 5, 88, 106)),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    prefixIcon: Icon(
                      Icons.search_sharp,
                      color: Color.fromARGB(200, 5, 88, 106),
                    ),
                    hintText: 'Search for Products',
                    hintStyle: TextStyle(color: Color.fromARGB(200, 5, 88, 106)),
                  ),
                  // textFieldType: TextFieldType.NAME,
                  cursorColor: Color.fromARGB(200, 5, 88, 106),
                ),
              ),
              SizedBox(height: 20),
              /*Column(
                children: clinics.map((clinic) {
                  return Text(
                    clinic,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.black,
                    ),
                  );
                }).toList(),
              ),*/
              SizedBox(height: 15),
              Container(
                padding:const EdgeInsets.symmetric(vertical: 5),
                margin:const EdgeInsets.symmetric(vertical: 5,horizontal: 10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  gradient: const LinearGradient(
                    colors: [
                      Color.fromARGB(200, 5, 88, 106),
                      Color.fromARGB(220, 20, 99, 100),
                      Color.fromARGB(230, 40, 110, 90),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  boxShadow:const [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 4,
                      spreadRadius: 2,
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
                              color: Colors.white
                          ),
                        ),
                        subtitle: Text("Clinic Name",style: TextStyle(color: Colors.white),),
                        trailing: CircleAvatar(
                          radius: 25,
                          backgroundColor: Colors.white,
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
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.access_time_filled,
                                color: Colors.white70,
                              ),
                              SizedBox(width: 5),
                              Text(
                                "10:30 AM - 3:00 ",
                                style: TextStyle(
                                  color: Colors.white70,
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
                                color: Colors.white70,
                              ),
                              SizedBox(width: 5),
                              Text(
                                "City",
                                style: TextStyle(
                                  color: Colors.white70,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.location_on,
                                color: Colors.white70,
                              ),
                              SizedBox(width: 5),
                              Text(
                                "Location",
                                style: TextStyle(
                                  color: Colors.white70,
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}