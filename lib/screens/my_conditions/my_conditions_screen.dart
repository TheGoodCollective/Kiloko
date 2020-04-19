import 'package:flutter/material.dart';
import 'package:kiloko/models/condition.dart';
import 'package:kiloko/providers/local_condition_provider.dart';
import 'package:kiloko/screens/my_conditions/add_condition_widget.dart';
import 'package:kiloko/screens/my_conditions/conditions_list_widget.dart';
import 'package:kiloko/screens/my_conditions/no_conditions_widget.dart';
import 'package:kiloko/widgets/app_scaffold.dart';
import 'package:provider/provider.dart';

class MyConditionsScreen extends StatefulWidget {
  @override
  _MyConditionsScreenState createState() => _MyConditionsScreenState();
}

class _MyConditionsScreenState extends State<MyConditionsScreen> {
  LocalConditionProvider _localConditionProvider;
  
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    _localConditionProvider = Provider.of<LocalConditionProvider>(context, listen: false);

    return Scaffold(

      appBar: AppBar(
        title: Text('My Conditions'),
        centerTitle: true,
      ),

      body: AppScaffold(
        children: <Widget>[
          
          Consumer<LocalConditionProvider> (
            builder: (BuildContext ctx, LocalConditionProvider conditionProvider, _) {

              return conditionProvider.conditions.length > 0 
                ? ConditionsListWidget(
                  conditions: conditionProvider.conditions,
                  deleteCondition: this._deleteCondition,
                )
                : NoConditionsWidget(
                  goViewWhy: this._goViewWhy,
                );

            },
          ),


        ],
      ),

      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add, size: 32,),
        onPressed: this._goAddCondition,
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      
    );
  }// Widget build(BuildContext context) { .. }

  


  /*
   ** logic functs
   */


  void _goViewWhy() {

  }// void _goViewWhy() { .. }
  
  bool _deleteCondition({ Condition condition }) {
    _localConditionProvider.delete(condition: condition);
  }// bool _deleteCondition({ Condition condition }) { .. }
  
  void _goAddCondition() {
    showDialog(
      context: context,
      builder: (BuildContext ctx)=> Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: SingleChildScrollView(
          child: AddConditionWidget(),
        ),
      ),
    );
  }// void _goAddCondition() { .. }

}