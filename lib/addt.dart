import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

 List<Map<String, dynamic>> records = [
  {
  "record_id": "",
        "user_id": "",
        "percent": 0.0,
        "dermatosis": "",
        "record_date": ""
  }
   
  ];
class MyWidget extends StatefulWidget {
  const MyWidget({super.key});

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  @override
  void initState() {
    super.initState();
    // Call getUserData when the page is opened
  saverecordsToFirestore(records);
  }
  Widget build(BuildContext context) {
    return const Text('data');
  }
}

void saverecordsToFirestore(List<Map<String, dynamic>> records) async {
  CollectionReference recordsCollection =
      FirebaseFirestore.instance.collection('records');

  for (Map<String, dynamic> record in records) {
    await recordsCollection.add(record);
  }

  print('record data saved to Firestore.');
}