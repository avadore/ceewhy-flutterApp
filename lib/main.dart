import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:withvscode/app/landing_page.dart';
import 'package:withvscode/auth_provider.dart';
import 'package:withvscode/services/auth.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Provider<AuthBase>(
      //create is composary instead of builder
      create: (context) =>Auth(),
      child: MaterialApp(
        title: 'CEEWHY tracker',
        theme: ThemeData(
          primaryColor: Colors.pink,
        ),
        home: LandingPage(),
      ),
    );
  }
}
