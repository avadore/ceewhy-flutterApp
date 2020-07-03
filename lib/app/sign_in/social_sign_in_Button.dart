import 'package:flutter/material.dart';
import 'package:withvscode/common_widgets/custom_raised_button.dart';
import 'package:google_fonts/google_fonts.dart';


class SocialSignInButton extends CustomRaisedButton {
  SocialSignInButton(
      {@required String text, Color color, double height,@required String icon, Color textColor, VoidCallback onPressed})
      : assert(icon != null),
        assert(text != null ), super(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Image.asset(icon,
              scale: 1.5),
              Text(
                text,
                style: GoogleFonts.roboto(fontSize: 16.0, color:textColor),
              ),
              Opacity(
                opacity: 0.0,
                child: Image.asset(icon,scale: 1.5)),
            ],
          ),
          color: color,
          onPressed: onPressed,
          height : 55.0,
        );
}
