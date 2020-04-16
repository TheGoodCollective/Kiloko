import 'package:flutter/material.dart';
import 'package:kiloko/models/condition.dart';

class Medication {
  String name;
  Condition condition;
  DateTime fromWhen;
  DateTime toWhen;
  String reason;

  Medication({ 
    @required this.name, 
    this.condition, 
    this.fromWhen, 
    this.toWhen,
    this.reason
  });
}