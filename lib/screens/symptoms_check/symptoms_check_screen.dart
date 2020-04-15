import 'package:flutter/material.dart';
import 'package:kiloko/config/app_routes.dart';
import 'package:kiloko/config/app_utils.dart';
import 'package:kiloko/models/util_model.dart';
import 'package:kiloko/screens/symptoms_check/check_result.dart';
import 'package:kiloko/screens/symptoms_check/symptom_widget.dart';

class SymptomsCheckScreen extends StatefulWidget {
  @override
  _SymptomsCheckScreenState createState() => _SymptomsCheckScreenState();
}

class _SymptomsCheckScreenState extends State<SymptomsCheckScreen> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>(); 
  TextEditingController _symptomController = TextEditingController();

  // status of checking the symptoms
  bool _isOkay = true;
  bool _hasCheckResults = false;

  // symptoms of corona
  List<String> _coronaSymptoms = [
    'Fever', 
    'Coughing', 
    'Tiredness', 
    'Headache',
    'Difficulty Breathing'
  ];
  // symptoms user selected 
  List<String> _selectedSymptoms = [];
  // symptoms user added 
  List<String> _additionalSymptoms = [];

  bool _showResults = false;
  bool _isSafe = true;



  Color _backgroundColor() {
    if( !_showResults ) return Colors.grey[50];

    return _isSafe ? AppColors.secondary : AppColors.warning;
  }
  
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      
      // backgroundColor: _backgroundColor(),

      appBar: AppBar(
        title: Text('Symptons Check'),
        centerTitle: true,
        elevation: 0,
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          child: _showResults 
                  ? CheckResult(
                    goBack: this._goBack,
                    symptoms: this._coronaSymptoms,
                    selectedSymptoms: this._selectedSymptoms,
                    additionalSymptoms: this._additionalSymptoms,
                    isSafe: _isSafe,
                    onCtaPressed: this._goCheckHospitalsNearMe,
                  )
                  : _buildCheckSymptomsBody(context: context),
        ),
      ),
      
    );
  }// Widget build(BuildContext context) { .. }
  


  Widget _buildCheckSymptomsBody({ BuildContext context }) {

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          
          SizedBox(height: 48,),
          
          // instruction text
          Text(
            'Check the symptoms you have had recently',
            style: Theme.of(context).textTheme.subhead,
          ),

          SizedBox(height: 40,),

          // list of symptoms
          ..._coronaSymptoms.map((String symptom) {

            bool isSelected = _selectedSymptoms.contains(symptom);

            return SymptomWidget(
              onSelectSymptom: this._selectedSymptom, 
              symptom: symptom, 
              isSelected: isSelected
            );
          }).toList(),
          
          SizedBox(height: 40,),
          
          // additional symptoms
          Text(
            'Additional Symptoms',
            style: Theme.of(context).textTheme.body2.copyWith(
              fontWeight: FontWeight.w600
            ),
          ),
          
          SizedBox(height: 6,),

          _additionalSymptoms.length > 0 
            ? Text(
              'Tap on a symptom to delete it',
              style: Theme.of(context).textTheme.body1.copyWith(
                fontWeight: FontWeight.w400,
                fontStyle: FontStyle.italic,
                fontSize: 14
              ),
            ) : Container(),
          
          SizedBox(height: 12,),

          _additionalSymptoms.length > 0 
            ?
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                ..._additionalSymptoms.map((String symptom) {

                  return SymptomWidget(
                    symptom: symptom, 
                    isSelected: true, 
                    onSelectSymptom: this._selectedSymptom
                  );
                }).toList()
              ],
            )
            : Container(
              padding: EdgeInsets.only(top: 16, bottom: 12),
              child: Center(
                child: Text(
                  'When you add a symptom, it will appear here',
                  style: Theme.of(context).textTheme.body1.copyWith(
                    fontStyle: FontStyle.italic,
                    fontSize: 18
                  ),
                ),
              ),
            ),

          SizedBox(height: 40,),
          // input for any other symptoms which may not be listed
          Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget> [
                
                // symptom input
                TextFormField(
                  controller: _symptomController,
                  maxLines: 2,
                  maxLength: 100,
                  autocorrect: true,
                  decoration: InputDecoration(
                    hintText: 'dizziness',
                    labelText: 'Enter the symptom',
                    prefixIcon: Icon(Icons.local_hospital),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                      borderSide: BorderSide(),
                    ),
                  ),
                  
                  validator: (val) {
                    if (val.isEmpty) {
                      return 'Please enter the symptom';
                    }
                    if(val.length < 5) {
                      return 'Please enter a valid symptom';
                    }
                    return null;
                  },
                  onSaved: this._saveSymptom,
                ),

                SizedBox(height: 0,),

                // add sympotom button
                Center(
                  child: RaisedButton(
                    child: Text(
                      'Add Symptom',
                    ),
                    onPressed: this._addSymptom,
                    color: AppColors.white,
                    textColor: AppColors.primary,
                  ),
                ),

              ]
            ),
          ),

          SizedBox(height: 64,),
          
          // check button
          Center(
            child: FloatingActionButton.extended(
              icon: Icon(Icons.local_hospital),
              label: Text(
                'Check Symptoms',
              ),
              onPressed: ()=> this._checkSymptoms(context: context),
            ),
          ), 


        ],
      ),
    );
  }// idget _buildCheckSymptomsBody({ BuildContext context }) { .. }



  /*
   ** logic only functions
   */

  void _checkSymptoms({ BuildContext context }) {
    bool shouldVisitDoctor = UtilModel.shouldVisitDoctor(
      symptoms: this._coronaSymptoms,
      selectedSymptoms: _selectedSymptoms,
      extraSymptoms: _additionalSymptoms,
    );

    setState(() {
      _isSafe = !shouldVisitDoctor;
      _showResults = true;
    });
  }// void _checkSymptoms({ BuildContext context }) { .. }

  void _selectedSymptom({ @required String symptom, @required bool isSelected, @required BuildContext context }) {

    if( isSelected ) {
      setState(() {
       _selectedSymptoms.remove(symptom);
       _additionalSymptoms.remove(symptom); 
      });
      return;
    }

    bool isOriginal = _coronaSymptoms.contains(symptom);
    if( isOriginal ) {
      setState(() {
       _selectedSymptoms.add(symptom); 
      });
    } 

  }// void _selectedSymptom({ @required String symptom, @required bool isSelected, @required BuildContext context }) { .. }

  void _saveSymptom(String val) {
    setState(() {
     _additionalSymptoms.add(val); 
    });
    _symptomController.clear();
  }// void _saveSymptom(String val) { .. }

  void _addSymptom() {
      
    if( _formKey.currentState.validate() ) {
      _formKey.currentState.save();
    }
    
  }// void _saveSymptom(String val) { .. }


  void _goBack({ BuildContext context }) {
    Navigator.of(context).pushReplacementNamed(AppRoutes.HOME);
  }// void _goBack({ BuildContext context }) { .. }

  void _goCheckHospitalsNearMe({ BuildContext context }) {
    Navigator.of(context).pushNamed(AppRoutes.HOSPITALS_NEAR);
  }// void _goBack({ BuildContext context }) { .. }


}