import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

// internal
import 'package:kiloko/models/account.dart';
import 'package:kiloko/services/account_service.dart';
import 'package:kiloko/services/local_account_service.dart';


class AccountProvider with ChangeNotifier {

  Account _account = Account();

  bool _isLoading = false;
  bool _hasError = false;
  bool _isAuthenticated = false;
  
  // service
  AccountService _accountService;
  LocalAccountService _localAccountService;
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;


  // constructor
  AccountProvider() {
    _accountService = AccountService();
    _localAccountService = LocalAccountService();

    // check if there is a user in shared preferences and get a token for them
    this.initAccount();
    
    // watch out for any firebase auth changes here
    _firebaseAuth.onAuthStateChanged.listen(this._accountChanged);
  }

  // getters
  Account get account => this._account;
  bool get isLoading => this._isLoading;
  bool get hasError => this._hasError;
  bool get isAuthenticated => this._isAuthenticated;

  bool hasUser (){ 
    return this._account != null; 
  }


  /**
   * local logic
   */
  

  Future<void> initAccount() async {
    Account accnt = await this._localAccountService.getAccount();
    print('provider >> Future<void> initAccount() async { in provdr');

    if( accnt == null ) return;
    
    this._account = accnt;
    print('initAccount');
    print(this._account);
    notifyListeners();

    // save to shared prefs
    this.saveAccount(account: accnt);
  }// Future<Account> _getAccount() async { .. }

  // create a new kiloko account
  Future<void> newAccount() async {
    await LocalAccountService.newAccount();
  }// void newAccount() async { .. }

  // delete account 
  Future<void> deleteAccount() async {
    await _localAccountService.deleteAccount();
    this._account = Account();
    notifyListeners();
  }// Future<void> deleteAccount({ Acccount acccount }) { .. }
  
  Future<void> setIsSynced({ @required bool isSynced }) async {
    await _localAccountService.setIsSynced(isSynced: isSynced);
  }// Future<void> setIsSynced({ @required bool isSynced }) { .. }


  //
  Future<void> saveAccount({ Account account }) async {
    _localAccountService.saveAccount(account: account);
    this._account = account;
    notifyListeners();
  }// Future<void> saveAccount({ Account account }) async { .. }

  //
  Future<void> saveToken({ KilokoAuthToken token }) {
    _localAccountService.saveToken(authToken: token);
    this._account.kilokoAuthToken = token;
    notifyListeners();
  }// Future<void> saveToken({ KilokoAuthToken token }) { .. }




  /*
   ** firebase related logic
   */

  // 
  void _accountChanged(FirebaseUser firebaseUser) async{
    print('provider >> void _accountChanged(FirebaseUser firebaseUser) async{');
    print(firebaseUser);
    if( firebaseUser == null ) return;
    
    // go to server fetch the other details
    Account kilokoAccount = await getUserDetails(
      account: Account( id: firebaseUser.uid )
    );
  
    //  if vidaAccount is null return
    if ( kilokoAccount == null || kilokoAccount.id == null ) {
      print('kilokoAccount is null ');
      return;
    }

    // save in shared preferences
    kilokoAccount.isSynced = true;
    await saveAccount(account: kilokoAccount);
    await setIsSynced(isSynced: true);

    print('provider >> in _accountChanged >>><<<< ');
    print(kilokoAccount);
    
    this._account = kilokoAccount;
    notifyListeners();
  }// void _gotUser(FirebaseUser firebaseUser) async{ .. }

  // get user details from server
  Future<Account> getUserDetails({ Account account }) async {
    return await _accountService.getUserDetails(account: account);
  }// Future<Account> getUserDetails({ VidaAuthToken authToken }) { .. }

  // register
  Future<Account> register({ @required Account account }) async {
    this._isLoading = true;
    Account accntt;
    notifyListeners();

    // make api request
    try {
      FirebaseUser fireUser = await _accountService.registerWithEmailAndPassword(account: account);
      
      if( fireUser == null ) {
        this._isLoading = false;
        this._hasError = true;
        notifyListeners();
        return null;
      }

      account.id = fireUser.uid;
      account.cloudID = fireUser.uid;
      account.joinedOn = DateTime.now();
      // save in firestore
      await _accountService.register(account: account);
      // save in shared preferences
      await saveAccount(account: account);
      await setIsSynced(isSynced: true);
    
      this._isLoading = false;
      this._hasError = true;
      this._account = account;
      accntt = account;
    } catch (e) {
      this._hasError = true;
      this._isLoading = false;
      this._isAuthenticated = false;
      accntt = null;
    }
    
    notifyListeners();
    return accntt;
  }// void register({ @required Account account }) { .. }


  // login in with firebase
  Future<Account> login({ @required Account account }) async{
    this._isLoading = true;  
    notifyListeners();
    
    Account accnt = await this._accountService.login(account: account);
    // save in shared preferences
    await saveAccount(account: account);
    await setIsSynced(isSynced: true);

    this._isLoading = false;
    notifyListeners();
    return accnt;
  }
  
  // delete account
  Future<void> delete({ Account account }) async {
    _accountService.delete(account: account);
    _accountService.deleteFromFirebase(account: account);
    this._account = Account();
    notifyListeners();
  }// Future<void> delete({ Account account }) async { .. }
  
  // logout account
  Future<void> logOut({ Account account }) async {
    _accountService.logOut();
    this._account = Account();
  }// Future<void> delete({ Account account }) async { .. }

  
}