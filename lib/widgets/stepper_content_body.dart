import 'package:flutter/material.dart';

class StepperContentBody extends StatelessWidget {
  final List<Widget> children;
  final double horizontalPadding;
  final double verticalPadding;

  StepperContentBody({
    @required this.children, 
    this.horizontalPadding=8.0, 
    this.verticalPadding=16.0
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: horizontalPadding, 
        vertical: verticalPadding
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          ...children,
          SizedBox(height: 80),
        ],
      )
    );
  }
}