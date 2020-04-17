import 'package:flutter/material.dart';
import 'package:kiloko/models/condition.dart';
import 'package:kiloko/models/kiloko_location.dart';
import 'package:kiloko/services/local_db_service.dart';
import 'package:sqflite/sqflite.dart';


class LocalConditionService {
  Database _dbService;
  String _table = 'conditions';

  LocalConditionService() {
    this._getConnection();
  }
  
  // get db connection
  _getConnection() async {
    LocalDBService service = LocalDBService();
    _dbService = await service.localDb;
  }// _getConnection() async { .. }



  // add 
  Future<int> add({Map<String, dynamic> condition}) async {
    int id = await _dbService.insert(_table, condition);
    return id;
  }// Future<int> add({Map<String, dynamic> loc}) async { .. }


  // update sync status
  Future<void> update({ Map<String, dynamic> condition }) async {
    await _dbService.update(
      _table, condition, 
      where: "id = ?", whereArgs: [ condition['id'] ]
    );
  }// Future<void> update({ Map<String, dynamic> condition }) async { .. }


  // get all
  Future<List<Condition>> all() async {
    List<Condition> conditions = [];
    List<Map<String, dynamic>> conditionRes = await _dbService.query(_table);

    if ( conditionRes.isEmpty ) return conditions; 
    
    conditions = conditionRes.map((Map<String, dynamic> cond) {
      return Condition.fromMap(condition: cond);
    }).toList();
    return conditions;
  }// Future<List<Condition>> all() { .. }


  // get all by synced
  Future<List<Condition>> allSyncIs({ @required bool syncStatus }) async {
    List<Condition> conditions = [];
    List<Map<String, dynamic>> conditionsRes = await _dbService.query(
      _table, where: "isSynced = ?", whereArgs: [ syncStatus ]
    );

    if ( conditionsRes.isEmpty ) return conditions; 
    
    conditions = conditionsRes.map((Map<String, dynamic> cond) {
      return Condition.fromMap(condition: cond);
    }).toList();
    return conditions;
  }// Future<List<KilokoLocation>> all() { .. }

}