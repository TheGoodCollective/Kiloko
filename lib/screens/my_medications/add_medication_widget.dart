import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:jiffy/jiffy.dart';
import 'package:kiloko/config/app_utils.dart';
import 'package:kiloko/models/medication.dart';
import 'package:kiloko/providers/local_medication_provider.dart';
import 'package:provider/provider.dart';


class AddMedicationWidget extends StatefulWidget {
  
  @override
  _AddMedicationWidgetState createState() => _AddMedicationWidgetState();
}

class _AddMedicationWidgetState extends State<AddMedicationWidget> {
  Medication _medication = Medication(name: '');
  final _formKey = GlobalKey<FormState>();
  TextEditingController _controller = TextEditingController();
  TextEditingController _reasonController = TextEditingController();
  
  TextEditingController _timeInputController = TextEditingController();
  FocusNode _timeInputFocusNode = FocusNode();
  
  LocalMedicationProvider _localMedicationProvider;

  
  @override
  Widget build(BuildContext context) {
    _localMedicationProvider = Provider.of<LocalMedicationProvider>(context);
    
    return Container(
      padding: EdgeInsets.only( 
        left: 32, right: 32, top: 48, bottom: 60 ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[

          Align(
            alignment: Alignment.center,
            child: 
            Text(
              'Add medication',
              style: Theme.of(context).textTheme.subtitle,
            ),
          ),
          SizedBox(height: 48),
           
          Text('Add any medication that you are currently taking'),
          SizedBox(height: 24),

          // add medication form
          Container(
            child: _buildMedicationForm(context: context)
          ),
        

        ],
      ),
    );
  }



  Widget _buildMedicationForm({ BuildContext context }) {

    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[

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

          SizedBox(height: 24),

            
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


          SizedBox(height: 24),
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
                  child: 
                  
                  Consumer<LocalMedicationProvider>(
                    builder: (BuildContext ctx, LocalMedicationProvider medicationProvider, _) {
                      
                      return medicationProvider.isLoading
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
                        );


                    },
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
        }, 
        onConfirm: (date) {
          print('confirm $date');
          setState(()=> this._medication.fromWhen = date);
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

  void _addMedication({ BuildContext context }) async {
    
    if( _formKey.currentState.validate() ) {
      _formKey.currentState.save();
      
      print('_medication.fromWhen ${_medication.fromWhen}');

      _localMedicationProvider.add(medication: this._medication);
      setState(() {
        _medication = Medication(name: '');
      });

      Navigator.of(context).pop();
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
  

}