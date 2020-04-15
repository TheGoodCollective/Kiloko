import 'package:flutter/material.dart';
import 'package:kiloko/models/condition.dart';

class Medication {
  String name;
  Condition condition;

  Medication({ @required this.name, this.condition });
}