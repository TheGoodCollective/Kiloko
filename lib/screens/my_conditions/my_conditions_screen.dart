import 'package:flutter/material.dart';
import 'package:kiloko/config/app_utils.dart';
import 'package:kiloko/models/condition.dart';
import 'package:kiloko/models/medication.dart';
import 'package:kiloko/screens/my_conditions/my_condition_card.dart';
import 'package:kiloko/widgets/app_scaffold.dart';

class MyConditionsScreen extends StatefulWidget {
  @override
  _MyConditionsScreenState createState() => _MyConditionsScreenState();
}

class _MyConditionsScreenState extends State<MyConditionsScreen> {
  // List<Condition> _conditions = [];
  List<Condition> _conditions = [
    Condition(
      name: 'malaria',
      medications: [
        Medication(name: 'brufen'),
        Medication(name: 'chlorosth'),
        Medication(name: 'chlorosth 1'),
        Medication(name: 'chlorosth 2'),
      ],
      fromWhen: DateTime.now().subtract(Duration(days: 10)),
      // toWhen: DateTime.now().subtract(Duration(days: 1)),
    ),
    Condition(
      name: 'insomnia',
      medications: [
        Medication(name: 'brufen'),
        Medication(name: 'piriton'),
      ],
      fromWhen: DateTime.now().subtract(Duration(days: 6)),
      toWhen: DateTime.now().subtract(Duration(days: 4)),
    ),
  ];
  
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    return Scaffold(

      appBar: AppBar(
        title: Text('My Conditions'),
        centerTitle: true,
      ),

      body: AppScaffold(
        children: <Widget>[
          
          _conditions.length > 0 
            ? _buildConditionsList(context: context)
            : _buildNoConditionsList(context: context),


        ],
      ),

      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add, size: 32,),
        onPressed: this._goAddCondition,
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      
    );
  }// Widget build(BuildContext context) { .. }
  

  Widget _buildConditionsList({ BuildContext context }) {
    Size screenSize = MediaQuery.of(context).size;

    return Container(
      padding: EdgeInsets.only(left: 16, right: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          
          SizedBox(height: 40,),
                                        
          // Text(
          //   'Conditions I currently have',
          //   style: Theme.of(context).textTheme.subhead,
          // ),

          // SizedBox(height: 24,),
              
          ..._conditions.map((Condition cond) {

            return MyConditionCard(
              condition: cond,
              onTap: () {},
              deleteCallBack: this._deleteCondition,
              showDeleteIcon: true,
            );
          }).toList(),

        ],
      ),
    );
  }// Widget _buildConditionsList({ BuildContext context }) { .. }

  // show when user has no conditions
  Widget _buildNoConditionsList({ BuildContext context }) {
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
              'No Conditions',
              style: Theme.of(context).textTheme.title,
            ),
          ),

          SizedBox(height: 32,),
          
          Text(
            'Incase you have any conditions, click below button to add it. Your conditions will appear here',
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

            onTap: this._goViewWhy,
          ),

        ],
      ),
    );
  }// Widget _buildNoConditionsList({ BuildContext context }) { .. }




  /*
   ** logic functs
   */


  void _goViewWhy() {

  }// void _goViewWhy() { .. }
  
  bool _deleteCondition({ Condition condition }) {

  }// bool _deleteCondition({ Condition condition }) { .. }
  
  void _goAddCondition() {

  }// void _goAddCondition() { .. }

}