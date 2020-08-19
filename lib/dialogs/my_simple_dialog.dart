import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyEasyDialog {
  static void infoDialog({
        @required BuildContext context,
        @required String title,
        @required String message,
        String dismissButtonText = 'OK',
        double dismissButtonFontSize = 20,
        double titleFontSize = 25,
      }) {
    if (Platform.isIOS) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return CupertinoAlertDialog(
            title: Center(child: new Text(title)),
            content: new Text(message),
            actions: <Widget>[
              CupertinoDialogAction(
                child: Text(
                  dismissButtonText,
                  textAlign: TextAlign.justify,
                ),
                onPressed: () => Navigator.of(context).pop(),
              )
            ],
          );
        },
      );
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          // return object of type Dialog
          return AlertDialog(
            title: Center(
                child: new Text(
              title,
              style: TextStyle(fontSize: titleFontSize, fontWeight: FontWeight.bold),
            )),
            content: new Text(
              message,
              textAlign: TextAlign.justify,
            ),
            actions: <Widget>[
              // usually buttons at the bottom of the dialog
              new FlatButton(
                child: new Text(
                  dismissButtonText,
                  style: TextStyle(fontSize: dismissButtonFontSize),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }

  static void dialogWithOptions({
    @required BuildContext context,
    @required String title,
    @required String message,
    String textLeftButton = 'OK',
    String textRightButton = 'Cancel',
    Function onPressedLeftButton,
    Function onPressedRightButton,
    bool isRightButtonADestructiveAction = true,
    double buttonFontSize = 20,
    double titleFontSize = 25
  }) {
    // flutter defined function
    if (Platform.isIOS) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          // return object of type Dialog
          return CupertinoAlertDialog(
            title: Center(child: new Text(title)),
            content: new Text(message),
            actions: <Widget>[
              CupertinoDialogAction(
                child: Text(
                  textLeftButton,
                  textAlign: TextAlign.justify,
                ),
                isDefaultAction: true,
                onPressed: onPressedLeftButton != null ? () => _popAndExecuteFunction(onPressedLeftButton, context) : () => Navigator.of(context).pop(),
              ),
              CupertinoDialogAction(
                child: Text(
                  textRightButton,
                  textAlign: TextAlign.justify,
                ),
                onPressed: onPressedRightButton != null ? () => _popAndExecuteFunction(onPressedRightButton, context) : () => Navigator.of(context).pop(),
                isDestructiveAction: isRightButtonADestructiveAction,
              ),
            ],
          );
        },
      );
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          // return object of type Dialog
          return AlertDialog(
            title: Center(
                child: new Text(
              title,
              style: TextStyle(fontSize: titleFontSize, fontWeight: FontWeight.bold),
            )),
            content: new Text(
              message,
              textAlign: TextAlign.justify,
            ),
            actions: <Widget>[
              // usually buttons at the bottom of the dialog
              new FlatButton(
                child: new Text(
                  textLeftButton,
                  style: TextStyle(fontSize: buttonFontSize),
                ),
                onPressed: onPressedLeftButton != null ? () => _popAndExecuteFunction(onPressedLeftButton, context) : () => Navigator.of(context).pop(),
              ),
              new FlatButton(
                child: new Text(
                  textRightButton,
                  style: TextStyle(fontSize: buttonFontSize, color: isRightButtonADestructiveAction ? Colors.redAccent : Colors.white),
                ),
                onPressed: onPressedRightButton != null ? () => _popAndExecuteFunction(onPressedRightButton, context) : () => Navigator.of(context).pop(),
              ),
            ],
          );
        },
      );
    }
  }

  static void _popAndExecuteFunction(Function function, BuildContext context) {
    Navigator.pop(context);
    function();
  }
}
