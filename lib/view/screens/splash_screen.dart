import 'dart:async';

import 'package:flutter/material.dart';
import 'package:news/view/screens/layout_screen.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:flutter/services.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  // Timer timer;
  void initState() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
 
    super.initState();
  }
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor:  Color.fromARGB(255, 227, 84, 73),
      backgroundColor: Color(0xffD61123),

      body: Container(
        
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xffE43033),
              Color(0xffDE232A),
              Color(0xffDF262C),
              Color(0xffDF262C),
              Color(0xffD30E22)
            ],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: Device.orientation == Orientation.portrait ? 50.h : 38.h,
              width: Device.orientation == Orientation.portrait ? 90.w : 40.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(35.0)),
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage("assets/image/logo.jpg")),
              ),
            ),
            Center(
              child: Text(
                'News Report',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 30.sp,
                    fontWeight: FontWeight.bold,
                    height: 1.8),
              ),
            ),
          ],
        ),
      ),
    );
  }
  // @override
  // void dispose() {
  //   timer.cancel();
  //   super.dispose();
  // }
}
