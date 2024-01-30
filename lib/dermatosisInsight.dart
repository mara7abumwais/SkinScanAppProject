import 'package:flutter/material.dart';

class DermatosisInsight extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dermatosis Insight'),
        backgroundColor: Color(0xff519e94),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'About Dermatosis Insight',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'Due to the limitations of our dataset, we have chosen to focus on four dermatoses and the normal skin case. Each dermatosis has its unique characteristics and considerations.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            Text(
              'Chosen Dermatoses:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            _buildDermatosisInfo(
              'Acne',
              'Acne is a common skin condition characterized by the presence of pimples, blackheads, and whiteheads. It often occurs during adolescence but can persist into adulthood.',
            ),
            _buildDermatosisInfo(
              'Psoriasis',
              'Psoriasis is a chronic autoimmune condition that results in the rapid buildup of skin cells, leading to red, scaly, and itchy patches. It can affect various parts of the body.',
            ),
            _buildDermatosisInfo(
              'Melanoma',
              'Melanoma is a type of skin cancer that develops from pigment-producing cells. It is crucial to monitor moles for changes in size, shape, or color, as early detection is key for successful treatment.',
            ),
            _buildDermatosisInfo(
              'Eczema',
              'Eczema, or atopic dermatitis, is an inflammatory skin condition that leads to red, itchy, and inflamed skin. It is often seen in individuals with a predisposition to allergies.',
            ),
            _buildDermatosisInfo(
              'Normal Skin',
              'Normal skin represents a healthy and balanced state. Understanding the characteristics of normal skin serves as a baseline for assessing deviations and identifying potential dermatological issues.',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDermatosisInfo(String name, String description) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$name:',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 5),
        Text(
          description,
          style: TextStyle(fontSize: 14),
        ),
        SizedBox(height: 15),
      ],
    );
  }
}

