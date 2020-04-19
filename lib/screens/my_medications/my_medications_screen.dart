import 'package:flutter/material.dart';
import 'package:kiloko/models/medication.dart';
import 'package:kiloko/providers/local_medication_provider.dart';
import 'package:kiloko/screens/my_medications/add_medication_widget.dart';
import 'package:kiloko/screens/my_medications/medication_list_widget.dart';
import 'package:kiloko/screens/my_medications/no_medication_widget.dart';
import 'package:kiloko/widgets/app_scaffold.dart';
import 'package:provider/provider.dart';



class MyMedicationsScreen extends StatefulWidget {
  @override
  _MyMedicationsScreenState createState() => _MyMedicationsScreenState();
}

class _MyMedicationsScreenState extends State<MyMedicationsScreen> {
  // List<Medication> _medications = [];
  List<Medication> _medications = [
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
  LocalMedicationProvider _localMedicationProvider;

  @override
  Widget build(BuildContext context) {
     Size screenSize = MediaQuery.of(context).size;
     _localMedicationProvider = Provider.of<LocalMedicationProvider>(context, listen: false);

    return Scaffold(

      appBar: AppBar(
        title: Text('My Medications'),
        centerTitle: true,
      ),

      body: AppScaffold(
        children: <Widget>[
          
          Consumer<LocalMedicationProvider> (
            builder: (BuildContext ctx, LocalMedicationProvider medicationProvider, _) {

              return medicationProvider.medications.length > 0 
                ? 
                MedicationsList(
                  medications: medicationProvider.medications,
                  deleteMedication: this._deleteMedication,
                )
                : 
                NoMedicationWidget(goViewWhy: this._goViewWhy,);

            },
          ),
          // _medications.length > 0 
          //   ? MedicationsList(
          //       medications: this._medications,
          //       deleteMedication: this._deleteMedication,
          //     )
          //   : NoMedicationWidget(goViewWhy: this._goViewWhy,),

        ],
      ),

      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add, size: 32,),
        onPressed: this._goAddMedication,
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      
    );
  }





  /*
   ** logic functs
   */


  void _goViewWhy() {

  }// void _goViewWhy() { .. }
  
  bool _deleteMedication({ Medication medication }) {
    _localMedicationProvider.delete(medication: medication);
  }// bool _deleteMedication({ Medication medication }) { .. }
  
  void _goAddMedication() {
    showDialog(
      context: context,
      builder: (BuildContext ctx)=> 
                  Dialog(
                    child: SingleChildScrollView(
                      child: AddMedicationWidget(),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                  ),
    );
  }// void _goAddMedication() { .. }

}