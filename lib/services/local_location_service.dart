import 'package:flutter/material.dart';
import 'package:kiloko/models/kiloko_location.dart';
import 'package:kiloko/services/local_db_service.dart';
import 'package:sqflite/sqflite.dart';


class LocalLocationService {
  Database _dbService;
  String _table = 'locations';

  LocalLocationService() {
    this._getConnection();
  }
  
  // get db connection
  _getConnection() async {
    LocalDBService service = LocalDBService();
    _dbService = await service.localDb;
  }// _getConnection() async { .. }



  // add location
  Future<int> add({Map<String, dynamic> location}) async {
    int id = await _dbService.insert(_table, location);
    return id;
  }// Future<int> add({Map<String, dynamic> location}) async { .. }


  // update sync status
  Future<void> update({ Map<String, dynamic> location }) async {
    await _dbService.update(
      _table, location, 
      where: "id = ?", whereArgs: [ location['id'] ]
    );
  }// Future<void> update({ Map<String, dynamic> location }) async { .. }


  // get all
  Future<List<KilokoLocation>> all() async {
    List<KilokoLocation> locations = [];
    List<Map<String, dynamic>> locationRes = await _dbService.query(_table);

    if ( locationRes.isEmpty ) return locations; 
    
    locations = locationRes.map((Map<String, dynamic> loc) {
      return KilokoLocation.fromMap(location: loc);
    }).toList();
    return locations;
  }// Future<List<KilokoLocation>> all() { .. }


  // get all by synced
  Future<List<KilokoLocation>> allSyncIs({ @required bool syncStatus }) async {
    List<KilokoLocation> locations = [];
    List<Map<String, dynamic>> locationRes = await _dbService.query(
      _table, where: "isSynced = ?", whereArgs: [ syncStatus ]
    );

    if ( locationRes.isEmpty ) return locations; 
    
    locations = locationRes.map((Map<String, dynamic> loc) {
      return KilokoLocation.fromMap(location: loc);
    }).toList();
    return locations;
  }// Future<List<KilokoLocation>> all() { .. }



}