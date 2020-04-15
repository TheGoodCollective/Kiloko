import 'package:flutter/material.dart';
import 'package:kiloko/models/medication.dart';


class Condition {
  String name;
  String description;
  bool isTerminal = false;
  List<Medication> medications = [];

  Condition({ 
    @required this.name, 
    this.description, 
    this.isTerminal, 
    this.medications 
  });
}