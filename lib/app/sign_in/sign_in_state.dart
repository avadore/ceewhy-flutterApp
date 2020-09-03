import 'package:flutter/widgets.dart';

class SignInState extends ChangeNotifier{
  bool _isLoading = false;
  bool getLoadingState()=>_isLoading;
  signingIn(){
    _isLoading = true;
    notifyListeners();
  }
  notSigningIn(){
    _isLoading = false;
    notifyListeners();
  }
}