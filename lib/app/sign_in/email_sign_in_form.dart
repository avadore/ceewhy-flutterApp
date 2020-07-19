import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:withvscode/common_widgets/form_submit_button.dart';
class EmailSignInForm extends StatelessWidget {

String email;
void _submit(){
  print(email);
}

  List<Widget> _buildchildren(){
    return[
      TextField(
        onChanged: (value) => email = value,
        decoration: InputDecoration(
          labelStyle: GoogleFonts.roboto(fontSize: 16, color: Colors.red),
          labelText: "Email",
          hintText: "text@text.com",
          hintStyle: GoogleFonts.montserrat(fontSize: 18)
        ),
      ),
      SizedBox(height: 8.0),
      TextField(
  obscureText: true,
        decoration: InputDecoration(
            labelStyle: GoogleFonts.roboto(fontSize: 16, color: Colors.red),
            labelText: "Password",
        ),
      ),
      SizedBox(height: 8.0),
      FormSubmitButton(
        color: Colors.pinkAccent,
        text: 'Sign In',
        onPressed: _submit,
        textcolor: Colors.white,
      ),
      FlatButton(
        child: Text('Create an Account here'),
        onPressed: () {},
      )

    ];
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: _buildchildren(),
      ),
    );
  }
}
