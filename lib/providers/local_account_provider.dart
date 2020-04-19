import 'package:flutter/material.dart';
import 'package:kiloko/config/app_utils.dart';
import 'package:kiloko/models/account.dart';
import 'package:kiloko/services/local_account_service.dart';
import 'package:shared_preferences/shared_preferences.dart';



class LocalAccountProvider with ChangeNotifier {
  Account _account;
  LocalAccountService _localAccountService;

  LocalAccountProvider() {
    _localAccountService = LocalAccountService();
    this._getAccount();
  }// LocalAccountProvider() { .. }


  // get user account
  Account get account=> this._account;


  Future<Account> _getAccount() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    try {
      String kilokoID = sharedPreferences.getString(SharedPreferenceVars.kilokoID);
      print('Future<Account> _getAccount() $kilokoID');
      this._account = Account(kilokoID: kilokoID);
    } catch (e) {
    }


    notifyListeners();
    return null;
  }// Future<Account> _getAccount() async { .. }

  // create a new kiloko account
  Future<void> newAccount() async {
    await LocalAccountService.newAccount();
  }// void newAccount() async { .. }

}