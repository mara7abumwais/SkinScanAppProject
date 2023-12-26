import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Clinics extends StatefulWidget {
  const Clinics({Key? key}) : super(key: key);

  @override
  _ClinicsState createState() => _ClinicsState();
}

class _ClinicsState extends State<Clinics> {
  int selectedTab = 0;
  List<String> tabList = ['All Cities', 'Jenin', 'Ramallah', 'Nablus', 'Hebron', 'Tulkarm',
    'Bethlehem','Tubas','Jerusalem','Jericho','Qalqilya','Gaza','Khan Yunis','Salfit'];
  List<DocumentSnapshot>? clinicss;
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchClinics();
  }

  Future<void> fetchClinics() async {
    try {
      final querySnapshot = await FirebaseFirestore.instance.collection('clinics').get();
      setState(() {
        clinicss = querySnapshot.docs;
      });
    } catch (error) {
      print('Error fetching clinics: $error');
    }
  }

  List<DocumentSnapshot> getFilteredClinics(String selectedCity) {
    if (selectedCity == 'All Cities') {
      return clinicss!;
    } else {
      return clinicss!.where((clinic) =>
      clinic['city'].toString().toLowerCase() == selectedCity.toLowerCase()
      ).toList();
    }
  }

  List<DocumentSnapshot> getFilteredClinicsBySearch(String searchQuery) {
    if (searchQuery.isEmpty) {
      return clinicss!;
    } else {
      return clinicss!.where((clinic) {
        final clinicName = clinic['clinicName']?.toString() ?? '';
        final doctorName = clinic['doctorName']?.toString() ?? '';
        final lowerCaseQuery = searchQuery.toLowerCase();
        return clinicName.toLowerCase().contains(lowerCaseQuery) || doctorName.toLowerCase().contains(lowerCaseQuery);
      }).toList();
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Clinics"),
          leading: BackButton(
            onPressed: (){
              setState(() {
                Navigator.pop(context);
              });
            },
          ),
          backgroundColor: Color(0xff519e94),
          actions: const [
            Icon(Icons.notifications),
            SizedBox(width: 5.0),
          ],
        ),
        body: clinicss != null
            ? SingleChildScrollView(
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
                          searchController.clear(); // Clear the search bar when changing tabs.
                        });
                      },
                      child: Container(
                        margin: const EdgeInsets.only(top: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(32),
                          color: selectedTab == index ? Color(0xff519e94) : Colors.transparent,
                        ),
                        padding: EdgeInsets.all(8),
                        child: Row(
                          children: [
                            Text(
                              tabText,
                              style: TextStyle(
                                fontSize: 20,
                                color: selectedTab == index ? Colors.white : Color(0xff519e94),
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
                  color: Color(0xff519e94),
                  borderRadius: BorderRadius.circular(100),
                  border: Border.all(color: Colors.white)),
                padding: EdgeInsets.symmetric(horizontal: 8),
                child: TextField(
                  controller: searchController,
                  onChanged: (query) {
                    setState(() {
                    });
                  },
                  style: TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    prefixIcon: Icon(
                      Icons.search_sharp,
                      color: Colors.white,
                    ),
                    hintText: 'Search for Clinics',
                    hintStyle: TextStyle(color: Colors.white),
                  ),
                  cursorColor: Colors.white,
                ),
              ),
              SizedBox(height: 20),
              clinicss!.isNotEmpty
                  ? ListView.builder(
                shrinkWrap: true,
                physics: ClampingScrollPhysics(),
                itemCount: searchController.text.isEmpty
                    ? getFilteredClinics(tabList[selectedTab]).length
                    : getFilteredClinicsBySearch(searchController.text).length,
                itemBuilder: (context, index) {
                  final clinic = searchController.text.isEmpty
                      ? getFilteredClinics(tabList[selectedTab])[index].data() as Map<String, dynamic>
                      : getFilteredClinicsBySearch(searchController.text)[index].data() as Map<String, dynamic>;
                  final clinicName = clinic['clinicName'] ?? 'Default Clinic';
                  final doctorName = clinic['doctorName'] ?? 'Dr. Doctor Name';
                  final city = clinic['city'] ?? 'City';
                  final location = clinic['location'] ?? 'Location';
                  final openingHours = clinic['openingHours'] ?? 'Opening Hours: N/A';

                  return Container(
                    margin: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      gradient: const LinearGradient(
                        colors: [
                          Color(0xff519e94),
                          Color.fromARGB(220, 20, 99, 100),
                          Color.fromARGB(230, 40, 110, 90),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 4,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        ListTile(
                          title: Text(
                            doctorName,
                            style: const TextStyle( color: Colors.black,),
                          ),
                          subtitle: Text(clinicName, style: TextStyle(color: Colors.black54)),
                          trailing: const CircleAvatar(radius: 25, backgroundImage: AssetImage('assets/dermatology.jpg'),),
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 15),
                          child: Divider(
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
                                  openingHours,
                                  style: const TextStyle(color: Colors.white,),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                const Icon(Icons.access_time_filled, color: Colors.white70,),
                                SizedBox(width: 5),
                                Text(
                                  openingHours,
                                  style: const TextStyle(color: Colors.white70,),
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
                                const Icon(Icons.location_city, color: Colors.white70,),
                                SizedBox(width: 5),
                                Text(
                                  city,
                                  style: const TextStyle(color: Colors.white70,),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                const Icon(Icons.location_on, color: Colors.white70,),
                                SizedBox(width: 5),
                                Text(
                                  location,
                                  style: TextStyle(color: Colors.white70,),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                      ],
                    ),
                  );
                },
              )
                  : const Center(child: Text('No clinics found.')),
            ],
          ),
        )
            : const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
