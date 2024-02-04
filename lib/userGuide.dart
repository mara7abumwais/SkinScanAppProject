import 'package:flutter/material.dart';

class UserGuide extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Guide'),
        backgroundColor: Color(0xff519e94),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/takePhotoGuide.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Tips for Taking a Good Picture of Your Skin Spot:',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20.0),
              _buildTip('Remove any makeup or hair that covers the area you want to scan.'),
              _buildTip('Use natural, bright light, such as that coming in through a window. Avoid light that comes from behind you.'),
              _buildTip('Use a neutral, one-color background, such as a solid-colored wall or door.'),
              _buildTip('Focus the camera on the skin spot and make sure it is clear. You can tap the screen on your phone to adjust the focus.'),
              _buildTip('Take a close-up picture of the skin spot, as well as a picture that shows the location of the spot on your body.'),
              _buildTip('If you have difficulty taking a picture of a hard-to-see area, ask someone to help you or use a selfie stick or a timer.'),
              const Text(
                'Remember that the App is not a substitute for a medical diagnosis, and you should always consult '
                    'a dermatologist or other qualified healthcare provider if you have any concerns about your health.',
                style: TextStyle(
                  fontSize: 12.0,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTip(String tip) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.check_circle,
            color: Colors.green,
          ),
          SizedBox(width: 15.0),
          Expanded(
            child: Text(
              tip,
              style: TextStyle(fontSize: 16.0,fontWeight: FontWeight.w700,backgroundColor: Colors.white,),
            ),
          ),
        ],
      ),
    );
  }
}

