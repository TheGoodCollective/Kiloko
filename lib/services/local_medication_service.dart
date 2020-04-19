import 'package:flutter/material.dart';
import 'package:kiloko/models/medication.dart';
import 'package:kiloko/services/local_db_service.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';


class LocalMedicationService {
  Database _dbService;
  String _table = 'medications';

  LocalMedicationService() {
    this._getConnection();
  }
  
  // get db connection
  _getConnection() async {
    print('init med data now');
    LocalDBService service = LocalDBService();
    _dbService = await service.localDb;
  }// _getConnection() async { .. }



  // add 
  Future<int> add({Map<String, dynamic> medication}) async {
    if(_dbService == null) { await _getConnection(); }
    
    try {
      int id = await _dbService.insert(_table, medication);
      return id;
    } catch(e) {
      print('add service error ${e.toString()}');  
    }
    return null;
  }// Future<int> add({Map<String, dynamic> medication}) async { .. }


  // update sync status
  Future<void> update({ Map<String, dynamic> medication }) async {
    if(_dbService == null) { await _getConnection(); }

    await _dbService.update(
      _table, medication, 
      where: "id = ?", whereArgs: [ medication['id'] ]
    );
  }// Future<void> update({ Map<String, dynamic> medication }) async { .. }


  // get all
  Future<List<Medication>> all() async {
    if(_dbService == null) { await _getConnection(); }

    List<Medication> medications = [];
    List<Map<String, dynamic>> medicationRes = await _dbService.query(_table);

    if ( medicationRes.isEmpty ) return medications; 
    
    medications = medicationRes.map((Map<String, dynamic> med) {
      return Medication.fromMap(medication: med);
    }).toList();
    return medications;
  }// Future<List<Condition>> all() { .. }


  // get all by synced
  Future<List<Medication>> allSyncIs({ @required bool syncStatus }) async {
    if(_dbService == null) { await _getConnection(); }

    List<Medication> medications = [];
    List<Map<String, dynamic>> medicationsRes = await _dbService.query(
      _table, where: "isSynced = ?", whereArgs: [ syncStatus ]
    );

    if ( medicationsRes.isEmpty ) return medications; 
    
    medications = medicationsRes.map((Map<String, dynamic> med) {
      return Medication.fromMap(medication: med);
    }).toList();
    return medications;
  }// Future<List<KilokoLocation>> all() { .. }
  
  
  Future<void> delete({ Medication medication }) async {
    if(_dbService == null) { await _getConnection(); }

    await _dbService.delete(
      _table, where: "id = ?", whereArgs: [ medication.id ]
    );
  }// void delete({ Medication medication }) async { .. }



  // sync data with the server
  void syncData() {
    print('sync data');
  }// void syncData() { .. }



}