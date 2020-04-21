import 'package:flutter/material.dart';
import 'package:kiloko/config/app_routes.dart';
import 'package:kiloko/config/app_utils.dart';
import 'package:kiloko/providers/account_provider.dart';
import 'package:kiloko/services/account_service.dart';
import 'package:provider/provider.dart';
import 'package:kiloko/models/account.dart';
import 'package:kiloko/widgets/app_scaffold.dart';
import 'package:validators/validators.dart' as Validators;
import 'package:regexed_validator/regexed_validator.dart' as RValidator;
import 'package:kiloko/widgets/success_or_fail_screen.dart';


class RegisterScreen extends StatefulWidget {
  final String from;

  RegisterScreen({ this.from });
  
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _isRegisterSuccessful = false;
  Account _account = new Account();
  bool _showPassword = false;
  AccountProvider _accountProvider;

  @override
  void initState() {
    super.initState();
    // this._gtD();
  }

  // _gtD() async {
  //   AccountService accountService = AccountService();
  //   Account acc = await accountService.getUserDetails(account: Account(id: 'kJhP2EwlPgQd1daJkmkLAjLLWAn1'));
  //   print('_gtD got user');
  //   print(acc);
  // }
  
  @override
  Widget build(BuildContext context) {
    _accountProvider = Provider.of<AccountProvider>(context, listen: false);

    return Scaffold(
      
      appBar: AppBar(
        title: Text('Register'),
        centerTitle: true,
      ),

      body: AppScaffold(

        children: <Widget>[

          this._isRegisterSuccessful == false
            ?
            Consumer<AccountProvider> (
              builder: (BuildContext ctx, AccountProvider accountProvdr, _) {

                return buildForm(
                  context: context, account: accountProvdr.account
                );
              },
            )
            :
            _buildSuccessWidget(context: context)

        ],

      ),
      
      floatingActionButton: 
        this._isRegisterSuccessful == null || this._isRegisterSuccessful == false 
          ? Container(
            margin: EdgeInsets.only(top: 16),
            child: FlatButton(
              child: Text(
                'Already have an account? Login here.',
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
              onPressed: ()=> this._goLogin(context: context),
              textColor: Colors.cyan,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24),
              ),
              padding: EdgeInsets.symmetric(vertical: 8),
            ),
          ) : Container(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Widget _buildSuccessWidget({ @required BuildContext context }) {
    Size screenSize = MediaQuery.of(context).size;

    return SuccessOrFailScreen(
      wooShortText: 'Account Created',
      wooText: 'Welcome to Kiloko. You just joined the global movement to save earth',
      isSuccess: true,
      cta: Container(
        width: screenSize.width/4,
        child: OutlineButton(
          onPressed: ()=> this._goBack(context: context),
          child: Text('Proceed'),
          borderSide: BorderSide(
            color: AppColors.secondary
          ),
          textColor: AppColors.primary,
          padding: EdgeInsets.symmetric(vertical: 8),
        ),
      ),
      assetPath: 'assets/images/one.jpg',
      extraWidget: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[

          SizedBox(height: 40,),
          
          Center(
            child: Text(
              'Your privacy is guaranteed. People only know you by your Kiloko ID',
              style: Theme.of(context).textTheme.body1.copyWith(
                fontSize: 18
              ),
              textAlign: TextAlign.center,
            ),
          ),
          
          SizedBox(height: 16),

          Center(
            child: Text(
              'Finish your profile by adding any conditions or medications you are taking',
              style: Theme.of(context).textTheme.body1.copyWith(
                fontSize: 18
              ),
              textAlign: TextAlign.center,
            ),
          ),

          SizedBox(height: 24,),

          Center(
            child: FloatingActionButton.extended(
              label: Text(
                'Add Medications and Conditions',
                style: Theme.of(context).textTheme.body1.copyWith(
                  fontSize: 16
                ),
              ),
              onPressed: ()=> this._goAddMedicationsAndConditions(context: context),
            ),
          )

        ],
      ),
    );
  }// Widget _buildSuccessWidget({ BuildContext context }) { .. }
  
  // build the form
  Widget buildForm({ 
    @required Account account, @required BuildContext context}) {
    Size screenSize = MediaQuery.of(context).size;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[

        SizedBox(height: screenSize.height/16),

        Container(
          padding: EdgeInsets.symmetric(horizontal: screenSize.width/8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[

              // woo text 
              Text(
                'Login to participate in the global effort to flatten the curve. Join the movement.',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                ),
                textAlign: TextAlign.center,
              ),

              SizedBox(height: 56),

              // form
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[

                    Center(
                      child: Text(
                        'Kiloko ID',
                        style: Theme.of(context).textTheme.title.copyWith(
                          fontWeight: FontWeight.w800
                        ),
                      ),
                    ),

                    SizedBox(height: 10,),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[

                        Icon(
                          Icons.security,
                          color: AppColors.primary,
                          size: 32,
                        ),
                        SizedBox(width: 8,),

                        Text(
                          account.kilokoID.toString(),
                          style: Theme.of(context).textTheme.subhead.copyWith(
                            color: AppColors.primary,
                            fontSize: 28,
                            fontWeight: FontWeight.w600
                          ),
                        ),

                      ],
                    ),
                                    
                    SizedBox(height: 28,),

                    // name
                    TextFormField(
                      keyboardType: TextInputType.text,
                      autofocus: false,
                      decoration: InputDecoration(
                        labelText: 'Enter you name',
                        prefixIcon: Icon(Icons.person_outline),
                        hintText: 'Kelly Anton',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(48.0),
                          borderSide: BorderSide(),
                        ),
                        contentPadding: EdgeInsets.symmetric(horizontal: 24, vertical: 18),
                      ),
                      style: Theme.of(context).textTheme.body1,
                      validator: this._nameValidator,
                      onSaved: (String val)=> this._account.name = val,
                    ),
                    
                    SizedBox(height: 28),
                    // email
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      autofocus: false,
                      decoration: InputDecoration(
                        labelText: 'Enter you email',
                        prefixIcon: Icon(Icons.email),
                        hintText: 'kellyanton@kiloko.com',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(48.0),
                          borderSide: BorderSide(),
                        ),
                        contentPadding: EdgeInsets.symmetric(horizontal: 24, vertical: 18),
                      ),
                      style: Theme.of(context).textTheme.body1,
                      validator: this._emailValidator,
                      onSaved: (String val)=> this._account.email = val,
                    ),
                    
                    SizedBox(height: 28),
                    
                    // phone
                    TextFormField(
                      keyboardType: TextInputType.phone,
                      autofocus: false,
                      decoration: InputDecoration(
                        labelText: 'Enter you phone',
                        prefixIcon: Icon(Icons.phone),
                        hintText: '+01588610100',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(48.0),
                          borderSide: BorderSide(),
                        ),
                        contentPadding: EdgeInsets.symmetric(horizontal: 24, vertical: 18),
                      ),
                      style: Theme.of(context).textTheme.body1,
                      validator: this._phoneValidator,
                      onSaved: (String val)=> this._account.phone = val,
                    ),
                                       
                    SizedBox(height: 28),
                    
                    Padding(
                      padding: EdgeInsets.only(left: 12),
                      child: Text(
                        'Optional',
                        style: Theme.of(context).textTheme.body1.copyWith(
                          fontSize: 14,
                          color: AppColors.error,
                        ),
                      ),
                    ),
                    SizedBox(height: 8,),
                    // national id
                    TextFormField(
                      keyboardType: TextInputType.number,
                      autofocus: false,
                      decoration: InputDecoration(
                        labelText: 'Enter you national id',
                        prefixIcon: Icon(Icons.credit_card),
                        hintText: '588610100',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(48.0),
                          borderSide: BorderSide(),
                        ),
                        contentPadding: EdgeInsets.symmetric(horizontal: 24, vertical: 18),
                      ),
                      style: Theme.of(context).textTheme.body1,
                      validator: this._nationalIDValidator,
                      onSaved: (String val)=> this._account.nationalID = val,
                    ),
                                       
                    SizedBox(height: 28),

                    // password
                    TextFormField(
                      keyboardType: TextInputType.text,
                      obscureText: _showPassword ? false : true,
                      autofocus: false,
                      decoration: InputDecoration(
                        labelText: 'Enter you password',
                        prefixIcon: Icon(Icons.lock_outline),
                        suffixIcon: IconButton(
                          icon: Icon(Icons.remove_red_eye), 
                          onPressed: ()=> this.setState(()=> this._showPassword = !this._showPassword),
                          splashColor: Colors.cyan[200],
                          highlightColor: Colors.cyan[200],
                        ),
                        hintText: '************',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(48.0),
                          borderSide: BorderSide(),
                        ),
                        contentPadding: EdgeInsets.symmetric(horizontal: 24, vertical: 18),
                      ),
                      style: Theme.of(context).textTheme.body1,
                      validator: this._passwordValidator,
                      onSaved: (String val)=> this._account.password = val,
                    ),

                    SizedBox(height: 56),

                    // submit button
                    Row(
                      children: <Widget>[
                        Expanded(
                          flex: 1,
                          child: Container(
                            height: 48,
                            child: RaisedButton(
                              child: Text(
                                'Create Account Now',
                                style: TextStyle(
                                  fontSize: 18,
                                ),
                              ),
                              padding: EdgeInsets.symmetric(vertical: 8),
                              onPressed: this._register,
                              
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

                  ],
                ) 
              ),


            ],
          ),
        ),

      ],
    );
  }// Widget buildForm({ BuildContext context}) { .. }






  Future<void> _register() async{
    print('register');
    
    if( this._formKey.currentState.validate() ) { print('form is valid');
      this._formKey.currentState.save();
    } else {
      return; 
    }

    print('email ${this._accountProvider.account.kilokoID}');
    print('password ${this._account.password}');
    this._account.kilokoID = this._accountProvider.account.kilokoID;
    Account accnt = await this._accountProvider.register(
      account: this._account);

    if( accnt == null ) {
      print('an error occured _register');
    } else {
      print('account created ');
      print(accnt);
    }
    if( accnt != null ) {
      setState(()=> this._isRegisterSuccessful = true );
      return;
    } 
    setState(()=> this._isRegisterSuccessful = false );
  }// void _register() { .. }

  void _goLogin({ BuildContext context }) {
    Navigator.of(context).pushNamed(AppRoutes.LOGIN);
  }// void _goLogin({ BuildContext context }) { .. }

  void _goBack({ BuildContext context }) {
    Navigator.of(context).pop();
  }

  void _goAddMedicationsAndConditions({ BuildContext context}) {
    Navigator.of(context).pushNamed(AppRoutes.ADD_CONDITIONS_AND_MEDICATION);
  }// void _goAddMedicationsAndConditions({ BuildContext context}) { .. }


  /*
   ** data validators
   */
  
  String _nameValidator(String val) {
    val = val.trim();
    if( val.isEmpty ) return 'You should enter a name to proceed';
    if( val.length < 5 ) return 'Name should be atleast 5 characters long';
  }
  String _emailValidator(String val) {
    val = val.trim();
    if( val.isEmpty ) return 'You should enter an email to proceed';
    if( !Validators.isEmail(val) ) return 'Please enter a valid email';
  }
  String _phoneValidator(String val) {
    val = val.trim();
    if( val.isEmpty ) return 'You should enter your phone number to proceed';
    // if( !Validators.matches(val, RegExp("/^[+]*[(]{0,1}[0-9]{1,4}[)]{0,1}[-\s\./0-9]*$/g")) ) return 'Please enter a valid phone number';
    if( !RValidator.validator.phone(val) ) return 'Please enter a valid phone number';
  }
  String _passwordValidator(String val) {
    val = val.trim();
    if( val.isEmpty ) return 'You should enter a password to proceed';
    if( val.length < 6 ) return 'Password should be atleast 6 characters long';
    if( !Validators.isAlphanumeric(val) ) return 'Password should contain atleast 1 letter and 1 number';
  }
  
  String _nationalIDValidator(String val) {
    val = val.trim();
    // if( val.isEmpty ) return 'You should enter a national id to proceed';
    if( val.isNotEmpty && val.length < 6 ) return 'Your national id should be at least 6 numbers';
    if( val.length > 0 && !Validators.isInt(val) ) return 'Please enter a valid national id';
  }
  

}