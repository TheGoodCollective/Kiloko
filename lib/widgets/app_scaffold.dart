import 'package:flutter/material.dart';


class AppScaffold extends StatelessWidget {
  List<Widget> children = [];
  Widget appBar;

  AppScaffold({ this.children, this.appBar, });
  

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: ListView(
          children: <Widget> [
            
            appBar ?? Container(),

            Container(
              padding: EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 4.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: children,
              ),
            ),

          ]
        ),
      ),
    );
  }// Widget build(BuildContext context) { .. }
}