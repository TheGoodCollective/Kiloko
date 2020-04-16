import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:jiffy/jiffy.dart';
import 'package:kiloko/config/app_utils.dart';
import 'package:kiloko/models/condition.dart';
import 'package:kiloko/models/medication.dart';
import 'package:kiloko/screens/my_medications/my_medication_card.dart';
import 'package:kiloko/widgets/stepper_content_body.dart';



class MedicationsStep extends StatefulWidget {
  final List<Medication> medications;
  
  MedicationsStep({this.medications});

  @override
  _MedicationsStepState createState() => _MedicationsStepState();
}

class _MedicationsStepState extends State<MedicationsStep> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _controller = TextEditingController();
  TextEditingController _reasonController = TextEditingController();
  
  TextEditingController _timeInputController = TextEditingController();
  FocusNode _timeInputFocusNode = FocusNode();
  
  Medication _medication;
  List<Medication> _medications = [];
  
  @override
  void initState() {
    super.initState();
    
    _medication = Medication( name: '' );
    this._medications = widget.medications;
  }// void initState() { .. }


  @override
  Widget build(BuildContext context) {
    return StepperContentBody(
      horizontalPadding: 20,
      children: <Widget>[

        Text('Add any medication that you are currently taking'),
        SizedBox(height: 32),


        // list of added features
        this._medications.length > 0
         ?
          _buildMedicationList(context: context)
         :
          _buildEmptyMedicationsList(context: context),
        
        SizedBox(height: 48,),
        // add medication form
        _buildMedicationForm(context: context),
        
      ],
    );
    // return Container();
  }// Widget build(BuildContext context) { .. }

  
  
  // widget to show when no medications have been added
  Widget _buildEmptyMedicationsList({ BuildContext context}) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Container(
      margin: EdgeInsets.only(left: screenWidth/5, bottom: 60, top: 24),
      child: Row(
        children: <Widget>[
           
          Center(
            child: Text(
              'When you add a medication it will appear here',
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


  
  Widget _buildMedicationList({ BuildContext context }) {

    return Container(
      margin: EdgeInsets.only(bottom: 24,),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          
          ..._medications.map((Medication medication) {

            return MyMedicationCard(
              medication: medication,
              onTap: (){},
              deleteCallBack: this._deleteMedication,
              showDeleteIcon: true,
            );

          }).toList()

        ],
      ),
    );
  }// Widget _buildTagList({ BuildContext context }) { .. }

  
  Widget _buildMedicationForm({ BuildContext context }) {

    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[

          Text(
            'Add any medications',
            style: Theme.of(context).textTheme.subhead.copyWith(
              fontSize: 20
            ),
          ),
          SizedBox(height: 28,),

          // medication name
          TextFormField(
            keyboardType: TextInputType.text,
            autofocus: false,
            decoration: InputDecoration(
              labelText: 'Enter medication name',
              prefixIcon: Icon(Icons.info_outline),
              hintText: 'Brufen',
            ),
            style: Theme.of(context).textTheme.body1.copyWith(
              fontSize: 18,
            ),
            validator: this._nameValidator,
            onSaved: this._nameSaver,
            controller: _controller,
          ),

          SizedBox(height: 16),

            
          // condition from when
          TextFormField(
            keyboardType: TextInputType.text,
            autofocus: false,
            decoration: InputDecoration(
              labelText: 'When did you begin taking',
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


          SizedBox(height: 20),
          Text(
              'Optional',
              style: Theme.of(context).textTheme.body1.copyWith(
                color: AppColors.secondary,
                fontStyle: FontStyle.italic,
                fontSize: 16,
              ),
          ),
          SizedBox(height: 8),
          // reason
          TextFormField(
            keyboardType: TextInputType.text,
            autofocus: false,
            maxLength: 40,
            maxLines: 2,
            decoration: InputDecoration(
              labelText: 'Reason',
              prefixIcon: Icon(Icons.info_outline),
              hintText: 'Headache',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: BorderSide(),
              ),
            ),
            style: Theme.of(context).textTheme.body1.copyWith(
              fontSize: 18,
            ),
            validator: this._reasonValidator,
            onSaved: this._reasonSaver,
            controller: _reasonController,  
          ),

          SizedBox(height: 28),
          
          // add button
          Row(
            children: <Widget>[
              Expanded(
                flex: 1,
                child: Container(
                  height: 48,
                  child: RaisedButton(
                    child: Text(
                      'Add Medication',
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                    onPressed: ()=> this._addMedication(context: context),
                    
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
    );
  }// Widget _buildMedicationForm({ BuildContext context }) { .. }



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
          setState(()=> _medication.fromWhen = date);
          _timeInputController.text = Jiffy(_medication.fromWhen).yMMMd;
          _timeInputFocusNode.nextFocus();
          _timeInputController.clear();
        }, 
        currentTime: DateTime.now(), 
        locale: LocaleType.en
      );
   }// _showDatePicker() { .. }





  /*
   ** logic functions
   */

  void _addMedication({ BuildContext context }) {
    
    if( _formKey.currentState.validate() ) {
      _formKey.currentState.save();

      setState(() {
        _medications.add(this._medication);
        _medication = Medication(name: '');
      });
    }
    
  }// void _addMedication({ BuildContext context }) { .. }

  String _nameValidator(String val) {
    if( val.trim().isEmpty ) return 'Enter a name';
    return null;
  }// String _nameValidator(String val) { .. }

  String _reasonValidator(String val)=> null;

  void _nameSaver(String val) {
    setState(()=> this._medication.name = val.trim() );
    _controller.clear();
  }// _nameSaver(String val) { .. }
  
  void _reasonSaver(String val) {
    setState(()=> this._medication.reason = val.trim() );
    _reasonController.clear();
  }// _reasonSaver(String val) { .. }
  
  String _conditionNameValidator(String val) {
    // if( val.isEmpty ) return 'Enter a condition name';
    return null;
  }// String _descriptionValidator(String val) { .. }

  void _conditionNameSaver(String val) {
    setState(()=> this._medication.condition.name = val );
    _controller.clear();
  }// _descriptionSaver(String val) { .. }

  void _deleteMedication({ Medication medication }) {
    setState(() {
      this._medications = this._medications.where(
        (Medication medicatn)=> medicatn.name != medication.name
      ).toList();
    });
  }// void _deleteCondition({ String condition }) { .. }

}