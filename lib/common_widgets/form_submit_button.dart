import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:withvscode/common_widgets/custom_raised_button.dart';

class FormSubmitButton extends CustomRaisedButton{
  FormSubmitButton({
    @required String text,
    Color color,
    VoidCallback onPressed,
    Color textcolor,
  }): super(
    child: Text(
      text,
      style: GoogleFonts.roboto(color: textcolor, fontSize:20.0),

    ),
    height:44.0,
    onPressed:onPressed,
    color: color
  );
}