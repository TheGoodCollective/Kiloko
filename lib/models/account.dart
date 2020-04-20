import 'package:flutter/material.dart';
import 'package:kiloko/models/condition.dart';
import 'package:kiloko/models/medication.dart';



class KilokoAuthToken {
  String token;
  DateTime givenAt;
  DateTime expiresAt;

  KilokoAuthToken({ this.token, this.givenAt, this.expiresAt });

  // check if token expired
  bool isExpired(){
    if( this.expiresAt == null ) return true;
    return DateTime.now().isAfter(this.expiresAt);
  }
}

class Account {
  String id;
  String name;
  String password;
  String phone;
  int nationalID;
  int kilokoID;
  DateTime joinedOn;
  KilokoAuthToken kilokoAuthToken;
  List<Condition> conditions = [];
  List<Medication> medications = [];
  bool isSynced;
  String cloudID;

  Account({
    this.id,
    this.name,
    this.password,
    this.phone,
    this.nationalID,
    this.kilokoID,
    this.joinedOn,
    this.conditions,
    this.medications,
    this.kilokoAuthToken,
    this.isSynced,
    this.cloudID,
  });

  String toString() {
    return '''
      id is ${this.id} name ${this.name} nationalID ${this.nationalID}
      isSynced ${isSynced} kilokoID ${this.kilokoID}
    ''';
  }// String toString() { .. } 

  bool get isAuthenticated=> !this.kilokoAuthToken.isExpired();


  // create an accountobject from account json data
  static Account fromJson({Map<String, dynamic> account}) {
    return new Account(
      id: account['id'],
      name: account['name'],
      phone: account['phone'].toString(),
      password: account['password'],
      joinedOn: DateTime.parse(account['joined_on']),
      nationalID: int.parse(account['nationalID']),
      kilokoID: int.parse(account['nationalID']), 
    );
  }// static Account fromJson(Map<String, dynamic> accountJson) { .. }

  // convert an account to json
  static Map<String, dynamic> toJson({Account account}) {
    return { 
      'id': account.id,
      'name': account.name, 
      'phone': account.phone,
      'password': account.password, 
      'joinedOn': account.password, 
      'nationalID': account.nationalID,
      'kilokoID': account.kilokoID, 
    };
  }// static Map<String, dynamic> toJson(Account account) { .. }

}