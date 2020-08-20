import 'package:flutter/material.dart';

class CustomRaisedButton extends StatelessWidget {
  const CustomRaisedButton(
      {this.color, this.onPressed, this.height:70.0, this.borderRadius:8.0, this.child});

  final double borderRadius;
  final Widget child;
  final Color color;
  final double height;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
    height: height,
    child: RaisedButton(
      onPressed: onPressed,
      color: color,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(borderRadius)
        )
      ),
      child: child,
    ),
    );
  }
}
