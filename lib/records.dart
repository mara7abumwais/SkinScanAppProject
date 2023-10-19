import 'package:flutter/material.dart';

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
      image: '/introScreen1.jpg',
      dermatosis: 'Dermatosis 1',
      percentage: 60.0,
      date: DateTime.now().subtract(Duration(days: 2)),
      treatment: 'Treatment for Dermatosis 1',
    ));
    scans.add(Scan(
      image: '/introScreen2.jpg',
      dermatosis: 'Dermatosis 2',
      percentage: 92.5,
      date: DateTime.now().subtract(Duration(days: 5)),
      treatment: 'Treatment for Dermatosis 2',
    ));
    scans.add(Scan(
      image: '/introScreen3.jpg',
      dermatosis: 'Dermatosis 3',
      percentage: 40,
      date: DateTime.now().subtract(Duration(days: 6)),
      treatment: 'Treatment for Dermatosis 3',
    ));

    scan2 = scans;
  }

  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Column(
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
                        color: selectedOption == index ? Color.fromARGB(200, 5, 88, 106) : Colors.transparent,
                      ),
                      padding: EdgeInsets.all(8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            tabText,
                            style: TextStyle(
                              fontSize: 16,
                              color: selectedOption == index ? Colors.white : Color.fromARGB(200, 5, 88, 106),
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
                color: Color.fromARGB(200, 5, 88, 106),
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
                  // Filter scan2 based on the search input
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
                  Text('Arrange: New to Old'),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        searchNew = !searchNew;
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
                  return Container(
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
                        scan.image,
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
                      ),
                      title: Text(scan.dermatosis),
                      subtitle: Text('Percentage: ${scan.percentage.toStringAsFixed(2)}%'),
                      trailing: Text('Date: ${scan.date}'),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
