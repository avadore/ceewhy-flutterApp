import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:withvscode/services/auth.dart';


class HomePage extends StatelessWidget {
//  HomePage({@required this.onSignOut});
//  final VoidCallback onSignOut;
//
//  Future<void> _signOut() async {
//    try{ await FirebaseAuth.instance.signOut();
//    onSignOut();
//
//    } catch(e){
//      print(e.toString());
//    }
//
//  }


  HomePage({@required this.auth,@required this.onSignOut});
  final VoidCallback onSignOut;
  final AuthBase auth;

  Future<void> _signOut() async {
    try{ await auth.signOut();
    onSignOut();

    } catch(e){
      print(e.toString());
    }

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Homepage'),
        actions: <Widget>[
          FlatButton(
            child: Text('Log Out', style: GoogleFonts.roboto(
              fontSize: 18, color: Colors.white
            ),),
            onPressed: _signOut,
          ),
        ],
      ),
    );
  }
}
