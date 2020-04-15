import 'package:flutter/material.dart';
import 'package:kiloko/config/app_routes.dart';
import 'package:kiloko/config/app_utils.dart';
import 'package:kiloko/models/corona_case.dart';
import 'package:kiloko/screens/i_have_corona/yet_to_test.dart';



class IHaveCoronaScreen extends StatefulWidget {
  @override
  _IHaveCoronaState createState() => _IHaveCoronaState();
}

class _IHaveCoronaState extends State<IHaveCoronaScreen> with TickerProviderStateMixin {
  bool _hasReported = false;
  String _hasTestedResponse = 'Yes';
  bool _showNotYetTestedWidget = false;
  CoronaCase _coronaCase = new CoronaCase();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  AnimationController _animationController;
  Animation<double> _scaleAnimation;


  @override
  void initState() {
    super.initState();
    
    _animationController = AnimationController(
      duration: Duration(seconds: 2), vsync: this,
    );

    _scaleAnimation = Tween<double> (begin: 0.0, end: 1.0).animate(
      CurvedAnimation( 
        parent: _animationController, curve: Curves.bounceIn 
      ),
    );

  }


  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    return Scaffold(

      backgroundColor: _hasReported || _showNotYetTestedWidget ? AppColors.secondary : Colors.grey[50],
      appBar: _buildAppBar(context: context),

      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
               
              SizedBox(height: 32,),

              Center(child: _buildCoronaImage(context: context)),

              SizedBox(height: 20,),

              _buildBody(context: context),


            ],
          ),
        ),
      ),
      
    );
  }// Widget build(BuildContext context) { .. }

  Widget _buildAppBar({ BuildContext context }) {

    if( this._showNotYetTestedWidget ) {
      return _buildHasReportedAppBar(context: context, color: AppColors.warning);
    }

    return _hasReported 
        ? _buildHasReportedAppBar(context: context) 
        : _buildHasYetToReportAppBar(context: context);
  }

  Widget _buildBody({ BuildContext context }) {

    if( this._showNotYetTestedWidget ) {
      return _buildNotTestedWidget(context: context);
      // return YetToTest(goHome: this._goHome, goCheckSymptoms: this._goCheckSymptoms,);
    }

    return _hasReported 
               ? _buildReportSuccessBody(context: context)
               : _buildReportBody(context: context);
  }

  
  Widget _buildHasYetToReportAppBar({ BuildContext context }) {

    return AppBar(
      title: Text('I have Corona'),
      centerTitle: true,
    );
  }// Widget _buildHasYetToReportAppBar({ BuildContext context }) { .. }

  Widget _buildHasReportedAppBar({ BuildContext context, Color color }) {
    Size screenSize = MediaQuery.of(context).size;

    // return Container(
    //   width: screenSize.width,
    //   height: 200,
    //   padding: EdgeInsets.symmetric(horizontal: 12),
    //   color: color ?? AppColors.secondary,
    //   child: Center(
    //     child: Text(
    //       'I have Corona',
    //     ),
    //   ),
    // );
    
    return AppBar(
      title: Text('I have Corona'),
      centerTitle: true,
      elevation: 0,
    );
  }// Widget _buildHasReportedAppBar({ BuildContext context }) { .. }
  

  Widget _buildReportBody({ BuildContext context }) { 
    Size screenSize = MediaQuery.of(context).size;  

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: screenSize.width/10,
        vertical: 32
      ),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            
            // if has been to hospital
            Text(
              'Have you been tested?',
              style: Theme.of(context).textTheme.subhead,
            ),
            SizedBox(height: 8,),
            RadioListTile(
              groupValue: _hasTestedResponse,
              title: Text('Yes'),
              value: 'Yes',
              onChanged: (val) => setState(()=> this._hasTestedResponse = val),
            ),
            RadioListTile(
              groupValue: _hasTestedResponse,
              title: Text('No'),
              value: 'No',
              onChanged: (val) => setState(()=> this._hasTestedResponse = val),
            ),
            
            SizedBox(height: 20,),
            
            // hospital name
            TextFormField(
              keyboardType: TextInputType.text,
              autofocus: false,
              decoration: InputDecoration(
                labelText: 'Which hospital was testing done',
                prefixIcon: Icon(Icons.location_city),
                hintText: 'Aga Khan Hospital Johannesburg',
              ),
              onSaved: (String val) {
                if( val.trim().isEmpty ) return; 
                this._coronaCase.hospital = val;
              },
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            
            SizedBox(height: 20,),

            // when
            TextFormField(
              keyboardType: TextInputType.datetime,
              autofocus: false,
              initialValue: DateTime.now().toString(),
              decoration: InputDecoration(
                labelText: 'When was testing done',
                prefixIcon: Icon(Icons.calendar_today),
                hintText: '21/04/2020',
              ),
              onSaved: (String val) {
                if( val.trim().isEmpty ) return; 
                this._coronaCase.hospital = val;
              },
              style: TextStyle(
                fontSize: 20,
              ),
            ),

            SizedBox(height: 48,),
            
            // report cta
            Row(
              children: <Widget>[

                Expanded(
                  child: FloatingActionButton.extended(
                    label: Text(
                      'Report Case'
                    ),
                    onPressed: ()=> this._submitCase(context: context),
                  ),
                ),

              ],
            ),          


          ],
        ),
      ),
    );
  }// Widget _buildReportBody({ BuildContext context }) { .. }


  // show after submitting the case
  Widget _buildReportSuccessBody({ BuildContext context }) {   
    Size screenSize = MediaQuery.of(context).size;

    return Container(
      width: screenSize.width,
      padding: EdgeInsets.only(left: 24, right: 24),
      color: AppColors.secondary,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[

          Center(
            child: Text(
              'Thank you for reporting',
              style: Theme.of(context).textTheme.title,
            ),
          ),

          SizedBox(height: 20,),

          Text(
            'Your case has been reported successfully. We wish you a quick recovery',
            style: Theme.of(context).textTheme.body1,
            textAlign: TextAlign.center,
          ),

          SizedBox(height: 60,),
          
          Center(
            child: FloatingActionButton.extended(
              label: Text('Go Back'),
              onPressed: ()=> this._goHome(context: context),
            ),
          ),
         
 
        ],
      ),
    );
  }// Widget _buildReportSuccessBody({ BuildContext context }) { .. }


  // widget to show when user has not been tested
  Widget _buildNotTestedWidget({ BuildContext context }) {
    Size screenSize = MediaQuery.of(context).size;

    return Container(
      width: screenSize.width,
      color: AppColors.secondary,
      padding: EdgeInsets.only(left: 24, right: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[

          Center(
            child: Text(
              'Get tested first',
              style: Theme.of(context).textTheme.title,
            ),
          ),

          SizedBox(height: 20,),

          Text(
            'Check whether your symptoms match those of corona and ascertain whether you need to visit a doctor',
            style: Theme.of(context).textTheme.body1,
            textAlign: TextAlign.center,
          ),

          SizedBox(height: 60,),
          
          Center(
            child: FloatingActionButton.extended(
              label: Text('Check Symptoms'),
              onPressed: ()=> this._goCheckSymptoms(context: context),
            ),
          ),

          SizedBox(height: 60,),
         
          Center(
            child: FlatButton(
              child: Text('Go Back'),
              onPressed: ()=> this._goHome(context: context),
            ),
          ),

        ],
      ),
    ); 
  }// Widget _buildNotTestedWidget({ BuildContext context }) { .. }


  Widget _buildCoronaImage({ BuildContext context }) {
    Size screenSize = MediaQuery.of(context).size;

    if( _showNotYetTestedWidget ) {

      return CircleAvatar(
        radius: screenSize.width/4,
        backgroundImage: AssetImage(
          AppImages.corona
        ),
      );
    }
   
    if( !this._hasReported ) {

      return CircleAvatar(
        radius: screenSize.width/5,
        backgroundImage: AssetImage(
          AppImages.corona
        ),
      ); 
    }

    return CircleAvatar(
      radius: screenSize.width/4,
      backgroundImage: AssetImage(
        AppImages.corona
      ),
    );
  }// Widget _buildCoronaImage({ BuildContext context }) { .. }


  
  // logic 

  // submit a case
  void _submitCase({ BuildContext context }) {
    print('_submitCase');
    setState(()=> this._showNotYetTestedWidget = false );
    if( _hasTestedResponse == 'No' ) { print('test first');
      setState(()=> this._showNotYetTestedWidget = true );
      return;
    }

    if( this._formKey.currentState.validate() ) {
      this._formKey.currentState.save();
    } else {
      return;
    }

    print('report');
  }// void _submitCase({ BuildContext context }) { .. }

  void _goHome({ BuildContext context }) {
    Navigator.of(context).pushReplacementNamed(AppRoutes.HOME);
  }// void _goHome({ BuildContext context }) { .. }

  void _goCheckSymptoms({ BuildContext context }) {
    Navigator.of(context).pushNamed(AppRoutes.SYMPTOM_CHECK);
  }// void _goCheckSymptoms({ BuildContext context }) { .. }


}
