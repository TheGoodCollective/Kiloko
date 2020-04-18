import 'package:dot_pagination_swiper/dot_pagination_swiper.dart';
import 'package:flutter/material.dart';
import 'package:kiloko/config/app_routes.dart';
import 'package:kiloko/config/app_utils.dart';
import 'package:kiloko/providers/local_account_provider.dart';
import 'package:kiloko/screens/tutorial/tutorial_page.dart';
import 'package:provider/provider.dart';



class TutorialScreen extends StatefulWidget {
  @override
  _TutorialScreenState createState() => _TutorialScreenState();
}

class _TutorialScreenState extends State<TutorialScreen> {
  LocalAccountProvider _localAccountProvider;

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    _localAccountProvider = Provider.of<LocalAccountProvider>(context, listen: false);

    return Scaffold(

      body: DotPaginationSwiper(
        children: <Widget>[
          
          TutorialPage(
            title: 'Flatten the Curve',
            subTitle: 'Track your daily movements to know whether you got exposed',
            image: 'assets/images/one.jpg',
            cta: null,
            screenSize: screenSize,
            color: AppColors.primary,
          ),

          
          TutorialPage(
            title: 'Flatten the Curve',
            subTitle: 'Track your daily movements to know whether you got exposed',
            image: 'assets/images/one.jpg',
            cta: null,
            screenSize: screenSize,
            color: AppColors.secondary,
          ),

          
          TutorialPage(
            title: '#Bring Nomarlcy Back',
            subTitle: 'Let’s work together to heal the world and bring normalcy with Kiloko',
            image: 'assets/images/one.jpg',
            cta: Container(
              width: 72,
              height: 72,
              child: FloatingActionButton(
                child: Icon(
                  Icons.keyboard_arrow_right,
                  size: 36,
                ),
                onPressed: ()=> this._goHome(context: context),
              ),
            ),
            screenSize: screenSize,
            color: AppColors.tertiary,
          ),

        ],
      ),
      
    );
  }// Widget build(BuildContext context) { .. }


  void _goHome({ BuildContext context }) async {
    await _localAccountProvider.newAccount();
    Navigator.of(context).pushReplacementNamed(AppRoutes.HOME);
  }// void _goHome({ BuildContext context }) { .. }
}