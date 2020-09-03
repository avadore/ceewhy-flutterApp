import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:withvscode/app/sign_in/email_sign_in_bloc.dart';
import 'package:withvscode/app/sign_in/validators.dart';
import 'package:withvscode/auth_provider.dart';
import 'package:withvscode/common_widgets/form_submit_button.dart';
import 'package:withvscode/common_widgets/platform_exception_alert_dialog.dart';
import 'package:withvscode/services/auth.dart';

import 'email_sign_in_model.dart';

class EmailSignInFormBlocBased extends StatefulWidget
    with EmailAndPasswordValidators {
  final EmailSignInBloc bloc;
  static Widget create(BuildContext context){
    final AuthBase auth = Provider.of<AuthBase>(context);
    return Provider<EmailSignInBloc>(
      create: (context)=>EmailSignInBloc(auth: auth),
      child: Consumer<EmailSignInBloc>(
                  builder: (context, bloc, _) => EmailSignInFormBlocBased(bloc: bloc),
                ),
      dispose: (context,bloc) =>bloc.dispose()
    );
  }

  EmailSignInFormBlocBased({this.bloc});

  @override
  _EmailSignInFormBlocBasedState createState() =>
      _EmailSignInFormBlocBasedState();
}

class _EmailSignInFormBlocBasedState extends State<EmailSignInFormBlocBased> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FocusNode _emailFocusedNode = FocusNode();
  final FocusNode _passwordFocusedNode = FocusNode();


  @override
  void dispose() {
    _passwordController.dispose();
    _emailController.dispose();
    _emailFocusedNode.dispose();
    _passwordFocusedNode.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    try {
    await widget.bloc.submit();
      Navigator.of(context).pop();
    } on PlatformException catch (e) {
      PlatformExceptionAlertDialog(
        title: "Sign In Fail",
        exception: e,
      ).show(context);
    }
  }



  void _toggleFormType(EmailSignInModel model) {
    widget.bloc.updateWith(
      email: '',
      password: '',

      formType: model.formType== EmailSignInFormType.signIn
          ? EmailSignInFormType.register
          : EmailSignInFormType.signIn,
        isLoading: false,
      submitted: false,
    );
      _emailController.clear();
      _passwordController.clear();
  }

  void _emailEditingComplete(EmailSignInModel model) {
    final newFocusedNode = widget.emailValidator.isValid(model.email)
        ? _passwordFocusedNode
        : _emailFocusedNode;
    FocusScope.of(context).requestFocus(newFocusedNode);
  }

  List<Widget> _buildchildren(EmailSignInModel model) {
    final primaryText = model.formType == EmailSignInFormType.signIn
        ? 'Sign in'
        : 'Create an Account';
    final secondaryText = model.formType == EmailSignInFormType.signIn
        ? 'Need an account ? Register'
        : "Have an Account ? Sign In";
    bool _submitEnabled = widget.emailValidator.isValid(model.email) &&
        widget.passwordValidator.isValid(model.password) &&
        !model.isLoading;
//  bool _submitEnabled = _email.isNotEmpty && _password.isNotEmpty;
    return [
      _buildEmailTextField(model),
      SizedBox(height: 8.0),
      _buildPasswordTextField(model),
      SizedBox(height: 8.0),
      FormSubmitButton(
        color: Colors.pinkAccent,
        text: primaryText,
        onPressed: _submitEnabled ? _submit : null,
        textcolor: Colors.white,
      ),
      FlatButton(
        child: Text(secondaryText),
        onPressed: !model.isLoading ? ()=>  _toggleFormType(model) : null,
      )
    ];
  }

  TextField _buildPasswordTextField(EmailSignInModel model) {
    bool _showError = model.submitted && !widget.emailValidator.isValid(model.password);
    return TextField(
      enabled: !model.isLoading,
      onChanged: (password) => widget.bloc.updateWith(password: password ),
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

  TextField _buildEmailTextField(EmailSignInModel model) {
    bool _showError = model.submitted && !widget.emailValidator.isValid(model.email);
    return TextField(
      enabled: !model.isLoading,
      focusNode: _emailFocusedNode,
      textInputAction: TextInputAction.next,
      keyboardType: TextInputType.emailAddress,
      autocorrect: false,
      onChanged: (email) => widget.bloc.updateWith(email: email),
      controller: _emailController,
      onEditingComplete:()=> _emailEditingComplete(model),
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
    return StreamBuilder<EmailSignInModel>(
      stream: widget.bloc.modelStream,
      initialData: EmailSignInModel(),
      builder: (context, snapshot) {
        final EmailSignInModel model = snapshot.data;
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: _buildchildren(model),
          ),
        );
      }
    );
  }


}
