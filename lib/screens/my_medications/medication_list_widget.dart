import 'package:flutter/material.dart';
import 'package:kiloko/models/medication.dart';
import 'package:kiloko/screens/my_medications/my_medication_card.dart';


class MedicationsList extends StatelessWidget {
  final List<Medication> medications;
  final Function deleteMedication;

  MedicationsList({ this.medications, this.deleteMedication });

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    return Container(
      padding: EdgeInsets.only(left: 16, right: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          
          SizedBox(height: 40,),
                                
          ...medications.map((Medication med) {

            return MyMedicationCard(
              medication: med,
              onTap: () {},
              deleteCallBack: this.deleteMedication,
              showDeleteIcon: true,
            );
          }).toList(),

        ],
      ),
    );
  }// Widget build(BuildContext context) { .. }
}