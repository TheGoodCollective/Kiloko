import 'package:flutter/material.dart';
import 'package:kiloko/models/condition.dart';

class Medication {
  String name;
  Condition condition;
  DateTime fromWhen;
  DateTime toWhen;
  String reason;
  double isSynced;
  String cloudID;

  Medication({ 
    @required this.name, 
    this.condition, 
    this.fromWhen, 
    this.toWhen,
    this.reason,
    this.isSynced,
    this.cloudID,
  });
  

  static Medication fromMap({ Map<String, dynamic> medication }) {

    return Medication(
      name: medication['name'],
      reason: medication['reason'],
      fromWhen: medication['fromWhen'],
      toWhen: medication['toWhen'],
      isSynced: medication['isSynced'],
      cloudID: medication['cloudID'],
    );
  }// static Medication fromMap({ Map<String, dynamic> medication }) { .. }
 

  static Map<String, dynamic> toMap({ Medication medication }) {

    return {
      'name': medication.name,
      'reason': medication.reason,
      'fromWhen': medication.fromWhen,
      'toWhen': medication.toWhen,
      'isSynced': medication.isSynced,
      'cloudID': medication.cloudID,
    };
  }// static Map<String, dynamic> toMap({ Medication medication }) { .. }


}