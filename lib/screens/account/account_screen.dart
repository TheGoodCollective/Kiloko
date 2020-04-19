import 'package:flutter/material.dart';
import 'package:kiloko/config/app_routes.dart';
import 'package:kiloko/config/app_utils.dart';
import 'package:kiloko/models/account.dart';
import 'package:kiloko/providers/local_account_provider.dart';
import 'package:kiloko/screens/account/account_details_widget.dart';
import 'package:kiloko/screens/account/account_not_authenticated.dart';
import 'package:kiloko/widgets/app_scaffold.dart';
import 'package:provider/provider.dart';


class AccountScreen extends StatefulWidget {
  AccountScreen();

  @override
  _AccountScreenState createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  LocalAccountProvider _localAccountProvider;

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    _localAccountProvider = Provider.of<LocalAccountProvider>(context);

    return Scaffold(

      appBar: AppBar(
        title: Text('Account'),
        centerTitle: true,
      ),

      body: AppScaffold(
        children: <Widget>[
          
          Consumer<LocalAccountProvider> (
            builder: (BuildContext ctx, LocalAccountProvider accountProvider, _) {

              return
                accountProvider.account != null && 
                accountProvider.account.isSynced != null && accountProvider.account.isSynced 
                ? AccountDetailsWidget(
                    account: accountProvider.account,
                    signOut: this._signOut,
                    updateAcount: this._updateAcount,
                    deleteAccount: this._deleteAccount,
                    goViewMyConditions: this._goViewMyConditions,
                    goViewMyMedications: this._goViewMyMedications,
                  )
                : Container(
                    margin: EdgeInsets.symmetric(horizontal: screenSize.width/10),
                    child: AccountNotAuthenticated(
                      account: accountProvider.account,
                      goLoginCallback: this._goLogin,
                      goRegisterCallback: this._goRegister,
                    ),
                  );

            }
          ),

        ],
      ),

    );
  }



  /*
   ** logic functions 
   */

  // go to login page
  void _goLogin({ BuildContext context }) {
    Navigator.of(context).pushNamed(AppRoutes.LOGIN);
  }
  
  // go to register page
  void _goRegister({ BuildContext context }) {
    Navigator.of(context).pushNamed(AppRoutes.REGISTER);
  }

  void _goViewMyConditions() {
    Navigator.of(context).pushNamed(AppRoutes.MY_CONDITIONS);
  }// void _goViewMyConditions() { .. }
  
  void _goViewMyMedications() {
    Navigator.of(context).pushNamed(AppRoutes.MY_MEDICATION);
  }// void _goViewMyMedications() { .. }

  void _deleteAccount({ BuildContext context }) {
    print('delete account');
    _localAccountProvider.deleteAccount();
  }
  
  void _signOut({ BuildContext context }) {
    print('sign out');
    this._deleteAccount();
  }

  void _updateAcount({ BuildContext context }) {
    print('sign out');
  }



 
  
}