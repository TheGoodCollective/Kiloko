import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter/material.dart';


class LocalDBService {
  // db name
  String _dbName = 'kiloko.db';
  int _dbVersion = 1;

  static Database _localDB;
  
  static final _localDBService = LocalDBService._internal();

  LocalDBService._internal();
  
  // returns the single class instance
  factory LocalDBService()=> _localDBService;
  
  // get connection
  Future<Database> get localDb async {
    if( _localDB != null ) return _localDB;
    
    Database db = await _initLocalDb();
    _localDB = db;
    return _localDB;
  }// Future<Database> get localDb async { .. } 

  // connect to db
  _initLocalDb() async {
    var dbsPath = await getDatabasesPath();
    var dbPath = join(dbsPath, _dbName); 

    return await openDatabase(
      dbPath, version: _dbVersion, onCreate: _onCreateDb,
    );
  }// _initLocalDb() async { .. }


  // create db tables
  _onCreateDb(Database db, int version) async {
    
    // store user locations
    await db.execute(
      '''
        CREATE TABLE locations (
          id INTEGER PRIMARY KEY,
          lat DOUBLE(10, 8),
          lng DOUBLE(10, 8),
          isSynced BOOLEAN DEFAULT FALSE,
          cloudID STRING,
        )
      '''
    );

    // store user medications
    await db.execute(
      '''
        CREATE TABLE medications (
          id INTEGER PRIMARY KEY,
          name TEXT,
          reason TEXT,
          fromWhen DATETIME,
          toWhen DATETIME,
          isSynced BOOLEAN DEFAULT FALSE,
          cloudID STRING,
        )
      '''
    );
    
    // store user conditions
    await db.execute(
      '''
        CREATE TABLE conditions (
          id INTEGER PRIMARY KEY,
          name TEXT,
          reason TEXT,
          fromWhen DATETIME,
          toWhen DATETIME,
          medications TEXT,
          isSynced BOOLEAN DEFAULT FALSE,
          cloudID STRING,
        )
      '''
    );

  }// _onCreateDb(Database db, int version) async { .. }


}