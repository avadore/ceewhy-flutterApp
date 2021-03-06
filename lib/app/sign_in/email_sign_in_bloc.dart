import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:withvscode/app/sign_in/email_sign_in_model.dart';
import 'package:withvscode/services/auth.dart';
class EmailSignInBloc{
  final AuthBase auth;

  EmailSignInBloc({@required this.auth});

  final StreamController<EmailSignInModel> _modelController = StreamController<EmailSignInModel>();
  Stream<EmailSignInModel> get modelStream => _modelController.stream;
  EmailSignInModel _model = EmailSignInModel();
  void dispose(){
    _modelController.close();
  }
  Future<void> submit() async {
   updateWith(submitted: true,isLoading: true);
      try {

      if (_model.formType == EmailSignInFormType.signIn) {
        await auth.signInWithEmailAndPassword(_model.email, _model.password);
      } else {
        await auth.createUserWithEmailAndPassword(_model.email, _model.password);
      }

    } catch (e) {
      rethrow;
    } finally {
      updateWith(isLoading: false);
    }
  }
  void updateWith({
  String email,
    String password,
    EmailSignInFormType formType,
    bool isLoading,
    bool submitted,
}){
    _model =_model.copyWith(
      email: email,
      formType: formType,
      password: password,
      isLoading: isLoading,
      submitted: submitted
    );
    _modelController.add(_model);
  }
}