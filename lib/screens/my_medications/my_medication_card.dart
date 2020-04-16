import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';
import 'package:kiloko/config/app_utils.dart';
import 'package:kiloko/models/medication.dart';




class MyMedicationCard extends StatelessWidget {
  final Function onTap;
  final Medication medication;
  final Function deleteCallBack;
  final bool showDeleteIcon;
  
  MyMedicationCard({ 
    this.showDeleteIcon = true, this.onTap, 
    this.deleteCallBack, this.medication });

  @override
  Widget build(BuildContext context) {
        Size screenSize = MediaQuery.of(context).size;

    return Container(
      margin: EdgeInsets.only(
        bottom: 24,
      ),
      padding: EdgeInsets.symmetric(
        horizontal: 12, vertical: 12
      ),
      decoration: BoxDecoration(
        color: AppColors.white,
        border: Border.all(
          width: 1.0,
          color: AppColors.tertiary,
        ),
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          
          BoxShadow(
            color: AppColors.tertiaryAlt,
            spreadRadius: 3.0,
            blurRadius: 4.0
          ),
          
        ]
      ),
      child: SingleChildScrollView(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
             
            Container(
              padding: EdgeInsets.only(left: 12, right: 12, top: 8),
              margin: EdgeInsets.only(right: 12),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Icon(
                      Icons.info,
                      size: 40,
                      color: AppColors.blackAlt1,
                    ),
                  ],
              ),
            ),

            Column(
              
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[

                Container(
                  width: screenSize.width-200,
                  child: 
                    // name and icon
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        
                        // text
                        Text(
                          medication.name,
                          style: Theme.of(context).textTheme.title,
                        ),

                        // icon
                        showDeleteIcon 
                          ? IconButton(
                              icon: Icon(Icons.delete_outline, size: 24),
                              onPressed: ()=> deleteCallBack(medication: medication),
                              color: AppColors.blackAlt2,
                            )
                          : Container(),

                      ],
                    ),
                ),

                medication.reason == null 
                  ? SizedBox() : SizedBox(),

                medication.reason == null 
                 ? Container()
                 : Text( medication.reason, ), 

                SizedBox(height: 16,),

                // from when to when
                RichText(
                  text: TextSpan(
                    style: Theme.of(context).textTheme.body1.copyWith(
                      fontStyle: FontStyle.italic,
                      fontSize: 18
                    ),
                    children: [
                      
                      TextSpan(
                        children: [
                          
                          TextSpan(
                            text: 'From ',
                          ),
                          TextSpan(
                            text: 
                            Jiffy(medication.fromWhen).MMMEd
                          ),
                          TextSpan(
                            text: ' ',
                          ),
                                                      
                        ],
                      ),
                    
                    medication.toWhen == null 
                      ? TextSpan(text: 'till now')
                      : TextSpan(
                          text: 'to ${ Jiffy(medication.toWhen).fromNow() }',
                        ),

                    ]
                  ),
                ),


              ],
            ),

          ],
        ),

      ),

    );
  }
}