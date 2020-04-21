import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kiloko/models/account.dart';
import 'package:kiloko/models/kiloko_location.dart';
import 'package:kiloko/services/local_location_service.dart';

class LocationService {
  LocalLocationService _localLocationService;
  Firestore _firestore;

  LocationService() {
    _localLocationService = LocalLocationService();
    _firestore = Firestore.instance;
  }// MedicationService() { .. }


  // add
  Future<bool> add({ 
    @required KilokoLocation location, @required Account account }) async {
    
    Map<String, dynamic> jsonLoc = KilokoLocation.toMap(location: location);
    jsonLoc['account'] = account.id;

    DocumentReference ref = await _firestore.collection('locations')
            .add( jsonLoc );
    location.cloudID = ref.documentID;

   if( ref == null && ref.documentID == null ) return false;

    await _localLocationService.updateSyncStatus(
      location: KilokoLocation.toMap(location: location)
    );
    return true;
  }// Future<bool> add({  }) { .. } 

  // delete
  Future<void> delete({ KilokoLocation location }) async {
    
    await _firestore.collection('locations')
            .document(location.cloudID)
            .delete();

  }// Future<bool> add({  }) { .. } 


  // get all
  Future<List<KilokoLocation>> all({ @required Account account }) async {
    List<KilokoLocation> locations = [];
    
    QuerySnapshot data = await _firestore.collection('locations')
                    .where("account", isEqualTo: account.id)
                    .getDocuments();
    
    locations = data.documents.map((DocumentSnapshot snap) {
      Map<String, dynamic> snapData = snap.data;
      snapData['cloudID'] = snap.documentID;

      return KilokoLocation.fromMap(location: snapData);
    }).toList();
    
    return locations;
  }// Future<KilokoLocation> all({  }) { .. }


}