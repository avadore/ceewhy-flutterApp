import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:withvscode/common_widgets/platform_widgets.dart';

class PlatformAlertDialog extends PlatformWidget{


  PlatformAlertDialog({@required this.title, @required this.text, @required this.defaultActionText, this.cancelActionText})
  : assert(title != null),assert(text != null),assert(defaultActionText != null);
  final String title;
  final String text;
  final String defaultActionText;
  final String cancelActionText;

  Future<bool> show(BuildContext context) async{

    return Platform.isIOS ?
    await showCupertinoDialog<bool>(context: context, builder: (context) => this)
        :
    await showDialog<bool>(context: context,
        barrierDismissible: false, // makes impossible to dismiss dialog by taping outside
        builder: (context) => this)
    ;
  }



  @override
  Widget buildCupertinoWidget(BuildContext context) {

      return CupertinoAlertDialog(
        title: Text(title),
        content: Text(text),
        actions: _buildActions(context),

      );
  }

  @override
  Widget buildMaterialWidget(BuildContext context) {
  return AlertDialog(
    title: Text(title),
    content: Text(text),
    actions: _buildActions(context),

  );
  }



  List<Widget> _buildActions( BuildContext context) {
    final actions = <Widget>[];
    cancelActionText == null ? actions.add(null) :
        actions.add(PlatformAlertDialogAction(child: Text(cancelActionText), onPressed:()=>Navigator.of(context).pop(false)));
    actions.add(PlatformAlertDialogAction(child: Text(defaultActionText), onPressed: () => Navigator.of(context).pop(true)));
    return actions;
  }
}

class PlatformAlertDialogAction extends PlatformWidget {
  PlatformAlertDialogAction({this.child, this.onPressed});
  final Widget child;
  final VoidCallback onPressed;

  @override
  Widget buildCupertinoWidget(BuildContext context) {
    return CupertinoButton(
      child: child,
      onPressed: onPressed,
    );
  }

  @override
  Widget buildMaterialWidget(BuildContext context) {
    return FlatButton(
      child: child,
      onPressed: onPressed,
    );
  }


}