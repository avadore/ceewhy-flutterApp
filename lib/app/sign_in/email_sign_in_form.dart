

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:withvscode/app/sign_in/validators.dart';
import 'package:withvscode/common_widgets/form_submit_button.dart';
import 'package:withvscode/services/auth.dart';

enum EmailSignInFormType { signIn, register }

class EmailSignInForm extends StatefulWidget with EmailAndPasswordValidators {
  EmailSignInForm({@required this.auth});
  final AuthBase auth;
  @override
  _EmailSignInFormState createState() => _EmailSignInFormState();
}

class _EmailSignInFormState extends State<EmailSignInForm> {


  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FocusNode _emailFocusedNode = FocusNode();
  final FocusNode _passwordFocusedNode = FocusNode();
  String get _email => _emailController.text;
  String get _password  => _passwordController.text;
  EmailSignInFormType _formType = EmailSignInFormType.signIn;
  bool _submitted = false;
  bool _isLoading = false;
void _submit() async{
  setState(() {
    _submitted = true;
    _isLoading = true;
  });
  print(_email);
  try {
    if (_formType == EmailSignInFormType.signIn) {
      await widget.auth.signInWithEmailAndPassword(_email, _password);
    } else {
      await widget.auth.createUserWithEmailAndPassword(_email, _password);
    }
    Navigator.of(context).pop();
  }
  catch(e){
    showDialog(
      context: context,
      builder: (context){
        return AlertDialog(
          title: Text("SignIn Failed"),
          content: Text(e.toString()),
          actions: <Widget>[
            FlatButton(
              child: Text("Ok"),
              onPressed: (){
                Navigator.of(context).pop();
              } ,
            )
          ],
        );
      }
    );
  }
  finally{
    setState(() {
      _isLoading = false;
    });
  }

}

void _toggleFormType(){
  setState(() {
    _submitted = false;
    _formType = _formType == EmailSignInFormType.signIn ?
    EmailSignInFormType.register : EmailSignInFormType.signIn;

    _emailController.clear();
    _passwordController.clear();

  });
}
void _emailEditingComplete (){
  final newFocusedNode = widget.emailValidator.isValid(_email) ?
  _passwordFocusedNode : _emailFocusedNode;
FocusScope.of(context).requestFocus(newFocusedNode);
}
  List<Widget> _buildchildren(){

  final primaryText =_formType ==EmailSignInFormType.signIn ?
      'Sign in' : 'Create an Account';
  final secondaryText = _formType ==EmailSignInFormType.signIn ?
      'Need an account ? Register' : "Have an Account ? Sign In";
  bool _submitEnabled = widget.emailValidator.isValid(_email) && widget.passwordValidator.isValid(_password) && !_isLoading;
//  bool _submitEnabled = _email.isNotEmpty && _password.isNotEmpty;
    return[
      _buildEmailTextField(),
      SizedBox(height: 8.0),   
      _buildPasswordTextField(),
      SizedBox(height: 8.0),
      FormSubmitButton(
        color: Colors.pinkAccent,
        text: primaryText,
        onPressed: _submitEnabled ? _submit : null ,
        textcolor: Colors.white,
      ),
      FlatButton(
        child: Text(secondaryText),
        onPressed: !_isLoading ? _toggleFormType : null,
      )

    ];
  }

  TextField _buildPasswordTextField() {
    bool _showError = _submitted && !widget.emailValidator.isValid(_password);
    return TextField(
      enabled: !_isLoading ,
      onChanged: (_password)=> _updateState(),
      onEditingComplete: _submit,
      focusNode: _passwordFocusedNode,
      textInputAction: TextInputAction.done,
      controller: _passwordController,
      obscureText: true,
      decoration: InputDecoration(
          labelStyle: GoogleFonts.roboto(fontSize: 16, color: Colors.red),
          labelText: "Password",
        errorText: _showError ? widget.invalidPasswordErrorText : null,
      ),
    );
  }

  TextField _buildEmailTextField() {
  bool _showError = _submitted && !widget.emailValidator.isValid(_email);
    return TextField(
      enabled: !_isLoading,
      focusNode: _emailFocusedNode,
      textInputAction: TextInputAction.next,
      keyboardType: TextInputType.emailAddress,
      autocorrect: false,
     onChanged: (_email)=> _updateState(),
     controller: _emailController,
      onEditingComplete: _emailEditingComplete,
      decoration: InputDecoration(
        labelStyle: GoogleFonts.roboto(fontSize: 16, color: Colors.red),
        labelText: "Email",
        hintText: "text@text.com",
        hintStyle: GoogleFonts.montserrat(fontSize: 18),
        errorText: _showError ? widget.invalidEmailErrorText : null,
      ),
    );
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

  _updateState() {
  setState(() {});
  }
}
