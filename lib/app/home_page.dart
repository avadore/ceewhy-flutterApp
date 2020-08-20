import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:withvscode/auth_provider.dart';
import 'package:withvscode/common_widgets/platform_alert_dialog.dart';

class HomePage extends StatelessWidget {
  Future<void> _signOut(BuildContext context) async {
    try {
      final auth = AuthProvider.of(context);
      await auth.signOut();
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> _confirmSignOut(BuildContext context) async {
    final didRequestSignOut = await PlatformAlertDialog(
      title: "Sign Out",
      text: "Are you sure you want to Sign out",
      defaultActionText: 'Yes',
      cancelActionText: 'No',
    ).show(context);
    // ignore: unnecessary_statements
    didRequestSignOut ? _signOut(context) : null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Homepage'),
        actions: <Widget>[
          FlatButton(
            child: Text(
              'Log Out',
              style: GoogleFonts.roboto(fontSize: 18, color: Colors.white),
            ),
            onPressed: ()=>_confirmSignOut(context),
          ),
        ],
      ),
    );
  }
}
