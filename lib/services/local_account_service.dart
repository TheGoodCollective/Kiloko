import 'package:flutter/material.dart';
import 'package:kiloko/config/app_utils.dart';
import 'package:kiloko/services/utils_service.dart';
import 'package:shared_preferences/shared_preferences.dart';


class LocalAccountService {

  LocalAccountService();



  static Future<void> newAccount() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    String accountCode = UtilsService.generateCode(length: 7);

    String existingCode = await sharedPreferences.getString(SharedPreferenceVars.accountID);

    if( existingCode.isNotEmpty ) {
      await sharedPreferences.setString(
        SharedPreferenceVars.accountID, accountCode
      );
    }
  }// void newAccount() async { .. }

}