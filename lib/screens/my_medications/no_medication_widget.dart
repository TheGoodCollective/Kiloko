import 'package:flutter/material.dart';
import 'package:kiloko/config/app_utils.dart';

class NoMedicationWidget extends StatelessWidget {
  final Function goViewWhy;

  NoMedicationWidget({ this.goViewWhy });

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    return Container(
      padding: EdgeInsets.only(left: 16, right: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[

          SizedBox(height: screenSize.height/8),
          
          Center(
            child: CircleAvatar(
              radius: screenSize.width/6,
              backgroundImage: AssetImage(AppImages.corona),
            ),
          ),

          SizedBox(height: 56,),

          Center(
            child: Text(
              'No Medications',
              style: Theme.of(context).textTheme.title,
            ),
          ),

          SizedBox(height: 32,),
          
          Text(
            'Incase you are taking any medications, click below button to add it. Your medications will appear here',
            style: Theme.of(context).textTheme.body2,
            textAlign: TextAlign.center,
          ),
 
          SizedBox(height: 80,),
          
          GestureDetector(

            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                
                Icon(
                  Icons.info,
                  color: AppColors.primary,
                ),

                SizedBox(width: 8,),
                
                Text(
                  'Why should I add',
                  style: Theme.of(context).textTheme.body1.copyWith(
                    color: AppColors.primary,
                  )
                ),

              ],
            ),

            onTap: this.goViewWhy,
          ),

        ],
      ),
    );
  }// Widget build(BuildContext context) { .. }
}