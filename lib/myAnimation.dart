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
          body:Stack(
            children: [
              Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/myAnimation.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 350),
                  AnimatedTextKit(
                    totalRepeatCount: 1,
                    animatedTexts: [
                      FadeAnimatedText(
                        'Welcome',
                        textStyle: const TextStyle(
                            color: Color(0xff519e94),
                            fontSize: 40.0,
                            fontWeight: FontWeight.bold),
                      ),
                      ScaleAnimatedText(
                        'to our App',
                        textStyle: const TextStyle(
                            color: Color(0xff519e94), fontSize: 40.0),
                      ),
                      WavyAnimatedText('SkinScan',
                          textStyle: const TextStyle(
                              color: Color(0xff519e94),
                              fontSize: 50,
                              fontWeight: FontWeight.bold)),
                    ],
                    onFinished: () {
                      Navigator.pushNamed(context,'/login');
                    },
                  ),
                ],
              )
            ],
          )
      ),
    );
  }
}
