import 'package:flutter/material.dart';
import 'package:kiloko/models/account.dart';
import 'package:kiloko/services/local_account_service.dart';



class LocalAccountProvider with ChangeNotifier {
  Account _account = Account();
  LocalAccountService _localAccountService;

  LocalAccountProvider() {
    _localAccountService = LocalAccountService();
    this._getAccount();
  }// LocalAccountProvider() { .. }


  // get user account
  Account get account=> this._account;


  Future<void> _getAccount() async {
    this._account = await this._localAccountService.getAccount();
    print('Future<void> _getAccount() async { in provdr');
    print(this._account);
    notifyListeners();
  }// Future<Account> _getAccount() async { .. }

  // create a new kiloko account
  Future<void> newAccount() async {
    await LocalAccountService.newAccount();
  }// void newAccount() async { .. }

  // delete account 
  Future<void> deleteAccount() async {
    await _localAccountService.deleteAccount();
  }// Future<void> deleteAccount({ Acccount acccount }) { .. }
  
  Future<void> setIsSynced({ @required bool isSynced }) async {
    await _localAccountService.setIsSynced(isSynced: isSynced);
  }// Future<void> setIsSynced({ @required bool isSynced }) { .. }

}