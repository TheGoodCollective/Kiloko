import 'package:flutter/material.dart';
import 'package:kiloko/config/app_utils.dart';
import 'package:kiloko/services/utils_service.dart';
import 'package:shared_preferences/shared_preferences.dart';


class LocalAccountService {

  LocalAccountService();



  static Future<void> newAccount() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    String accountCode = UtilsService.generateCode(length: 1);
print('KilokoID $accountCode');
    String existingCode = sharedPreferences.getString(SharedPreferenceVars.kilokoID);
print('existingCode $existingCode');
    // if( existingCode == null ) {
      await sharedPreferences.setString(
        SharedPreferenceVars.kilokoID, null
      );
    // }
  }// void newAccount() async { .. }

}