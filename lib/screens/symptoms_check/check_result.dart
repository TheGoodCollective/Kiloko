import 'package:flutter/material.dart';
import 'package:kiloko/config/app_utils.dart';
import 'package:kiloko/models/util_model.dart';
import 'package:kiloko/screens/symptoms_check/symptom_widget.dart';


class CheckResult extends StatelessWidget {
  final Function goBack;
  final Function onCtaPressed;
  final List<String> symptoms;
  final List<String> selectedSymptoms;
  final List<String> additionalSymptoms;
  final bool isSafe;

  CheckResult({
    this.goBack, this.symptoms, this.selectedSymptoms,
    this.additionalSymptoms,
    this.isSafe, this.onCtaPressed,
  });


  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          
          SizedBox(height: 48,),
          
          // text
          selectedSymptoms.length > 0
            ?
            Text(
              'Symptoms you currently have',
              style: Theme.of(context).textTheme.subhead,
            )
            : Container(),

          SizedBox(height: 20,),

          selectedSymptoms.length > 0
           ? 
           Column(
             crossAxisAlignment: CrossAxisAlignment.start,
             children: <Widget>[
               ...selectedSymptoms.map((String symptom) {

                return SymptomWidget(
                    symptom: symptom,
                    isSelected: true,
                    onSelectSymptom: (){},
                  );
                }).toList(),
             ],
           )
           :
           Container(
             child: Center(
               child: Text(
                 'Yaay, You have no symptoms',
                 style: Theme.of(context).textTheme.body2.copyWith(
                   color: AppColors.success,
                   fontSize: 24,
                 ),
               ),
             ),
           ),
          
          isSafe 
            ? SizedBox(height: screenSize.height/6,) 
            : SizedBox(height: 80,),

          // recommendation
          Center(
            child: Text(
              'Recommendation',
              style: Theme.of(context).textTheme.title.copyWith(
                color: AppColors.primary
              ),
            ),
          ),
          
          SizedBox(height: 56,),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                
                isSafe 
                  ? Icon(
                    Icons.thumb_up,
                    size: 28,
                    color: isSafe ? AppColors.success : AppColors.warning,
                  ) 
                  : Icon(
                    Icons.warning,
                    size: 28,
                    color: isSafe ? AppColors.success : AppColors.warning,
                  ),
                
                SizedBox(width: 16,),

                Text(
                  isSafe ? 'You\'re Safe' : 'Possible Exposure',
                  style: Theme.of(context).textTheme.subhead.copyWith(
                    color: isSafe ? AppColors.success : AppColors.warning,
                  ),
                )

              ],
          ),
          
          SizedBox(height: 24,),

          Center(
            child: Text(
              isSafe 
               ?
               'You are safe. Keep observing the safety recommendations to avoid getting exposed.'
               :
               'We\'re sorry. You need to visit a doctor to check for exposure. Kiloko community is here with you.',
              style: Theme.of(context).textTheme.body1,
              textAlign: TextAlign.center,
            ),
          ),

          SizedBox(height: 40,),
          
          // cta
          isSafe 
           ? Container()
           : Center(
             child: _buildCheckNearHospitalsButton(
                  context: context, onPressed: onCtaPressed
                ),
           ),

          SizedBox(height: 40,),

          // back button
          // Center(
          //   child: RaisedButton(
          //     child: Text('Go Back'),
          //     onPressed: ()=> this.goBack(context: context),
          //     color: AppColors.white,
          //   ),
          // ),


        ],
      ),
    );
  }


  Widget _buildCheckNearHospitalsButton({ 
    @required BuildContext context, @required Function onPressed }) {

    return FloatingActionButton.extended(
      icon: Icon(Icons.local_hospital),
      label: Text(
        'Check Hospitals Near Me',
      ),
      onPressed: ()=> onPressed(context: context),
    );
  }// Widget _buildCheckNearHospitalsButton({ . })

  Widget _buildKeepSafeButton({ 
    @required BuildContext context, @required Function onPressed }) {

    return FloatingActionButton.extended(
      icon: Icon(Icons.local_hospital),
      label: Text(
        'Check Symptoms',
      ),
      onPressed: ()=> onPressed(context: context),
    );
  }// Widget _buildCheckNearHospitalsButton({ . })

}