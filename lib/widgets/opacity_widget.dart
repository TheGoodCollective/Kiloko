import 'package:flutter/material.dart';


class OpacityWidget extends AnimatedWidget {
 final Widget child;

  OpacityWidget({ Key key, this.child, Animation animation }): super(
    key: key, listenable: animation,
  );
  
  @override
  Widget build(BuildContext context) {
    Animation<double> animation = listenable;

    return AnimatedBuilder(
      animation: animation,
      child: child,
      builder: (ctx, chld) {
        
        return Opacity(
          opacity: animation.value,
          child: chld,
        );
      },
    );
  }// Widget build(BuildContext context) { .. }

}