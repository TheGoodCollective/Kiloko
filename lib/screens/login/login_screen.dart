import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:kiloko/models/account.dart';
// import 'package:kiloko/providers/account_provider.dart';
import 'package:kiloko/widgets/app_scaffold.dart';
import 'package:validators/validators.dart' as Validators;
import 'package:kiloko/widgets/success_or_fail_screen.dart';


class LoginScreen extends StatefulWidget {
  final String from;

  LoginScreen({ this.from });
  
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _isLoginSuccessful = false;
  Account _account = new Account();
  bool _showPassword = false;
  // AccountProvider _accountProvider;

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    // _accountProvider = Provider.of<AccountProvider>(context, listen: false);

    return Scaffold(
      
      appBar: AppBar(
        title: Text('Login'),
        centerTitle: true,
      ),

      body: AppScaffold(

        children: <Widget>[

          this._isLoginSuccessful == false
            ?
            buildForm(context: context)
            :
            SuccessOrFailScreen(
              isSuccess: true,
              cta: RaisedButton(
                onPressed: this._goBack,
                child: Text('Proceed'),
              ),
              assetPath: 'assets/images/404.jpg',
              wooShortText: 'You have successful',
              wooText: 'Build your little hollywood dream with VIDA',
            )
            
        ],

      ),
      
      floatingActionButton:  Container(
          margin: EdgeInsets.only(top: 16),
          child: FlatButton(
            child: Text(
              'Don\'t have an account? Create one here.',
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            onPressed: ()=> this._goRegister(context: context),
            textColor: Colors.cyan,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24),
            ),
          ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  
  
  // login
  Widget buildForm({ BuildContext context }) {
    Size screenSize = MediaQuery.of(context).size;

    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[

          SizedBox(height: screenSize.height/8),

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
                      
                      // email
                      TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        autofocus: false,
                        decoration: InputDecoration(
                          labelText: 'Enter you Kiloko ID',
                          prefixIcon: Icon(Icons.security),
                          hintText: 'ki-xeWEwfxEqweD',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(48.0),
                            borderSide: BorderSide(),
                          ),
                          contentPadding: EdgeInsets.symmetric(horizontal: 24, vertical: 18),
                        ),
                        validator: this._kilokoIDValidator,
                        onSaved: (String val)=> this._account.kilokoID = val,
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
                          hintText: 'kellyanton@yahoo.com',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(48.0),
                            borderSide: BorderSide(),
                          ),
                          contentPadding: EdgeInsets.symmetric(horizontal: 24, vertical: 18),
                        ),
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
                                  'Login Now',
                                  style: TextStyle(
                                    fontSize: 18,
                                  ),
                                ),
                                onPressed: this._login,
                                
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
  }// Widget buildForm({ BuildContext context }) { .. }





  void _login() async {
    print('login');
    
    if( this._formKey.currentState.validate() ) { print('form is valid');
      this._formKey.currentState.save();
    } else {
      return; 
    }

    print('email ${this._account.kilokoID}');
    print('password ${this._account.password}');
    // Account accnt = await this._accountProvider.loginWithEmailAndPassword(account: this._account);
    // if( accnt != null ) {
    //   this.setState(()=> this._isLoginSuccessful = true );
    //   return;
    // }
  }// void _login() { .. }

  void _goRegister({ BuildContext context }) {
    Navigator.of(context).pushNamed('/register', arguments: widget.from);
  }// void _goRegister({ BuildContext context }) { .. }
  
  void _goBack({ BuildContext context }) {
    Navigator.of(context).pop();
  }

   
  /*
   * data validators
   */
  String _kilokoIDValidator(String val) {
    val = val.trim();
    if( val.isEmpty ) return 'You should enter an ID to login';
    if( val.length < 5) return 'Please enter a valid kiloko ID';
  }
  String _passwordValidator(String val) {
    val = val.trim();
    if( val.isEmpty ) return 'You should enter a password to login';
    if( val.length < 6 ) return 'Password should be atleast 6 characters long';
  }

}