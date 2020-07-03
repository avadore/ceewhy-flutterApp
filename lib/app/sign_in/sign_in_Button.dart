import 'package:flutter/material.dart';
import 'package:withvscode/common_widgets/custom_raised_button.dart';
import 'package:google_fonts/google_fonts.dart';

class SignInButton extends CustomRaisedButton {
  SignInButton(
      {@required String text,
      Color color,
      double height,
      Color textColor,
      VoidCallback onPressed})
      : assert(text != null),
        super(
          child: Text(
            text,
            style: GoogleFonts.roboto(fontSize: 16.0, color: textColor),
          ),
          color: color,
          onPressed: onPressed,
          height: height,
        );
}
