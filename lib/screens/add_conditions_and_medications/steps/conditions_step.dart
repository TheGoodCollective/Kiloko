import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:jiffy/jiffy.dart';
import 'package:kiloko/config/app_utils.dart';
import 'package:kiloko/models/condition.dart';
import 'package:kiloko/models/medication.dart';
import 'package:kiloko/widgets/stepper_content_body.dart';




class ConditionsStep extends StatefulWidget {
  final List<Condition> conditions;
  
  ConditionsStep({this.conditions});

  @override
  _ConditionsStepState createState() => _ConditionsStepState();
}

class _ConditionsStepState extends State<ConditionsStep> {
  final _formKey = GlobalKey<FormState>();
  final _medFormKey = GlobalKey<FormState>();
  TextEditingController _controller = TextEditingController();
  TextEditingController _timeInputController = TextEditingController();
  FocusNode _timeInputFocusNode = FocusNode();
  TextEditingController _addConditionMedicationController = TextEditingController();
  
  Condition _condition;
  List<Condition> _conditions = [];
  
  @override
  void initState() {
    super.initState();

    _condition = Condition(name: '', medications: []);
    this._conditions = widget.conditions;
  }// void initState() { .. }


  @override
  Widget build(BuildContext context) {
    return StepperContentBody(
      horizontalPadding: 20,
      children: <Widget>[

        Text(
          'Add any conditions that you may be having'
        ),
        SizedBox(height: 32),


        // list of added features
        this._conditions.length > 0
         ?
          _buildConditionList(context: context)
         :
          Center(
            child: _buildEmptyConditionsList(context: context)
          ),

        SizedBox(height: 48,),
        // add condition form
        _addConditionForm(context: context),
        
        
      ],
    );
    // return Container();
  }// Widget build(BuildContext context) { .. }

  
  
  // widget to show when no conditions have been added
  Widget _buildEmptyConditionsList({ BuildContext context}) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Container(
      margin: EdgeInsets.only(left: screenWidth/5, bottom: 60, top: 24),
      child: Row(
        children: <Widget>[
           
          Center(
            child: Text(
              'When you add a condition it will appear here',
              style: Theme.of(context).textTheme.body1.copyWith(
                fontSize: 16,
                fontStyle: FontStyle.italic,
              ),
              textAlign: TextAlign.center,
            ),
          ),

        ],
      ),
    );
  }// Widget _buildEmptyConditionList({ BuildContext context}) { .. }


  
  Widget _buildConditionList({ BuildContext context }) {

    return Container(
      margin: EdgeInsets.only(bottom: 24,),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[

          Text(
            'Tap on a condition to delete it',
            style: Theme.of(context).textTheme.body1.copyWith(
              fontStyle: FontStyle.italic,
              fontSize: 16,
            ),
          ),

          SizedBox(height: 18,),
          
          ..._conditions.map((Condition condition) {

            return ConditionCard(
                      condition: condition, 
                      deleteConditionCallback: this._deleteCondition,
            );
          }).toList()

        ],
      ),
    );
  }// Widget _buildTagList({ BuildContext context }) { .. }
  

  Widget _addConditionForm({ BuildContext context }) {

    return Container(
      padding: EdgeInsets.symmetric(vertical: 16, horizontal: 20),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[

            Text(
              'Add any conditions',
              style: Theme.of(context).textTheme.subhead.copyWith(
                fontSize: 20
              ),
            ),
            SizedBox(height: 28,),

            // condition name
            TextFormField(
              keyboardType: TextInputType.text,
              autofocus: false,
              decoration: InputDecoration(
                labelText: 'Enter condition name',
                prefixIcon: Icon(Icons.info_outline),
                hintText: 'Diabetes',
              ),
              style: Theme.of(context).textTheme.body1.copyWith(
                fontSize: 18,
              ),
              validator: this._nameValidator,
              onSaved: this._nameSaver,
              controller: _controller,
            ),

            SizedBox(height: 24),
            
            // condition from when
            TextFormField(
              keyboardType: TextInputType.text,
              autofocus: false,
              decoration: InputDecoration(
                labelText: 'When did the condition begin',
                prefixIcon: Icon(Icons.info_outline),
                hintText: '24/04/2020',
              ),
              style: Theme.of(context).textTheme.body1.copyWith(
                fontSize: 18,
              ),
              onTap: this._showDatePicker,
              controller: _timeInputController,
              focusNode: _timeInputFocusNode,
            ),

            SizedBox(height: 32),
            
            RichText(
              text:  TextSpan(
                style: Theme.of(context).textTheme.body1,
                children: [
                  
                  TextSpan(
                    text: 'Medicines taken'
                  ),
                  TextSpan(
                    text: ' (optional)',
                    style: Theme.of(context).textTheme.body1.copyWith(
                      fontStyle: FontStyle.italic,
                      color: AppColors.primary,
                    ),
                  ),

                ]
              ),
            ),
            
            SizedBox(height: 16,),

            // condition medicines
            _condition.medications.length > 0
              ? _buildMedicinesList(context: context)
              : _buildNoMedicinesList(context: context),
            
            SizedBox(height: 32),
            
            // medicine name
            Container(
              child: Form(
                key: _medFormKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[

                    TextFormField(
                      keyboardType: TextInputType.text,
                      autofocus: false,
                      decoration: InputDecoration(
                        labelText: 'Enter medicine name',
                        prefixIcon: Icon(Icons.info_outline),
                        hintText: 'Piriton',
                      ),
                      style: Theme.of(context).textTheme.body1.copyWith(
                        fontSize: 18,
                      ),
                      validator: this._conditionMedicineNameValidator,
                      onSaved: this._conditionMedicineNameSaver,
                      controller: _addConditionMedicationController,
                    ),
                    
                    SizedBox(height: 16,),

                    Center(
                      child: FlatButton(
                        child: Text('Add Medicine'),
                        onPressed: this._addConditionMedication,
                      ),
                    ),

                  ],
                )
              ),
            ),


            SizedBox(height: 72),
            
            // add button
            Row(
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: Container(
                    height: 48,
                    child: RaisedButton(
                      child: Text(
                        'Add Condition',
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                      onPressed: ()=> this._addCondition(context: context),
                      
                      elevation: 4,
                      color: Colors.cyan,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                    ),
                  ),
                ),
              ],
            ),

          ],
        ),
      ),
    );
  }// Widget _addConditionForm({ BuildContext context }) { .. }

  Widget _buildMedicinesList({ BuildContext context }) {

    return Container(
      child: Wrap(
        children: <Widget>[
          
          ..._condition.medications.map((Medication med) {

            return _buildMedicineCard(medication: med);
          }).toList(),

        ],
      )
    );
  }// Widget _buildMedicinesList({ BuildContext context }) { .. }
  
  Widget _buildNoMedicinesList({ BuildContext context }) {

    return Center(
      child: Text(
        'When you add medicines they will appear here',
        style: Theme.of(context).textTheme.body1.copyWith(
          fontSize: 18,
          fontStyle: FontStyle.italic,
        ),
      ),
    );
  }// Widget _buildNoMedicinesList({ BuildContext context }) { .. }

  Widget _buildMedicineCard({ Medication medication }) {

    return Container(
      margin: EdgeInsets.only(right: 12),
      child: Chip(
        label: Text(
          medication.name,
        ),
        deleteIcon: Icon(Icons.close),
        onDeleted: ()=> 
          this._deleteConditionMedication(medication: medication),
      ),
    );
  }// Widget _buildMedicineCard({ Medication medication }) { .. }

   _showDatePicker() {

     return DatePicker.showDatePicker(context,
        showTitleActions: true,
        minTime: DateTime(2020, 3, 5),
        maxTime: DateTime(2021, 6, 7), 
        onChanged: (date) {
          print('change $date');
          // _condition.fromWhen = date;
        }, 
        onConfirm: (date) {
          print('confirm $date');
          setState(()=> _condition.fromWhen = date);
          _timeInputController.text = Jiffy(_condition.fromWhen).yMMMd;
          _timeInputFocusNode.nextFocus();
        }, 
        currentTime: DateTime.now(), 
        locale: LocaleType.en
      );
   }// _showDatePicker() { .. }



  /*
   ** logic functions
   */

  // add a condition
  void _addCondition({ BuildContext context }) {
    
    if( _formKey.currentState.validate() ) {
      _formKey.currentState.save();
      _controller.clear();

      setState(() {
        _conditions.add(this._condition);
        _condition = Condition(name: '', medications: []);
      });
    }// if( _formKey.currentState.validate() ) { .. }
    
  }// void _addCondition({ BuildContext context }) { .. }

  String _nameValidator(String val) {
    if( val.isEmpty ) return 'Enter a name';
    return null;
  }// String _nameValidator(String val) { .. }

  void _nameSaver(String val) {
    setState(()=> this._condition.name = val );
    _controller.clear();
  }// _nameSaver(String val) { .. }

  String _conditionMedicineNameValidator(String val) {
    if( val.trim().isEmpty ) return 'Enter a medicine name';
    return null;
  }// String _conditionMedicineNameValidator(String val) { .. }

  void _conditionMedicineNameSaver(String val) {
    setState(() {
      this._condition.medications.add(
        Medication(name: val)
      );
    });
    _addConditionMedicationController.clear();
  }// _conditionMedicineNameSaver(String val) { .. }

  // delete condition
  void _deleteCondition({ Condition condition }) {
    setState(() {
      this._conditions = this._conditions.where(
        (Condition conditn)=> conditn.name != condition.name
      ).toList();
    });
  }// void _deleteCondition({ String condition }) { .. }



  void _addConditionMedication() { print('_addConditionMedication >>>');
    
    if( _medFormKey.currentState.validate() ) {
      _medFormKey.currentState.save();
      _addConditionMedicationController.clear();
    }
  }// void _addConditionMedication({ Medication medication }) { .. }
  void _deleteConditionMedication({ Medication medication }) {
    List<Medication> newMedications = this._condition.medications.where(
      (Medication med)=> med.name != medication.name
    ).toList();
    setState(()=> this._condition.medications = newMedications);
  }// void _deleteConditionMedication({ Medication medication }) { .. }

}

class ConditionCard extends StatelessWidget {
  final Condition condition;
  final Function deleteConditionCallback;

  ConditionCard({
    this.condition, this.deleteConditionCallback,
  });
  
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        condition.name,
        style: Theme.of(context).textTheme.body1,
        overflow: TextOverflow.visible,
      ),
      trailing: IconButton(
        icon: Icon(Icons.delete_outline), 
        onPressed: ()=> this.deleteConditionCallback(condition: condition)
      ),
    );
  }
}
