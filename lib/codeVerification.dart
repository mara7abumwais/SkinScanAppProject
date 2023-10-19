// import 'package:flutter/material.dart';
// import 'package:flutter_verification_code/flutter_verification_code.dart';


// class CodeVerification extends StatefulWidget {
//   const CodeVerification({super.key});

//   @override
//   State<CodeVerification> createState() => _CodeVerificationState();
// }

// class _CodeVerificationState extends State<CodeVerification> {
//   bool _onEditing = true;
//   String? _code;

//   @override
//   build(BuildContext context) {
//     return Scaffold(

//       body: Column(
//         children: [
//           const Padding(
//             padding: EdgeInsets.all(8.0),
//             child: Center(
//               child: Text(
//                 'Enter your code',
//                 style: TextStyle(fontSize: 20.0),
//               ),
//             ),
//           ),
//           VerificationCode(
//             textStyle: Theme.of(context).textTheme.labelMedium!.copyWith(color: Colors.white),
//             keyboardType: TextInputType.number,
//             underlineColor: Colors.amber,
//             length: 4,
//             cursorColor: Colors.blue,
//             clearAll: const Padding(
//               padding: EdgeInsets.all(8.0),
//               child: Text(
//                 'clear all',
//                 style: TextStyle(
//                     fontSize: 18.0,
//                     color: Colors.white),
//               ),
//             ),
//             margin: const EdgeInsets.all(12),
//             onCompleted: (String value) {
//               setState(() {
//                 _code = value;
//               });
//             },
//             onEditing: (bool value) {
//               setState(() {
//                 _onEditing = value;
//               });
//               if (!_onEditing) FocusScope.of(context).unfocus();
//             },
//           ),
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Center(
//               child: _onEditing
//                   ? const Text('Please enter full code')
//                   : Text('Your code: $_code'),
//             ),
//           ),
//           SizedBox(height: 20,),
//           MaterialButton(
//             color:  Color.fromARGB(255, 5, 88, 106),
//             height: 40,
//             minWidth: double.infinity,
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(10.0),
//             ),
//             child: const Text(
//               "Verify Code",
//               style: TextStyle(color: Colors.white, fontSize: 16),
//             ),
//             onPressed: () {
//               setState(() {
//                 //هون المفروض يقارن بالكود اللي بوخدوا من الايميل
//                 Navigator.pushNamed(context, '/createPassword');
//               });
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }