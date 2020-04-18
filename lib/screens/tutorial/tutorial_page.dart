import 'package:flutter/material.dart';


class TutorialPage extends StatelessWidget {
  
  String title;
  String subTitle;
  String image;
  Widget cta;
  Size screenSize;
  Color color;

  TutorialPage({ 
    this.title, this.subTitle, this.image, this.cta, 
    this.screenSize, this.color, 
  });


  @override
  Widget build(BuildContext context) {
    return Container(
      color: color,
      padding: EdgeInsets.only(left: 20, right: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[

          SizedBox( height: screenSize.height/10, ),

          // image
          Center(
            child: CircleAvatar(
              radius: screenSize.width/3,
              backgroundImage: AssetImage(
                image,
              ),
            ),
          ),

          SizedBox( height: screenSize.height/20, ),

          // title
          Center(
            child: Text(
              title,
              style: Theme.of(context).textTheme.display4,
            ),
          ),
          
          SizedBox( height: screenSize.height/40, ),

          // subtitle
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              subTitle,
              style: Theme.of(context).textTheme.display1.copyWith(
                fontSize: 22,
                fontWeight: FontWeight.w400
              ),
              textAlign: TextAlign.center,
            ),
          ),

          SizedBox( height: screenSize.height/20, ),

          // cta if any
          cta == null  ? Container() : Center(child: cta,),

        ],
      ),
    );
  }
}