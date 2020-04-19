import 'package:flutter/material.dart';
import 'package:kiloko/config/app_utils.dart';
import 'package:kiloko/models/account.dart';



class AccountDetailsWidget extends StatelessWidget {
  final Account account;
  final Function updateAcount;
  final Function deleteAccount;
  final Function signOut;
  final Function goViewMyMedications;
  final Function goViewMyConditions;

  AccountDetailsWidget({
    this.account, this.updateAcount, this.signOut, this.deleteAccount,
    this.goViewMyMedications, this.goViewMyConditions,
  });

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
            
          SizedBox(height: 32),

          // image
          Center(
            child: Container(
              height: screenSize.width/2.4,
              width: screenSize.width/2.4,
              child: CircleAvatar(
                backgroundImage: AssetImage('assets/images/one.jpg'),
              ),
            ),
          ),

          SizedBox(height: 24),

          // name
          ListTile(
            leading: Icon(Icons.person, size: 30,),
            title: detailText(text: account.name),
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
              account.nationalID.toString() ?? '',
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

          SizedBox(height: 80),

          // view my medications
          Container(
            margin: EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: AppColors.white,
              boxShadow: <BoxShadow> [
                
                BoxShadow(
                  color: AppColors.tertiaryAlt,
                  spreadRadius: 3,
                  blurRadius: 4,
                ),

              ]
            ),
            child: ListTile(
              trailing: Icon(
                Icons.keyboard_arrow_right, size: 40,
                color: AppColors.black,
              ),
              title: Text(
                'View my medications',
                style: Theme.of(context).textTheme.body1.copyWith(
                  // color: AppColors.sucsess,
                ),
              ),
              contentPadding: EdgeInsets.only(left: 20, right: 20),
              onTap: this.goViewMyMedications,
            ),
          ),

          SizedBox(height: 20),

          // view my conditions
          Container(
            margin: EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: AppColors.white,
              boxShadow: <BoxShadow> [
                
                BoxShadow(
                  color: AppColors.tertiaryAlt,
                  spreadRadius: 3,
                  blurRadius: 4,
                ),

              ]
            ),
            child:
              ListTile(
                trailing: Icon(
                  Icons.keyboard_arrow_right, size: 40,
                  color: AppColors.black,
                ),
                title: Text(
                  'View my conditions',
                  style: Theme.of(context).textTheme.body1.copyWith(
                    // color: AppColors.sucsess,
                  ),
                ),
                contentPadding: EdgeInsets.only(left: 20, right: 20),
                onTap: this.goViewMyConditions,
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
                onPressed: ()=> this.updateAcount(context: context),
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

          SizedBox(height: 12),
          
          // signout
          Center(
            child: Container(
              width: screenSize.width/2.4,
              child: RaisedButton(
                child: Text(
                  'Sign Out',
                ),
                onPressed: ()=> this.signOut(context: context),
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

          SizedBox(height: 20),

          // delete
          Center(
            child: Container(
              width: screenSize.width/2.4,
              child: RaisedButton(
                child: Text(
                  'Delete Account',
                ),
                onPressed: ()=> this.deleteAccount(context: context),
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


        ],
      ),
    );
  }// Widget build(BuildContext context) { .. }

  Widget detailText({ String text }) {
    return Text(
      text ?? '',
      style: TextStyle(
        fontSize: 24,
      ),
    );
  }//Widget detailText({ String text }) { .. }

}