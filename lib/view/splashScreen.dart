import 'dart:async';
import 'package:covid_19_tracker_app/Utilities/Routes.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'WorldStatus.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin{

  late final AnimationController _controller=AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this)..repeat();
  @override

  void initState() {
    super.initState();
    Timer( Duration(seconds: 5), ()=>Navigator.pushNamed(context, RouteName.worldScreen));
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children:  [
            AnimatedBuilder(animation: _controller,
              builder: (BuildContext contex,Widget ? child){
                return Transform.rotate(angle: _controller.value * 2.0*math.pi,
                  child: Container(height: 200,width: 200,
                    child: const Center(child: Image(image: AssetImage("images/virus.png"),)),) ,);},),
            SizedBox(height: MediaQuery.of(context).size.height *0.08,),
            Center(child:
            const Text("Covid-19 \n Tracking App",textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25),)),
          ],
        ),
      ),
    );
  }
}
