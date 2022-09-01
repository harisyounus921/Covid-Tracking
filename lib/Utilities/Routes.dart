import 'package:covid_19_tracker_app/view/splashScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../view/CountriesList.dart';
import '../view/DetailScreen.dart';
import '../view/WorldStatus.dart';

class RouteName{
  static const String splashScreen="splash_screen";
  static const String worldScreen="world_screen";
  static const String countryScreen="country_screen";
  static const String detailScreen="detail_screen";
}

class Routes{
  static Route<dynamic> generateRoute(RouteSettings settings){
    switch(settings.name){
      case RouteName.splashScreen:
        return MaterialPageRoute(builder: (context)=> SplashScreen());
      case RouteName.worldScreen:
        return MaterialPageRoute(builder: (context)=> WorldStatus());
      case RouteName.countryScreen:
        return MaterialPageRoute(builder: (context)=> CountriesListScreen());
      case RouteName.detailScreen:
        return MaterialPageRoute(builder: (context)=> DetailScreen(data:settings.arguments as Map));
      default:
        return MaterialPageRoute(builder: (context){
          return const Scaffold(
            body: Center(child: Text("No route defined")),
          );
        });


    }
  }
}