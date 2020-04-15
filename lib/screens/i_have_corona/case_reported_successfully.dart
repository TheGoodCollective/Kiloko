import 'package:flutter/material.dart';
import 'package:kiloko/config/app_utils.dart';



class CaseReportedSuccessfully extends StatelessWidget {
  final Function goHome;

  CaseReportedSuccessfully(this.goHome);

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    return Container(
      width: screenSize.width,
      padding: EdgeInsets.only(left: 24, right: 24),
      color: AppColors.secondary,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[

          Center(
            child: Text(
              'Thank you for reporting',
              style: Theme.of(context).textTheme.title,
            ),
          ),

          SizedBox(height: 20,),

          Text(
            'Your case has been reported successfully. We wish you a quick recovery',
            style: Theme.of(context).textTheme.body1,
            textAlign: TextAlign.center,
          ),

          SizedBox(height: 60,),
          
          Center(
            child: FloatingActionButton.extended(
              label: Text('Go Back'),
              onPressed: ()=> this.goHome(context: context),
            ),
          ),
         
 
        ],
      ),
    );
  }
}