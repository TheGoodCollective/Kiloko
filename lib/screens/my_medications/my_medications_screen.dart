import 'package:flutter/material.dart';
import 'package:kiloko/config/app_utils.dart';
import 'package:kiloko/models/medication.dart';
import 'package:kiloko/screens/my_medications/my_medication_card.dart';
import 'package:kiloko/widgets/app_scaffold.dart';



class MyMedicationsScreen extends StatefulWidget {
  @override
  _MyMedicationsScreenState createState() => _MyMedicationsScreenState();
}

class _MyMedicationsScreenState extends State<MyMedicationsScreen> {
  List<Medication> _medications = [];
  List<Medication> _medicationz = [
    Medication(
      name: 'Brufen',
      reason: 'Headache',
      fromWhen: DateTime.now().subtract(Duration(days: 4))
    ),
    Medication(
      name: 'Piriton',
      reason: 'To sleep',
      fromWhen: DateTime.now().subtract(Duration(days: 4)),
      toWhen: DateTime.now().subtract(Duration(days: 1))
    ),
    Medication(
      name: 'Moxy',
      fromWhen: DateTime.now().subtract(Duration(days: 4)),
      toWhen: DateTime.now().subtract(Duration(days: 1))
    ),
  ];

  @override
  Widget build(BuildContext context) {
     Size screenSize = MediaQuery.of(context).size;

    return Scaffold(

      appBar: AppBar(
        title: Text('My Medications'),
        centerTitle: true,
      ),

      body: AppScaffold(
        children: <Widget>[
          
          _medications.length > 0 
            ? _buildMedicationsList(context: context)
            : _buildNoMedicationsList(context: context),


        ],
      ),

      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add, size: 32,),
        onPressed: this._goAddMedication,
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      
    );
  }



  
  Widget _buildMedicationsList({ BuildContext context }) {
    Size screenSize = MediaQuery.of(context).size;

    return Container(
      padding: EdgeInsets.only(left: 16, right: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          
          SizedBox(height: 40,),
                                
          ..._medications.map((Medication med) {

            return MyMedicationCard(
              medication: med,
              onTap: () {},
              deleteCallBack: this._deleteMedication,
              showDeleteIcon: true,
            );
          }).toList(),

        ],
      ),
    );
  }// Widget _buildMedicationsList({ BuildContext context }) { .. }

  // show when user has no medicines
  Widget _buildNoMedicationsList({ BuildContext context }) {
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

            onTap: this._goViewWhy,
          ),

        ],
      ),
    );
  }// Widget _buildNoMedicationsList({ BuildContext context }) { .. }




  /*
   ** logic functs
   */


  void _goViewWhy() {

  }// void _goViewWhy() { .. }
  
  bool _deleteMedication({ Medication medication }) {

  }// bool _deleteMedication({ Medication medication }) { .. }
  
  void _goAddMedication() {

  }// void _goAddMedication() { .. }

}