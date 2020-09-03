
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:withvscode/app/home_page.dart';
import 'package:withvscode/app/sign_in/sign_in.dart';
import 'package:withvscode/app/sign_in/sign_in_state.dart';
import 'package:withvscode/auth_provider.dart';
import 'package:withvscode/services/auth.dart';

class LandingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthBase>(context);
    return StreamBuilder(
        stream: auth.onAuthStateChanged,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            User user = snapshot.data;
            if (user == null) {
              return SignInPage.create(context);

            }
            return HomePage();
          } else
            return Scaffold(
              body: Center(
                child: CircularProgressIndicator(
                  strokeWidth: 8,
                ),
              ),
            );
        });
  }
}
