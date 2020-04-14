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
    return DateTime.now().isAfter(this.expiresAt);
  }
}

class Account {
  String id;
  String name;
  String phone;
  String nationalID;
  String kilokoID;
  String joinedOn;
  KilokoAuthToken kilokoAuthToken;
  List<Condition> conditions = [];
  List<Medication> medications = [];

  Account({
    this.id,
    this.name,
    this.nationalID,
    this.kilokoID,
    this.joinedOn,
    this.conditions,
    this.medications,
    this.kilokoAuthToken,
  });
}