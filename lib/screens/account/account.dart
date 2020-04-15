import 'package:flutter/material.dart';
import 'package:kiloko/config/app_routes.dart';
import 'package:kiloko/config/app_utils.dart';
import 'package:kiloko/models/account.dart';
import 'package:kiloko/widgets/app_scaffold.dart';


class AccountScreen extends StatefulWidget {
  AccountScreen();

  @override
  _AccountScreenState createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  bool _hasUser = false;
  Account _account = Account(
    name: 'Emily Blake', phone: '+185948985893',
    kilokoID: 'itjfnfievretge', nationalID: 95673798,
  );

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    return Scaffold(

      appBar: AppBar(
        title: Text('Account'),
        centerTitle: true,
      ),

      body: AppScaffold(
        children: <Widget>[
          
          _hasUser
            ?     
            buildAccountDetails(
              context: context, 
              account: _account,
            )
            :
            Container(
              margin: EdgeInsets.symmetric(horizontal: screenSize.width/10),
              child: buildNotAuthenticatedd(context: context)
            ),

        ],
      ),


    );
  }



  
  // build account details
  Widget buildAccountDetails({ @required BuildContext context, @required Account account }) {
    Size screenSize = MediaQuery.of(context).size;

    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
            
          SizedBox(height: 16),

          // image
          Center(
            child: Container(
              height: screenSize.width/2,
              width: screenSize.width/2,
              child: CircleAvatar(
                backgroundImage: AssetImage('assets/images/404.jpg'),
              ),
            ),
          ),

          SizedBox(height: 8),

          // name
          ListTile(
            leading: Icon(Icons.person, size: 30,),
            title: Text(
              account.name ?? '',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
          ),

          // phone
          ListTile(
            leading: Icon(Icons.phone, size: 30,),
            title: Text(
              account.phone ?? '',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
          ),

          // national id
          ListTile(
            leading: Icon(Icons.card_membership, size: 30,),
            title: Text(
              account.nationalID ?? '',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
          ),
          
          // kiloko id
          ListTile(
            leading: Icon(
              Icons.security, size: 30,
              color: AppColors.sucsess,
            ),
            title: Text(
              account.kilokoID ?? '',
              style: Theme.of(context).textTheme.body1.copyWith(
                color: AppColors.sucsess,
              )
            ),
          ),

          SizedBox(height: 28),

          // signout
          Center(
            child: Container(
              width: screenSize.width/2.4,
              child: RaisedButton(
                child: Text(
                  'Sign Out',
                ),
                onPressed: ()=> this._signOut(context: context),
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                    color: Colors.cyan[300],
                  ),
                  borderRadius: BorderRadius.circular(24),
                ),
                textColor: Colors.cyan[400],
                elevation: 0,
              ),
            ),
          ),

          SizedBox(height: 16),

          // delete
          Center(
            child: Container(
              width: screenSize.width/2.4,
              child: RaisedButton(
                child: Text(
                  'Delete Account',
                ),
                onPressed: ()=> this._deleteAccount(context: context),
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                    color: Colors.white,
                  ),
                  borderRadius: BorderRadius.circular(24),
                ),
                textColor: Colors.redAccent[200],
                elevation: 0,
              ),
            ),
          ),

          SizedBox(height: 80),

          // update acount
          Center(
            child: Container(
              width: screenSize.width/2.4,
              child: RaisedButton(
                child: Text(
                  'Update Account',
                ),
                onPressed: ()=> this._updateAcount(context: context),
                color: Colors.cyan[300],
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                    color: Colors.cyan[300],
                  ),
                  borderRadius: BorderRadius.circular(24),
                ),
                textColor: Colors.white,
                elevation: 0,
              ),
            ),
          ),


        ],
      ),
    );
  }

  
  // show if user is not logged in
  Widget buildNotAuthenticatedd({ BuildContext context }) {
    Size screenSize = MediaQuery.of(context).size;

    return Column(
      children: <Widget> [

        SizedBox(height: 40),

        // image here
        Container(
          height: screenSize.width/2,
          width: screenSize.width/2,
          child: CircleAvatar(
            backgroundImage: AssetImage('assets/images/one.jpg'),
          ),
        ),

        SizedBox(height: 56),

        // text
        Text(
          'You are not logged',
          style: Theme.of(context).textTheme.title,
          textAlign: TextAlign.center,
        ),

        SizedBox(height: 20),
        
        Text(
          'Login to participate in the global effort to flatten the curve. Join the movement.',
          style: Theme.of(context).textTheme.body1,
          textAlign: TextAlign.center,
        ),

        SizedBox(height: 56),

        // cta buttons
        Row(
          children: <Widget>[

            Expanded(
              flex: 2,
              child: Container(
                height: 48,
                child: RaisedButton(
                  child: Text(
                    'Create Account Now',
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  onPressed: ()=> this._goRegister(context: context),
                  
                  elevation: 0,
                  color: Colors.white,
                  textColor: Colors.cyan,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                    side: BorderSide(
                      color: Colors.cyan[200],
                      width: 2,
                    )
                  ),
                ),
              ),
            ),
            
            Expanded(flex: 1, child: Container(),),

            Expanded(
              flex: 2,
              child: Container(
                height: 48,
                child: RaisedButton(
                  child: Text(
                    'Login Now',
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  onPressed: ()=> this._goLogin(context: context),
                  
                  elevation: 4,
                  color: Colors.cyan,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                ),
              ),
            ),

          ],
        ),

        SizedBox(height: 72),

        // kiloko info
        Text(
          'Kiloko only knows you as',
          style: Theme.of(context).textTheme.body2,
          textAlign: TextAlign.center,
        ),

        SizedBox(height: 16),
        
        Text(
          _account.kilokoID,
          style: Theme.of(context).textTheme.body2.copyWith(
            fontWeight: FontWeight.w600
          ),
          textAlign: TextAlign.center,
        ),

        
      ]
    );
  }// Widget buildNotAuthenticatedd({ BuildContext context }) { .. }

  

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

  void _deleteAccount({ BuildContext context }) {
    print('delete account');
  }
  
  void _signOut({ BuildContext context }) {
    print('sign out');
  }

  void _updateAcount({ BuildContext context }) {
    print('sign out');
  }



 
  
}