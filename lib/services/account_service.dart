import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


// internal
import 'package:kiloko/models/account.dart';


class AccountService {
  Account account;
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  Firestore _firestore;

  AccountService() {
    // get user details from shared preferences if they exist
    _firestore = Firestore.instance;
  }

  // delete account 
  Future<bool> delete({ Account account }) async {
    try {
      await _firestore.document(account.kilokoID.toString()).delete();
      return true;
    }catch(e) {
      return false;
    }
  }// Future<bool> delete({ Account account }) { .. }


  // register
  Future<Account> register({ Account account }) async{
    try {
      await _firestore.collection('accounts')
             .document(account.kilokoID.toString())
             .setData(Account.toJson(account: account));

      account.cloudID = account.kilokoID.toString(); 
      return account;
    } catch(e) {
      return null;
    }
  }// Account register({ Account account }) { .. }

  // login to firebase
  Future<Account> login({ Account account }) async{
    try {
      AuthResult result = await _firebaseAuth.signInWithEmailAndPassword(email: account.kilokoID.toString(), password: account.password);

      FirebaseUser user = result.user;
      return Account( 
        kilokoID: int.parse(user.email), 
        password: account.password, 
        id: user.uid,
        cloudID: user.uid
      );
    } catch (e) {
      return null;
    }
  }// Account login({ Account account }) { .. }

  // register
  Future<FirebaseUser> registerWithEmailAndPassword({ Account account }) async{
    try {
      AuthResult result = await _firebaseAuth.createUserWithEmailAndPassword(email: account.kilokoID.toString(), password: account.password);

      FirebaseUser user = result.user; 
      return user;
      // return Account( 
      //   email: user.email, password: account.password, id: user.uid,
      // );
    } catch(e) {
      return null;
    }
  }// Account registerWithEmailAndPassword({ Account account }) { .. }

  // log out
  void logOut() {
    this._firebaseAuth.signOut();
  }
  
  // delete from firestore
  void deleteFromFirebase({ Account account }) async{
    FirebaseUser user = await _firebaseAuth.currentUser();
    
    if( user != null ) {
      user.delete();
      return;
    }
  }// deleteFromFirebase({ Account account }) async{ .. }


  // get user details from server
  Future<Account> getUserDetails({ Account account }) async{

    try{
      DocumentSnapshot documentSnapshot = await _firestore.document(account.kilokoID.toString()).get();
    
      return Account.fromJson(account: documentSnapshot.data);
    } catch(e) {
      print('getUserDetails >> error');
      print(e);
      print(e.toString());
      return null;
    }
  }// Future<Account> getUserDetails({ VidaAuthToken authToken }) async{ .. }

}
