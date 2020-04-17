
import 'package:kiloko/models/condition.dart';
import 'package:kiloko/models/kiloko_location.dart';
import 'package:kiloko/models/medication.dart';
import 'package:kiloko/services/local_condition_service.dart';
import 'package:kiloko/services/local_location_service.dart';
import 'package:kiloko/services/local_medication_service.dart';

class SyncService {
  LocalLocationService _localLocationService;
  LocalConditionService _localConditionService;
  LocalMedicationService _localMedicationService;

  SyncService() {
    _localLocationService = LocalLocationService();
    _localConditionService = LocalConditionService();
    _localMedicationService = LocalMedicationService();
  }


  // after some intervals, check server for new data..
  // get it and add it to local db
  void syncDown() {

  }// void syncDown() { .. }
  
  // after some intervals, push unsynced to server
  void syncUp() async {
    
    List<KilokoLocation> locations = await _localLocationService
                                            .allSyncIs(syncStatus: false);
    
  }// void syncUp() { .. }

}