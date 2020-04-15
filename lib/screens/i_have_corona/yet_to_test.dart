import 'package:flutter/material.dart';
import 'package:kiloko/config/app_utils.dart';



class YetToTest extends StatelessWidget {
  final Function goCheckSymptoms;
  final Function goHome;

  YetToTest({ 
    @required this.goCheckSymptoms, @required this.goHome });

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    
    return Container(
      width: screenSize.width,
      color: AppColors.secondary,
      padding: EdgeInsets.only(left: 24, right: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[

          Center(
            child: Text(
              'Get tested first',
              style: Theme.of(context).textTheme.title,
            ),
          ),

          SizedBox(height: 20,),

          Text(
            'Check whether your symptoms match those of corona and ascertain whether you need to visit a doctor',
            style: Theme.of(context).textTheme.body1,
            textAlign: TextAlign.center,
          ),

          SizedBox(height: 60,),
          
          Center(
            child: FloatingActionButton.extended(
              label: Text('Check Symptoms'),
              onPressed: ()=> this.goCheckSymptoms(context: context),
            ),
          ),

          SizedBox(height: 60,),
         
          Center(
            child: FlatButton(
              child: Text('Go Back'),
              onPressed: ()=> this.goHome(context: context),
            ),
          ),

        ],
      ),
    );
  }
}