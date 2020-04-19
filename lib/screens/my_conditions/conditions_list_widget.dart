import 'package:flutter/material.dart';
import 'package:kiloko/models/condition.dart';
import 'package:kiloko/screens/my_conditions/my_condition_card.dart';



class ConditionsListWidget extends StatelessWidget {
  final List<Condition> conditions;
  final Function deleteCondition;
  
  ConditionsListWidget({ this.conditions, this.deleteCondition });

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    return Container(
      padding: EdgeInsets.only(left: 16, right: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          
          SizedBox(height: 40,),
              
          ...conditions.map((Condition cond) {

            return MyConditionCard(
              condition: cond,
              onTap: () {},
              deleteCallBack: this.deleteCondition,
              showDeleteIcon: true,
            );
          }).toList(),

        ],
      ),
    );
  }// Widget build(BuildContext context) { .. }
}