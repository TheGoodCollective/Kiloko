import 'package:flutter/material.dart';
import 'package:kiloko/config/app_utils.dart';
import 'package:kiloko/models/condition.dart';
import 'package:kiloko/models/medication.dart';
import 'package:jiffy/jiffy.dart';


class MyConditionCard extends StatelessWidget {
  final Function onTap;
  final Function deleteCallBack;
  final Condition condition;
  final bool showDeleteIcon;
  
  MyConditionCard({ 
    this.onTap, this.deleteCallBack, 
    this.condition, this.showDeleteIcon = true
  });

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
                  width: screenSize.width-160,
                  child: 
                    // name and icon
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        
                        // text
                        Text(
                          condition.name,
                          style: Theme.of(context).textTheme.title,
                        ),

                        // icon
                        showDeleteIcon 
                          ? IconButton(
                              icon: Icon(Icons.delete_outline, size: 24),
                              onPressed: ()=> deleteCallBack(condition: condition),
                              color: AppColors.blackAlt2,
                            )
                          : Container(),

                      ],
                    ),
                ),

                SizedBox(height: 8,),

                // text
                Text(
                  'Medicines',
                  style: Theme.of(context).textTheme.body1.copyWith(
                    fontWeight: FontWeight.w400,
                    fontSize: 18
                  ),
                ),

                // medicines
                Container(
                  child: Wrap(
                    direction: Axis.horizontal,
                    spacing: 2.0,
                    runSpacing: 8.0,
                    children: <Widget>[
                      
                      ...condition.medications.map((Medication med) {

                        return MedicineChip(
                          medicine: med.name,
                        );
                      }).toList(),

                    ],
                  ),
                ),

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
                            Jiffy(condition.fromWhen).MMMEd
                          ),
                          TextSpan(
                            text: ' ',
                          ),
                                                      
                        ],
                      ),
                    
                    condition.toWhen == null 
                      ? TextSpan(text: 'till now')
                      : TextSpan(
                          text: 'to ${ Jiffy(condition.toWhen).fromNow() }',
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


class MedicineChip extends StatelessWidget {
  final String medicine;

  MedicineChip({this.medicine});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 10),
      child: Chip(
        backgroundColor: AppColors.tertiaryAlt.withOpacity(0.8),
        label: Text(
          medicine,
          style: Theme.of(context).textTheme.body1.copyWith(
            fontSize: 17,
            color: AppColors.blackAlt1
          ),
        ),
      ),
    );
  }
}