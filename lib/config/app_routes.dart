import 'package:flutter/material.dart';


class AppRoutes {
  static const String BASE = '/tutorial';
  static const String HOME = '/';
  static const String TUTORIAL = '/tutorial';

  static const String PREVENTION = '/prevention';
  static const String SYMPTOM_CHECK = '/symptoms/check';
  static const String HOSPITALS_NEAR = '/hospitals/near';
  static const String POLICIES = '/policies';

  static const String ACCOUNT = '/account';
  static const String LOGIN = '/login';
  static const String REGISTER = '/register';
  
  
  static Route<dynamic> generate(RouteSettings settings) {
    String screenName = settings.name;
    var args = settings.arguments;
    Widget screen;


    // switch (screenName) {
    //   case AppRoutes.HOME:
    //     screen = HomeScreen();
    //     break;
    //   default:
    //     screen = TutorialScreen();
    // }
    
    return MaterialPageRoute( builder: (_)=> screen );
  }// static Route<dynamic> generate(RouteSettings settings) { .. }


}