import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:withvscode/app/sign_in/email_sign_in_page.dart';
import 'package:withvscode/app/sign_in/sign_in_Button.dart';
import 'package:withvscode/app/sign_in/social_sign_in_Button.dart';
//import 'package:firebase_auth/firebase_auth.dart';
import 'package:withvscode/services/auth.dart';


class SignInPage extends StatelessWidget {


  SignInPage({@required this.auth});
   final AuthBase auth;

   Future<void> _signInAnonymously() async {
     try{await auth.signInAnonymously();
 
    } catch(e){
      print(e.toString());
    }

  }

  Future<void> _signInWithGoogle() async {
     try{await auth.signInWithGoogle();
 
    } catch(e){
      print(e.toString());
    }

  }

   Future<void> _signInWithFacebook() async {
     try{await auth.signInWithFacebook();

    } catch(e){
      print(e.toString());
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
         title: Text("CEEWHY Memory Backup"),
         elevation: 2.0,
       ),
      body: _buildContent(context),
    );
  }

  void _signInWithEmail(BuildContext context){
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        fullscreenDialog: true,
        builder: (context)=> EmailSignInPage(),
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("images/cy.jpeg"),
          fit: BoxFit.cover,
        ),
      ),
      padding: EdgeInsets.all(15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            "Sign In",
            textAlign: TextAlign.center,
            style: GoogleFonts.roboto(
              fontSize: 32.0,
              fontWeight: FontWeight.bold,
              color: Colors.pink,
            ),
          ),
          SizedBox(
            height: 48.0,
          ),
          SocialSignInButton(
            text: "Sign in with Google",
            textColor: Colors.black54,
            color: Colors.white,
            icon: "images/google-logo.png",
            onPressed: _signInWithGoogle,
          ),
          SizedBox(
            height: 8.0,
          ),
          SocialSignInButton(
            text: "Sign in with Facebook",
            icon: "images/facebook-logo.png",
            textColor: Colors.white,
            color: Colors.indigo,
            onPressed: _signInWithFacebook,
          ),
          SizedBox(
            height: 8.0,
          ),
          SocialSignInButton(
            text: "Sign in with Email",
            textColor: Colors.white,
            color: Colors.black,
            icon: "images/email-logo.png",
            onPressed: ()=>_signInWithEmail(context),
          ),
          SizedBox(
            height: 8.0,
          ),
          Text(
            "or",
            style: GoogleFonts.roboto(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
              color: Colors.pink,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 8.0,
          ),
          SignInButton(
            text: "Go anonymous",
            textColor: Colors.white,
            color: Colors.pinkAccent,            
            onPressed:_signInAnonymously,
            height: 70.0,
          ),

        ],
      ),
    );
  }


}



//  SignInPage({@required this.onSignIn});
//  final Function(FirebaseUser) onSignIn;
//
//   Future<void> _signInAnonymously() async {
//     try{ final authResult = await FirebaseAuth.instance.signInAnonymously();
//    onSignIn(authResult.user);
//    } catch(e){
//      print(e.toString());
//    }
//
//  }