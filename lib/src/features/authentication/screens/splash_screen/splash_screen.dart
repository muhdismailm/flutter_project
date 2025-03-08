import 'package:flutter/material.dart';
import 'package:login_1/src/constants/image_string.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children:[
          const Positioned(
          top: 0,
          left: 0,
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

        ]
    ));
  }
}