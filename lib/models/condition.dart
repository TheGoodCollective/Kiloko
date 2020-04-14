import 'package:flutter/material.dart';
import 'package:kiloko/models/medication.dart';


class Condition {
  String name;
  List<Medication> medications = [];

  Condition({ @required this.name, this.medications });
}