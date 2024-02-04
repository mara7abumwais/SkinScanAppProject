import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class treatment extends StatefulWidget {
  final String dermatosisName;

  const treatment({Key? key, required this.dermatosisName}) : super(key: key);

  @override
  State<treatment> createState() => _treatmentState();
}

class _treatmentState extends State<treatment> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Treatment'),
        backgroundColor: Color(0xff519e94),
        leading: BackButton(
          onPressed: () {
            setState(() {
              Navigator.pop(context);
            });
          },
        ),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('treatments')
        .where('dermatosis', isEqualTo: widget.dermatosisName)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            var data = snapshot.data as QuerySnapshot;
            var document = data.docs[0]['treatment'];
            List<String> sentences = document.split('.');

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Text(
                      'Treatment for',
                      style: TextStyle(fontSize: 20, color:Color(0xff519e94),fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 50.0),
                    child: Text(
                      '${widget.dermatosisName}:',
                      style: TextStyle(fontSize: 40, color:Color(0xff519e94),fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: sentences.length,
                    itemBuilder: (context, index) {
                      if (sentences[index].trim().isEmpty) {
                        return SizedBox.shrink();
                      }
                      return Card(
                        elevation: 3,
                        margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            gradient: const LinearGradient(
                              colors: [
                                Color(0xff519e94),
                                Colors.white
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                          ),
                          child: ListTile(
                            title: Text(
                              sentences[index].trim() + ".",
                              style: TextStyle(fontSize: 16, color: Colors.black87,fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}