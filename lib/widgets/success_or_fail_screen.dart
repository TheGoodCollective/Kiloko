import 'package:flutter/material.dart';



class SuccessOrFailScreen extends StatelessWidget {
  final String wooShortText;
  final String wooText;
  final String assetPath;
  final Widget cta;
  final bool isSuccess;
  final Widget extraWidget;

  SuccessOrFailScreen({ 
    @required this.wooShortText, 
    @required this.wooText, 
    @required this.assetPath, 
    @required this.cta, 
    this.extraWidget,
    Key key, 
    this.isSuccess=false,
  }) : super(key: key);

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
              backgroundImage: AssetImage(assetPath),
            ),
          ),

          SizedBox(height: 40),

          // text
          Text(
            wooShortText,
            style: Theme.of(context).textTheme.body1,
            textAlign: TextAlign.center,
          ),

          SizedBox(height: 16,),
          
          Text(
            wooText,
            style: Theme.of(context).textTheme.body1,
            textAlign: TextAlign.center,
          ),

          SizedBox(height: 24),

          cta,
          
          SizedBox(height: 24),

          extraWidget == null ? Container() :  extraWidget,
          
        ]
    );
  }// Widget build(BuildContext context) { .. }


}