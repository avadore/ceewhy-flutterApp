import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:provider/provider.dart';
import 'package:withvscode/app/sign_in/email_sign_in_page.dart';
import 'package:withvscode/app/sign_in/sign_in_Button.dart';
import 'package:withvscode/app/sign_in/sign_in_bloc.dart';
import 'package:withvscode/app/sign_in/sign_in_state.dart';
import 'package:withvscode/app/sign_in/social_sign_in_Button.dart';
import 'package:withvscode/common_widgets/platform_exception_alert_dialog.dart';
import 'package:withvscode/services/auth.dart';

class SignInPage extends StatelessWidget {
  const SignInPage ({Key key, @required this.bloc}): super(key: key);
  final SignInBloc bloc;
  static Widget create(BuildContext context){
    final auth = Provider.of<AuthBase>(context);
    return Provider<SignInBloc>(
      create: (_) => SignInBloc(auth: auth),
      dispose:(context,bloc)=>bloc.dispose() ,
      child: Consumer<SignInBloc>(
                  builder: (context, bloc ,_) => SignInPage(bloc: bloc)
                ),
    );
  }
  void _showSignInError(BuildContext context, PlatformException exception){
    print("the error is ${exception.code}");
    if (exception.code!= 'error aborted by user'){
    PlatformExceptionAlertDialog(
      title: "Sign In Failed",
      exception: exception,
    ).show(context);}
  }



   Future<void> _signInAnonymously(BuildContext context) async {  
     try{
       await bloc.signInAnonymously(); 
    } catch(e){
      print(e.toString());
    }
  }
  Future<void> _signInWithGoogle(BuildContext context) async {
     try{
     await bloc.signInWithGoogle(); 
    } on PlatformException catch(e){
       _showSignInError(context,e);
    }
  }
   Future<void> _signInWithFacebook(BuildContext context) async {
     try{    
       await bloc.signInWithFacebook();
    } on PlatformException catch(e){
       _showSignInError(context,e); 
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
   
      body: StreamBuilder<Object>(
        stream: bloc.isLoadingStream,
        initialData: false,
        builder: (context, snapshot) {
          return _buildContent(context,snapshot.data);
        }
      ),
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

  Widget _buildContent(BuildContext context, bool isLoading) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("images/cy.jpeg"),
          fit: BoxFit.cover,
        ),
      ),
      padding: EdgeInsets.all(15.0),
      child: Consumer<SignInBloc>(
        builder: (context, data, child) {
          if (isLoading==true){
            return Center(child: Padding(
              padding: const EdgeInsets.all(40.0),
              child: LoadingIndicator(indicatorType: Indicator.ballRotateChase, color: Colors.pink),
            ));
          }
          return Column(
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
                onPressed: () => _signInWithGoogle(context),
              ),
              SizedBox(
                height: 8.0,
              ),
              SocialSignInButton(
                text: "Sign in with Facebook",
                icon: "images/facebook-logo.png",
                textColor: Colors.white,
                color: Colors.indigo,
                onPressed: () => _signInWithFacebook(context),
              ),
              SizedBox(
                height: 8.0,
              ),
              SocialSignInButton(
                text: "Sign in with Email",
                textColor: Colors.white,
                color: Colors.black,
                icon: "images/email-logo.png",
                onPressed: () => _signInWithEmail(context),
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
                onPressed: () => _signInAnonymously(context),
                height: 70.0,
              ),

            ],
          );
        },
      ),
    );
  }


}



