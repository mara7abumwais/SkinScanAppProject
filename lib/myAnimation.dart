import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';


class MyAnimation extends StatefulWidget {
  const MyAnimation({super.key});
  _MyAnimationState createState() => _MyAnimationState();
}

class _MyAnimationState extends State<MyAnimation> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          backgroundColor: Color.fromARGB(200, 5, 88, 106),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 500,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    AnimatedTextKit(
                      totalRepeatCount: 1,
                      animatedTexts: [
                        FadeAnimatedText(
                          'Welcome',
                          textStyle: const TextStyle(
                              color: Colors.white,
                              fontSize: 40.0,
//                              fontSize: 40,
                              fontWeight: FontWeight.bold),
                        ),
                        ScaleAnimatedText(
                          'to our App',
                          //duration: Duration(milliseconds: 4000),
                          textStyle: const TextStyle(
                              color: Color(0xffeeeff4), fontSize: 40.0),
                        ),
                        WavyAnimatedText('SkinScan',
                            textStyle: const TextStyle(
                                color: Color(0xfff2f4f6),
                                fontSize: 50,
                                fontWeight: FontWeight.bold)),
                      ],
                      // repeatForever: true,
                      onFinished: () {
                        Navigator.pushNamed(context,'/login');
                      },
                    ),
                  ],
                ),
              ),
              // Text("data")
            ],
          )),
    );
  }
}
