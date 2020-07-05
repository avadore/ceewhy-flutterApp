import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:withvscode/app/home_page.dart';
import 'package:withvscode/app/sign_in/sign_in.dart';
import 'package:withvscode/services/auth.dart';

class LandingPage extends StatefulWidget {
  LandingPage({@required this.auth});
  final AuthBase auth;
  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
//  FirebaseUser _user;
  User _user;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _checkCurrentUser();

  }

  Future<void> _checkCurrentUser() async{

    try {
//      FirebaseUser user = await FirebaseAuth.instance.currentUser();
//      User user = await auth.currentUser();
      User user = await widget.auth.currentUser(); // access dependency in a statefull widgget
      _updateUser(user);
    } catch (e) {
     print (e);
    }
  }

//  void _updateUser(FirebaseUser user) {
  void _updateUser(User user) {
//    print('User id : ${user.uid}');
    setState(() {
      _user = user;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_user == null) {
      return SignInPage(
        auth: widget.auth, // a new required parameter & we use widget.auth instead of just auth ( stateful widget )
        onSignIn: _updateUser,
//        onSignIn: (user) => _updateUser(user),
      );
    }
    return HomePage(
      auth: widget.auth, // a new required parameter & we use widget.auth instead of just auth ( stateful widget )
      onSignOut: () => _updateUser(null),
    ); // temporary placeholder
  }
}
