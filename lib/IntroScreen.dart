import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';

class IntroScreen extends StatelessWidget {
  const IntroScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: IntroductionScreen(
        globalBackgroundColor: Color(0xff519e94),
        scrollPhysics: BouncingScrollPhysics(),
        pages: [
          PageViewModel(
            titleWidget: const Text(
              "Welcome to SkinScan",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold,color: Colors.white),
            ),
            bodyWidget: const Text('Analyze your skin condition and receive instant results and recommendations.',
              style: TextStyle(color: Colors.white,fontSize: 18,),),
            image: Image.asset(
              "assets/introScreen1.jpg",
              height: 400,
              width: 400,
            ),
          ),
          PageViewModel(
            titleWidget: const Text(
              "Track your skin",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold,color: Colors.white),
            ),
            bodyWidget: const Text('Track your skin condition images regularly.',
              style: TextStyle(color: Colors.white,fontSize: 18,),),
            image: Image.asset(
              "assets/introScreen3.jpg",
              height: 400,
              width: 400,
            ),
          ),
          PageViewModel(
            titleWidget: const Text(
              "Your data is safe",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold,color: Colors.white),
            ),
            bodyWidget: const Text('Store your case files and medical information safely.',
              style: TextStyle(color: Colors.white,fontSize: 18,),),
            image: Image.asset("assets/introScreen2.jpg", height: 400, width: 400,),
          )
        ],
        onDone: () {Navigator.pushNamed(context, '/tabNavigation');},
        onSkip: () {
          Navigator.pushNamed(context, '/tabNavigation');},
        showSkipButton: true,
        skip: const Text(
          "Skip",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
            color: Colors.white,
          ),
        ),
        next: const Icon(
          Icons.arrow_forward,
          color: Colors.white,
        ),
        done: const Text(
          "Done",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
            color: Colors.white,
          ),
        ),
        dotsDecorator: DotsDecorator(
            size: Size.square(10.0),
            activeSize: Size(20.0, 10.0),
            color: Colors.black26,
            activeColor: Colors.white,
            spacing: EdgeInsets.symmetric(horizontal: 3.0),
            activeShape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25.0),
            )),
      ),
    );
  }
}


