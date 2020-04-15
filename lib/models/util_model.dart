import 'package:flutter/material.dart';


class UtilModel {

  
  // calculate a recommendation when a user checks symptoms
  static bool shouldVisitDoctor({ 
    @required List<String> symptoms,  
    @required List<String> extraSymptoms,
    @required List<String> selectedSymptoms, 
  }) {

    if( selectedSymptoms.length / symptoms.length > 0.25 ) {
      return true;
    }
    if( extraSymptoms.length > 1 ) {
      return true;
    }
    
    
    return false;
  }// static bool shouldVisitDoctor({ }) { .. }

}