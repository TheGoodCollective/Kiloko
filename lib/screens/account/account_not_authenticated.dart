import 'package:flutter/material.dart';
import 'package:kiloko/models/account.dart';


class AccountNotAuthenticated extends StatelessWidget {
  final Function goLoginCallback;
  final Function goRegisterCallback;
  final Account account;

  AccountNotAuthenticated({ 
    this.goLoginCallback,
    this.goRegisterCallback,
    this.account,
  });

  @override
  Widget build(BuildContext context) {
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
                  onPressed: ()=> this.goRegisterCallback(context: context),
                  
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
                  onPressed: ()=> this.goLoginCallback(context: context),
                  
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
          account.kilokoID,
          style: Theme.of(context).textTheme.body2.copyWith(
            fontWeight: FontWeight.w600
          ),
          textAlign: TextAlign.center,
        ),

        
      ]
    );
  }// Widget build(BuildContext context) { .. }

}