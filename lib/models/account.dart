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
  int id;
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

}