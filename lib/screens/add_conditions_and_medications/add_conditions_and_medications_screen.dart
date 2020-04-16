import 'package:flutter/material.dart';
import 'package:kiloko/models/condition.dart';
import 'package:kiloko/models/medication.dart';
import 'package:kiloko/screens/add_conditions_and_medications/steps/conditions_step.dart';
import 'package:kiloko/screens/add_conditions_and_medications/steps/medications_step.dart';
import 'package:kiloko/widgets/app_scaffold.dart';


class AddConditionsAndMedicationsScreen extends StatefulWidget {
  @override
  _AddConditionsAndMedicationsScreenState createState() => _AddConditionsAndMedicationsScreenState();
}

class _AddConditionsAndMedicationsScreenState extends State<AddConditionsAndMedicationsScreen> {
  List<Medication> _medications = [];
  List<Condition> _conditions = [];

  int _currentStep = 0;

  _AddConditionsAndMedicationsScreenState();

  @override
  void initState() { 
    super.initState();
  }// void initState() { .. }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: Text('Add Device'),
        centerTitle: true,
      ),
      
      body: Stepper(
        currentStep: _currentStep,
        onStepContinue: this._onStepContinue,
        onStepCancel: this._onStepCancel,
        type: StepperType.horizontal,
        steps: [
          
          Step(
            isActive: _currentStep==0,
            state: _currentStep==0 ? StepState.editing : StepState.indexed,
            title: Text(
              'Conditions',
              style: Theme.of(context).textTheme.body1,
            ), 
            content: Container(
              child: ConditionsStep(conditions: _conditions,),
            ),
          ),
          
          Step(
            isActive: _currentStep==1,
            state: _currentStep==1 ? StepState.editing : StepState.indexed,
            title: Text(
              'Medications',
              style: Theme.of(context).textTheme.body1,
            ), 
            content: Container(
              child: MedicationsStep(medications: _medications,),
            ),
          ),

         ],
         controlsBuilder: (BuildContext context,
                  {VoidCallback onStepContinue, VoidCallback onStepCancel}) {
      
            return Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  
                  _currentStep == 0
                    ?
                    Container()
                    :
                    RaisedButton(
                    onPressed: this._onStepCancel,
                    child: const Text('Previous'),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                      side: BorderSide(
                        color: Colors.cyan,
                      ),
                    ),
                    color: Colors.white,
                    textColor: Colors.cyan,
                    elevation: 0,
                  ),
                  
                  RaisedButton(
                    onPressed: this._onStepContinue,
                    child: const Text('Next'),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                    color: Colors.cyan,
                  ),

                ],
              ),
            );

        },
      ),
      
    );
  }// Widget build(BuildContext context) { .. }

  void _onStepContinue() {
    if (_currentStep >= 4) return;
    setState(()=> _currentStep += 1 );
  }// void _onStepContinue() { .. }

  void _onStepCancel() {
    if (_currentStep <= 0) return;
    setState(()=> _currentStep -= 1 );
  }// void _onStepCancel() { .. }




}