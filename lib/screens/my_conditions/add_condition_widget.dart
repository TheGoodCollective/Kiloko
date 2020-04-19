import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:jiffy/jiffy.dart';
import 'package:kiloko/config/app_utils.dart';
import 'package:kiloko/models/condition.dart';
import 'package:kiloko/models/medication.dart';
import 'package:kiloko/providers/local_condition_provider.dart';
import 'package:provider/provider.dart';




class AddConditionWidget extends StatefulWidget {
  @override
  _AddConditionWidgetState createState() => _AddConditionWidgetState();
}

class _AddConditionWidgetState extends State<AddConditionWidget> {
   final _formKey = GlobalKey<FormState>();
  final _medFormKey = GlobalKey<FormState>();
  TextEditingController _controller = TextEditingController();
  TextEditingController _timeInputController = TextEditingController();
  FocusNode _timeInputFocusNode = FocusNode();
  TextEditingController _addConditionMedicationController = TextEditingController();
  
  Condition _condition;
  LocalConditionProvider _localConditionProvider;

  @override
  void initState() {
    super.initState();

    _condition = Condition(name: '', medications: []);
  }// void initState() { .. }


  
  @override
  Widget build(BuildContext context) {
    _localConditionProvider = Provider.of<LocalConditionProvider>(context, listen: false);

    return Container(
      padding: EdgeInsets.only( 
        left: 32, right: 32, top: 48, bottom: 60 ),
      child: Column(
        children: <Widget>[
          
          Align(
            alignment: Alignment.center,
            child: 
            Text(
              'Add Condition',
              style: Theme.of(context).textTheme.subtitle,
            ),
          ),
          SizedBox(height: 48),
           
          Text('Add any condition that you currently have'),
          SizedBox(height: 24),

          // add condition form
          _addConditionForm(context: context),
        

        ],
      ),
    );
  }


  
  Widget _addConditionForm({ BuildContext context }) {

    return Container(
      padding: EdgeInsets.symmetric(vertical: 16, horizontal: 20),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[

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

            SizedBox(height: 40),
            
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
            
            SizedBox(height: 20,),

            // condition medicines
            _condition.medications.length > 0
              ? _buildMedicinesList(context: context)
              : _buildNoMedicinesList(context: context),
            
            SizedBox(height: 48),
            
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
                    child: 
                    
                    Consumer<LocalConditionProvider>(
                      builder: (BuildContext ctx, LocalConditionProvider providr, _) {
                        
                        return providr.isLoading 
                         ?
                          FloatingActionButton.extended(
                            icon: CircularProgressIndicator(),
                            label: Text(
                              'Saving...'
                            ),
                            onPressed: (){},
                          )
                         :
                         RaisedButton(
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
                        );

                      },
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
          style: Theme.of(context).textTheme.body1.copyWith(
            fontSize: 16
          ),
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

      this._localConditionProvider.add(condition: this._condition);
      setState(() {
        _condition = Condition(name: '', medications: []);
      });
      
      Navigator.of(context).pop();
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