import 'package:flutter/material.dart';

// screens
import 'package:kiloko/screens/about/about.dart';
import 'package:kiloko/screens/account/account.dart';
import 'package:kiloko/screens/add_conditions_and_medications/add_conditions_and_medications_screen.dart';
import 'package:kiloko/screens/home/home_screen.dart';
import 'package:kiloko/screens/i_have_corona/i_have_corona_screen.dart';
import 'package:kiloko/screens/login/login_screen.dart';
import 'package:kiloko/screens/my_conditions/my_conditions_screen.dart';
import 'package:kiloko/screens/my_medications/my_medications_screen.dart';
import 'package:kiloko/screens/policies/policies_screen.dart';
import 'package:kiloko/screens/protection/protection_screen.dart';
import 'package:kiloko/screens/register/register_screen.dart';
import 'package:kiloko/screens/symptoms_check/symptoms_check_screen.dart';
import 'package:kiloko/screens/tutorial/tutorial_screen.dart';


class AppRoutes {
  static const String TUTORIAL = '/tutorial';
  static const String BASE = '/';
  static const String HOME = '/home';
  static const String ABOUT = '/about';
  
  static const String PREVENTION = '/prevention';
  static const String SYMPTOM_CHECK = '/symptoms/check';
  static const String HOSPITALS_NEAR = '/hospitals/near';
  static const String POLICIES = '/policies';

  static const String ADD_CONDITIONS_AND_MEDICATION = '/add-conditions-and-medications';
  static const String MY_CONDITIONS = '/my-conditions';
  static const String MY_MEDICATION = '/my-medications';
  
  static const String I_HAVE_CORONA = '/i-have-corona';

  static const String ACCOUNT = '/account';
  static const String LOGIN = '/login';
  static const String REGISTER = '/register';
  
  
  static Route<dynamic> generate(RouteSettings settings) {
    String screenName = settings.name;
    var args = settings.arguments;
    Widget screen;


    switch (screenName) {
      // tutorial
      case AppRoutes.BASE:
        // screen = TutorialScreen();
        // screen = IHaveCoronaScreen();
        // screen = SymptomsCheckScreen();

        screen = AddConditionsAndMedicationsScreen();
        // screen = MyConditionsScreen();
        // screen = MyMedicationsScreen();
        break;

      // tutorial
      case AppRoutes.TUTORIAL:
        screen = TutorialScreen();
        break;

      // home
      case AppRoutes.HOME:
        screen = HomeScreen();
        break;

      // protection
      case AppRoutes.PREVENTION:
        screen = ProtectionScreen();
        break;
        
      // symptom check
      case AppRoutes.SYMPTOM_CHECK:
        screen = SymptomsCheckScreen();
        break;
        
      // ACCOUNT
      case AppRoutes.ACCOUNT:
        screen = AccountScreen();
        break;
        
      // login
      case AppRoutes.LOGIN:
        screen = LoginScreen();
        break;
        
      // REGISTER
      case AppRoutes.REGISTER:
        screen = RegisterScreen();
        break;

      // add conditions & medications
      case AppRoutes.ADD_CONDITIONS_AND_MEDICATION:
        screen = AddConditionsAndMedicationsScreen();
        break;

      // show user conditions
      case AppRoutes.MY_CONDITIONS:
        screen = MyConditionsScreen();
        break;

      // show user medications
      case AppRoutes.MY_MEDICATION:
        screen = MyMedicationsScreen();
        break;
        
      // i have corona
      case AppRoutes.I_HAVE_CORONA:
        screen = IHaveCoronaScreen();
        break;
        
      // policies
      case AppRoutes.POLICIES:
        screen = PoliciesScreen();
        break;
      
      // about
      case AppRoutes.ABOUT:
        screen = AboutScreen();
        break;

      // tutorial
      default:
        screen = TutorialScreen();
        break;
    }
    
    return MaterialPageRoute( builder: (_)=> screen );
  }// static Route<dynamic> generate(RouteSettings settings) { .. }


}