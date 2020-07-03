import 'package:flutter/material.dart';
import 'app/sign_in/sign_in.dart';

void main()=>runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CEEWHY tracker',
      theme: ThemeData(
        primaryColor: Colors.pink,
      ),
  home: SignInPage(),    
    );
  }
}