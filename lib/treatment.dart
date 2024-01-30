import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class treatment extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your App'),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('treatments')
          .where('dermatosis', isEqualTo: 'Eczema')
          .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            var data = snapshot.data as QuerySnapshot;
            var documents = data.docs;
            return ListView.builder(
              itemCount: documents.length,
              itemBuilder: (context, index) {
                var document = documents[index];
                // Use document data here
                return ListTile(
                  title: Text(document['treatment']),
                );
              },
            );
          }
        },
      ),
    );
  }
}
