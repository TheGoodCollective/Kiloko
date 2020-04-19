import 'package:flutter/material.dart';
import 'package:kiloko/models/medication.dart';


class Condition {
  int id;
  String name;
  String description;
  bool isTerminal = false;
  DateTime fromWhen;
  DateTime toWhen;
  List<Medication> medications = [];
  double isSynced;
  String cloudID;

  Condition({ 
    this.id,
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
      id: condition['id'],
      name: condition['name'],
      fromWhen: condition['fromWhen'] != null 
                  ? DateTime.parse(condition['fromWhen']) : null,
      toWhen: condition['toWhen'] != null 
                ? DateTime.parse(condition['toWhen']) : null,
      isSynced: condition['isSynced'],
      cloudID: condition['cloudID'],
      medications: condition['medications'].toString()
                    .split('@').map((String med) {
                      return Medication(name: med);
                    }).toList(),
    );
  }// static Condition fromMap({ Map<String, dynamic> condition }) { .. }
 

  static Map<String, dynamic> toMap({ Condition condition }) {
    List<String> medicationNames = condition.medications.map((Medication med)=> med.name).toList();

    return {
      'id': condition.id,
      'name': condition.name,
      'fromWhen': condition.fromWhen != null 
                   ? condition.fromWhen.toString() : null,
      'toWhen': condition.toWhen != null 
                   ? condition.toWhen.toString() : null,
      'isSynced': condition.isSynced,
      'cloudID': condition.cloudID,
      'medications': medicationNames.join('@')
    };
  }// static Map<String, dynamic> toMap({ Condition condition }) { .. }

}