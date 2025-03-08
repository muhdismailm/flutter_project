import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:login_1/src/constants/colors.dart';
import 'package:login_1/src/constants/image_string.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);



  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  bool animate = false;

  @override
  void initState(){
    startAnimation();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children:[
          AnimatedPositioned(
            duration: const Duration(milliseconds: 1600),
          top: animate ? 0 :-30,
          left: animate ? 0 :-30,
          child: Image(image: AssetImage(tSplashIcon)),
          ),
        Positioned(
          top: 80,
          left: kDefaultFontSize,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Workify",style:Theme.of(context).textTheme.labelMedium),
              Text("connecting workers",style:Theme.of(context).textTheme.labelSmall)
            ],
          )
        ),
        const Positioned(
          bottom: 40,
          child: Image(image: AssetImage(tSplashworker)),
          ),
          Positioned(
            bottom: 40,
            right: 40,
            child: Container(
              width: 50 ,
              height: 100,
              color: tPrimaryColor,
            ),
          )

        ]
    ));
  }
}

Future startAnimation() async{
  await Future.delayed(Duration(milliseconds: 500));
  setState(){
  var animate =true;
  }
  //  await Future.delayed(Duration(milliseconds: 5000));
  //  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => welcome_screen,))
}