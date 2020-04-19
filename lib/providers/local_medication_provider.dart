import 'package:flutter/material.dart';
import 'package:kiloko/models/medication.dart';
import 'package:kiloko/services/local_medication_service.dart';


class LocalMedicationProvider with
 ChangeNotifier {
  List<Medication> _medications = [];
  bool _isLoading = false;
  LocalMedicationService _localMedicationService;

  LocalMedicationProvider() {
    _localMedicationService = LocalMedicationService();
    this.all();
  }


  // getters
  List<Medication> get medications => this._medications;
  bool get isLoading => this._isLoading; 

  

  // add 
  void add({ Medication medication }) async {
    this._isLoading = false;
    notifyListeners();

    int id = await _localMedicationService.add(
      medication: Medication.toMap(medication: medication)
    );
    
    if( id == null ) {
      this._isLoading = false;
      notifyListeners();
      return;
    }
    
    medication.id = id;
    this._isLoading = false;
    this._medications.add(medication);
    
    notifyListeners();
  }// void add({ Medication medication }) async { .. }


  // get all
  void all() async {
    print(' med Future<List<Medication>> all() async');
    this._isLoading = true;
    notifyListeners();
print('_isLoading 1 $_isLoading');
    List<Medication> medicatns = await _localMedicationService.all();
print('_isLoading 2 $_isLoading');    
    this._isLoading = false;
    this._medications = medicatns;
print('_isLoading 3 $_isLoading');    
    notifyListeners();
  }// void all() async { .. }


  // delete 
  void delete({ Medication medication }) async {
    this._isLoading = true;
    notifyListeners();

    await _localMedicationService.delete( medication: medication, );
    
    this._isLoading = false;
    this._medications = this.medications.where((Medication med) {
       return med.id != medication.id;
    }).toList();
    
    notifyListeners();
  }// void delete() async { .. }

}