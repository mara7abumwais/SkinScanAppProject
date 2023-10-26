import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Scan {
  final String image;
  final String dermatosis;
  final double percentage;
  final DateTime date;
  final String treatment;

  Scan({
    required this.image,
    required this.dermatosis,
    required this.percentage,
    required this.date,
    required this.treatment,
  });
}

class Records extends StatefulWidget {
  const Records({super.key});

  @override
  State<Records> createState() => _RecordsState();
}

class _RecordsState extends State<Records> {
  List<Scan> scans = [];
  List<Scan> scan2 = [];
  bool searchNew = true;
  int selectedOption = 0;
  TextEditingController searchController = TextEditingController();
  List<String> tabList = ['All', 'Low Risk', 'Medium', 'High'];

  @override
  void initState() {
    super.initState();
    // Initialize with some sample data
    scans.add(Scan(
      image: 'assets/introScreen1.jpg',
      dermatosis: 'Dermatosis 1',
      percentage: 60.0,
      date: DateTime(2023, 8, 15),
      treatment: 'Treatment for Dermatosis 1',
    ));
    scans.add(Scan(
      image: 'assets/introScreen2.jpg',
      dermatosis: 'Dermatosis 2',
      percentage: 92.5,
      date: DateTime(2023, 8, 16),
      treatment: 'Treatment for Dermatosis 2',
    ));
    scans.add(Scan(
      image: 'assets/introScreen3.jpg',
      dermatosis: 'Dermatosis 3',
      percentage: 40,
      date: DateTime(2023, 8, 14),
      treatment: 'Treatment for Dermatosis 3',
    ));

    scan2 = scans;
  }

  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Stack(children: [
          Container(
            decoration: const BoxDecoration(
              color: Colors.white60,
              image: DecorationImage(
                image: AssetImage('assets/record.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(height: 80),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
                          selectedOption = index;
                          if(selectedOption == 0 )
                          {
                            scan2 = scans;
                          }
                          else if(selectedOption == 1)
                          {
                            scan2 = scans.where((scan) => scan.percentage < 50).toList();
                          }
                          else if(selectedOption == 2)
                          {
                            scan2 = scans.where((scan) => (scan.percentage < 70 && scan.percentage >= 50) ).toList();
                          }
                          else
                          {
                            scan2 = scans.where((scan) => scan.percentage >= 70).toList();
                          }
                        });
                      },
                      child: Container(
                        margin: const EdgeInsets.only(top: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(32),
                          color: selectedOption == index ? Color(0xff519e94) : Colors.transparent,
                        ),
                        padding: EdgeInsets.all(8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              tabText,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: selectedOption == index ? Colors.white : Color(0xff519e94),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
              SizedBox(height: 20,),
              Container(
                margin: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Color(0xff519e94),
                  borderRadius: BorderRadius.circular(100),
                  border: Border.all(color: Colors.white),
                ),
                padding: EdgeInsets.symmetric(horizontal: 8),
                child: TextField(
                  controller: searchController, // Use the controller
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    prefixIcon: Icon(
                      Icons.search_sharp,
                      color: Colors.white,
                    ),
                    hintText: 'Search for Record',
                    hintStyle: TextStyle(color: Colors.white),
                  ),
                  onChanged: (value) {
                    setState(() {
                      scan2 = scans.where((scan) {
                        return scan.dermatosis.toLowerCase().contains(value.toLowerCase());
                      }).toList();
                    });
                  },
                  cursorColor: Colors.white,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    searchNew? Text('New to Old'):Text('Old to New'),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          searchNew = !searchNew;
                          scan2.sort((a, b) {
                            if (searchNew) {
                              return b.date.compareTo(a.date); // Sort from new to old
                            } else {
                              return a.date.compareTo(b.date); // Sort from old to new
                            }
                          });
                        });
                      },
                      hoverColor: Colors.transparent,
                      icon: searchNew? Icon(Icons.arrow_downward):Icon(Icons.arrow_upward),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: scan2.length,
                  itemBuilder: (context, index) {
                    final scan = scan2[index];
                    final formattedDate = DateFormat('yyyy-MM-dd').format(scan.date);
                    return Container(
                      padding:const EdgeInsets.symmetric(vertical: 5),
                      margin:const EdgeInsets.symmetric(vertical: 13,horizontal: 10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow:const [
                          BoxShadow(
                            color: Color(0xff519e94),
                            blurRadius: 3,
                            spreadRadius: 4,
                          ),
                        ],
                      ),
                      child: ListTile(
                        leading: Image.asset(
                          scan.image,
                          width: 50,
                          height: 50,                          fit: BoxFit.cover,
                        ),
                        title: Text(scan.dermatosis),
                        subtitle: Text('Percentage: ${scan.percentage.toStringAsFixed(2)}%'),
                        trailing: Text('Date: $formattedDate'),
                       //ما عرضت التريتمنت
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ],
        )
      ),
    );
  }
}




