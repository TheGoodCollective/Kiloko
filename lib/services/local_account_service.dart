import 'package:flutter/material.dart';
import 'package:kiloko/config/app_utils.dart';
import 'package:kiloko/models/account.dart';
import 'package:kiloko/services/utils_service.dart';
import 'package:shared_preferences/shared_preferences.dart';


class LocalAccountService {

  LocalAccountService();


  // create a kilokoID for current user
  static Future<void> newAccount() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    String kilokoID = UtilsService.generateCode();
    
    int existingKilokoID = sharedPreferences.getInt(SharedPreferenceVars.kilokoID);
    
    if( existingKilokoID == null ) {
      await sharedPreferences.setInt(
        SharedPreferenceVars.kilokoID, int.parse(kilokoID)
      );
    }
  }// void newAccount() async { .. }


  // get account from shared preferences
  Future<Account> getAccount() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    Account account;

    try {
      int kilokoID = sharedPreferences.getInt(SharedPreferenceVars.kilokoID);
      print('in localaccountservice >> Future<Account> getAccount() kilokoID $kilokoID');
      
      bool isSynced = sharedPreferences.getBool(SharedPreferenceVars.isSynced) ?? false;

      print('in localaccountservice >> isSynced $isSynced');

      if( kilokoID == null ) return Account();
      print('in localaccountservice >> passed if( kilokoID == null ) return Account()');

      if( !isSynced ) {
        account = Account(kilokoID: kilokoID);
        return account;
      }

      String cloudID = sharedPreferences.getString(SharedPreferenceVars.cloudID);
      String name = sharedPreferences.getString(SharedPreferenceVars.accountName);
      String phone = sharedPreferences.getString(SharedPreferenceVars.accountPhone);
      String nationalID = sharedPreferences.getString(SharedPreferenceVars.accountNationalID);
      String joinedOn = sharedPreferences.getString(SharedPreferenceVars.accountJoinedOn);
      String accountID = sharedPreferences.getString(SharedPreferenceVars.accountID);
            
      account = Account(
        kilokoID: kilokoID,
        id: accountID,
        cloudID: cloudID,
        name: name,
        phone: phone,
        nationalID: nationalID,
        joinedOn: DateTime.parse(joinedOn),
        isSynced: isSynced,
      );
      print('in localaccountservice >> account');
      print(account);

    } catch (e) {
      print('error in servce get account ${e.toString()}');
      account = null;
    }

    return account;
  }// Future<Account> getAccount() { .. }
  

  
  // get token data from shared preferences
  Future<KilokoAuthToken> getToken() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    KilokoAuthToken kilokoAuthToken;

    try {
      int kilokoID = sharedPreferences.getInt(SharedPreferenceVars.kilokoID);
      bool isSynced = sharedPreferences.getBool(SharedPreferenceVars.isSynced);
      
      if( kilokoID == null || !isSynced ) return null;

      String accountAccessToken = sharedPreferences.getString(SharedPreferenceVars.accountAccessToken);
      String accountAccessTokenExpiry = sharedPreferences.getString(SharedPreferenceVars.accountAccessTokenExpiry);
      String accountAccessTokenOfferedTime = sharedPreferences.getString(SharedPreferenceVars.accountAccessTokenOfferedOn);
      
      if ( accountAccessToken == null || accountAccessToken.isEmpty ) {
        kilokoAuthToken = null;
      } else {
        kilokoAuthToken = KilokoAuthToken(
          token: accountAccessToken,
          expiresAt: DateTime.parse(accountAccessTokenExpiry),
          givenAt: DateTime.parse(accountAccessTokenOfferedTime)
        );
      }

    } catch (e) {
      kilokoAuthToken = null;
    }

    return kilokoAuthToken;
  }// Future<Account> getToken() { .. }
  

  // save user token to shared preferences
  Future<void> saveToken({ KilokoAuthToken authToken }) async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    bool saved = false;

    try {
      
      await sharedPreferences.setString(
        SharedPreferenceVars.accountAccessToken, authToken.token
      );  
      await sharedPreferences.setString(
        SharedPreferenceVars.accountAccessTokenOfferedOn, 
        authToken.givenAt.toString()
      );  
      await sharedPreferences.setString(
        SharedPreferenceVars.accountAccessTokenExpiry, 
        authToken.expiresAt.toString()
      );

      saved = true;
    }catch(e) { }

    return saved;
  }// Future<void> saveToken({ KilokoAuthToken authToken }) async{ .. }
 
  // save account to shared preferences
  Future<void> saveAccount({ Account account }) async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    bool saved = false;

    try {
      
      await sharedPreferences.setString(
        SharedPreferenceVars.accountID, account.id
      );  
      await sharedPreferences.setInt(
        SharedPreferenceVars.kilokoID, account.kilokoID
      );  
      await sharedPreferences.setString(
        SharedPreferenceVars.cloudID, account.cloudID
      );
      await sharedPreferences.setString(
        SharedPreferenceVars.accountAccessToken, account.name
      );
      await sharedPreferences.setString(
        SharedPreferenceVars.accountPhone, account.phone.toString()
      );
      await sharedPreferences.getString(
        SharedPreferenceVars.accountNationalID
      );  
      await sharedPreferences.setString(
        SharedPreferenceVars.accountJoinedOn, 
        account.joinedOn.toString()
      );

      saved = true;
    }catch(e) { }

    return saved;
  }// Future<void> saveAccount({ Account account }) async{ .. }
  

  // delete account from shared preferences
  Future<void> deleteAccount() async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    try {
      
      await sharedPreferences.remove( SharedPreferenceVars.accountID );  
      await sharedPreferences.remove( SharedPreferenceVars.kilokoID );  
      await sharedPreferences.remove( SharedPreferenceVars.cloudID );

      await sharedPreferences.remove( SharedPreferenceVars.accountName );  
      await sharedPreferences.remove( SharedPreferenceVars.accountPhone );  
      await sharedPreferences.remove( SharedPreferenceVars.accountNationalID );  
      await sharedPreferences.remove( SharedPreferenceVars.isSynced ); 

      await sharedPreferences.remove(SharedPreferenceVars.accountAccessToken );  
      await sharedPreferences.remove( SharedPreferenceVars.accountPhone );  
      await sharedPreferences.remove( SharedPreferenceVars.accountNationalID );  
      await sharedPreferences.remove( SharedPreferenceVars.accountJoinedOn );

    }catch(e) { }

  }// Future<void> deleteAccount() async{ .. }
  

  Future<void> setIsSynced({ @required bool isSynced }) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    bool saved = false;

    try {
      saved = await sharedPreferences.setBool(
        SharedPreferenceVars.isSynced, isSynced);
    } catch(e) { }
    
    return saved;
  }// Future<void> hasSynced() async { .. }


}