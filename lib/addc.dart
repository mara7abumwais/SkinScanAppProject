// import 'package:firebase_core/firebase_core.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/cupertino.dart';

//  List<Map<String, dynamic>> clinics = [
//     {
//       'clinicId': 1,
//       'clinicName': 'Hebron medical center',
//       'doctorName': 'feras aljabari',
//       'city': 'hebron',
//       'location': 'hebron center',
//       'openingHours': '6:00-8:00 مساء m,w',
//     },
//     {
//       'clinicId': 2,
//       'clinicName': 'Arab Care Hospital Clinics',
//       'doctorName': 'Saed ibdah ابداح',
//       'city': 'Ramallah',
//       'location': 'Al bira',
//       'openingHours': '0',
//     },
//     {
//       'clinicId': 3,
//       'clinicName': 'Alrahma clinic',
//       'doctorName': 'Saed ibdah ابداح',
//       'city': 'nablus',
//       'location': 'faisal street',
//       'openingHours': '0',
//     },
//     {
//       'clinicId': 4,
//       'clinicName': 'Medical beauty center',
//       'doctorName': 'Mohammed swaiti',
//       'city': 'Ramallah',
//       'location': 'Tufaha building',
//       'openingHours': '11-6 m,t,w,th',
//     },
//     {
//       'clinicId': 5,
//       'clinicName': 'Medical beauty center',
//       'doctorName': 'Mohammed swaiti',
//       'city': 'Hebron',
//       'location': 'Nerokh building',
//       'openingHours': '9-5 sat,sun',
//     },
//     {
//       'clinicId': 6,
//       'clinicName': 'Dermatology, venereology and laser clinic',
//       'doctorName': 'wajeeh husain',
//       'city': 'Ramallah',
//       'location': 'irsal building',
//       'openingHours': '10-6 sat to th',
//     },
//     {
//       'clinicId': 7,
//       'clinicName': 'Dermatology, venereology clinic',
//       'doctorName': 'bahaa owaiwi',
//       'city': 'hebron',
//       'location': 'Taiba center',
//       'openingHours': '0',
//     },
//     {
//       'clinicId': 8,
//       'clinicName': 'Dermatology clinic',
//       'doctorName': 'Riyad mishel',
//       'city': 'Ramallah',
//       'location': 'Tanous building',
//       'openingHours': '10-7 sat-th',
//     },
//     {
//       'clinicId': 9,
//       'clinicName': 'Dermatology, venereology clinic',
//       'doctorName': 'Zeyad olwan',
//       'city': 'hebron',
//       'location': 'Eid Building',
//       'openingHours': '9-4 sat - th',
//     },
//     {
//       'clinicId': 10,
//       'clinicName': 'Dermatology, venereology clinic',
//       'doctorName': 'isaa khair',
//       'city': 'Bethlehem',
//       'location': 'freej building',
//       'openingHours': '8:30 - 1:30 sat, m- th',
//     },
//     {
//       'clinicId': 11,
//       'clinicName': 'Dermatology, venereology clinic',
//       'doctorName': 'Mohammed jaradat',
//       'city': 'jenin',
//       'location': 'al nemer center',
//       'openingHours': '9:00 6:00 sat - th',
//     },
//     {
//       'clinicId': 12,
//       'clinicName': 'Dermatology, venereology clinic',
//       'doctorName': 'Wael aljamal',
//       'city': 'Jenin',
//       'location': 'Al-Naffa Commercial Center',
//       'openingHours': '8:00-4:00 sat - th ما عدا الاثنين',
//     },
//     {
//       'clinicId': 13,
//       'clinicName': 'Dermatology, venereology clinic',
//       'doctorName': 'Abdel Fattah Al-Safadi',
//       'city': 'nablus',
//       'location': 'Aloul and Abu Salha Building',
//       'openingHours': '0',
//     },
//     {
//       'clinicId': 14,
//       'clinicName': 'Dermatology, venereology clinic',
//       'doctorName': 'ghaleb barham',
//       'city': 'Tulkarm',
//       'location': 'Afif Haj Ibrahim Building',
//       'openingHours': '9:00 - 2:00 sat-th',
//     },
//     // Add more clinic entries here...
//   ];
// class MyWidget extends StatefulWidget {
//   const MyWidget({super.key});

//   @override
//   State<MyWidget> createState() => _MyWidgetState();
// }

// class _MyWidgetState extends State<MyWidget> {
//   @override
//   void initState() {
//     super.initState();
//     // Call getUserData when the page is opened
//   saveClinicsToFirestore(clinics);
//   }
//   Widget build(BuildContext context) {
//     return const Text('data');
//   }
// }

// void saveClinicsToFirestore(List<Map<String, dynamic>> clinics) async {
//   CollectionReference clinicCollection =
//       FirebaseFirestore.instance.collection('clinics');

//   for (Map<String, dynamic> clinic in clinics) {
//     await clinicCollection.add(clinic);
//   }

//   print('Clinic data saved to Firestore.');
// }