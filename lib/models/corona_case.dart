import 'package:flutter/material.dart';
import 'package:kiloko/models/account.dart';


class CoronaCase {
  Account account;
  String hospital;
  DateTime diagnosedOn;
  String country;
  String city;

  CoronaCase({ 
    this.account, 
    this.hospital, 
    this.diagnosedOn, 
    this.country, 
    this.city 
  });
}