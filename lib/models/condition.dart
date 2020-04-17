import 'package:flutter/material.dart';
import 'package:kiloko/models/medication.dart';


class Condition {
  String name;
  String description;
  bool isTerminal = false;
  DateTime fromWhen;
  DateTime toWhen;
  List<Medication> medications = [];
  double isSynced;
  String cloudID;

  Condition({ 
    @required this.name, 
    this.description, 
    this.isTerminal, 
    this.medications,
    this.toWhen,
    this.fromWhen,
    this.isSynced,
    this.cloudID,
  });

  
  static Condition fromMap({ Map<String, dynamic> condition }) {

    return Condition(
      name: condition['name'],
      fromWhen: condition['fromWhen'],
      toWhen: condition['toWhen'],
      isSynced: condition['isSynced'],
      cloudID: condition['cloudID'],
    );
  }// static Condition fromMap({ Map<String, dynamic> condition }) { .. }
 

  static Map<String, dynamic> toMap({ Condition condition }) {

    return {
      'name': condition.name,
      'fromWhen': condition.fromWhen,
      'toWhen': condition.toWhen,
      'isSynced': condition.isSynced,
      'cloudID': condition.cloudID,
    };
  }// static Map<String, dynamic> toMap({ Condition condition }) { .. }

}