import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_platform/get_platform/get_platform.dart';

class MyEasyDialog {
  /// The info dialog will only show a text, a message and a dismiss button
  static void infoDialog({
    @required BuildContext context,
    @required String title,
    @required String message,
    String dismissButtonText = 'OK',
    Color titleTextColor,
    Color messageTextColor,
    VoidCallback onPressed,

    /// you can change the dismiss button text
    double dismissButtonFontSize = 20,

    /// you can change the dismiss button font size too but only on android
    double titleFontSize = 25,

    /// you can change the title font size too but only on android
  }) {
    if (GetPlatform.isIos()) {
      /// This is to show the iOS dialog type with Cupertino Widgets
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
                /// Does buttons are only to dismiss so the only function is the navigator that pops.
                onPressed: () => _infoDialogFunction(context, onPressed),
              )
            ],
          );
        },
      );
    } else {
      showDialog(
        /// Here is the part to show the android version which is just a simple dialog
        context: context,
        builder: (BuildContext context) {
          // return object of type Dialog
          return AlertDialog(
            title: Center(
                child: new Text(
              title,
              style: TextStyle(
                  fontSize: titleFontSize,
                  fontWeight: FontWeight.bold,
                  color: titleTextColor),
            )),
            content: new Text(
              message,
              textAlign: TextAlign.justify,
              style: TextStyle(color: messageTextColor),
            ),
            actions: <Widget>[
              /// usually buttons at the bottom of the dialog
              new FlatButton(
                child: new Text(
                  dismissButtonText,
                  style: TextStyle(fontSize: dismissButtonFontSize),
                ),

                /// Does buttons are only to dismiss so the only function is the navigator that pops.
                onPressed: () => _infoDialogFunction(context, onPressed),
              ),
            ],
          );
        },
      );
    }
  }

  static void _infoDialogFunction(BuildContext context, VoidCallback function) {
    Navigator.of(context).pop();
    if (function != null) {
      function();
    }
  }

  /// Here is the dialog with options, it's useful if you want to pop up a dialog where you can choose between two
  /// options. One of them can be set as destructive action.
  static void dialogWithOptions(
      {@required BuildContext context,
      @required String title,
      @required String message,
      String textLeftButton = 'OK',
      Color titleTextColor,
      Color messageTextColor,

      /// You can change the dismiss button text
      String textRightButton = 'Cancel',

      /// You can change the other button text
      Function onPressedLeftButton,

      /// You can add your custom functions for the two buttons
      Function onPressedRightButton,
      bool isRightButtonADestructiveAction = true,

      /// If set to true, the right button will be considered as a destructive button and will be colored in red
      double buttonFontSize = 20,
      double titleFontSize = 25}) {
    // flutter defined function
    if (GetPlatform.isIos()) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          /// Cupertino dialogs
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

                /// This is the default action
                onPressed: onPressedLeftButton != null

                    /// If the function is null, we just pop the dialog.
                    ? () => _popAndExecuteFunction(onPressedLeftButton, context)
                    : () => Navigator.of(context).pop(),
              ),
              CupertinoDialogAction(
                child: Text(
                  textRightButton,
                  textAlign: TextAlign.justify,
                ),
                onPressed: onPressedRightButton != null

                    /// If the function is null, we just pop the dialog.
                    ? () =>
                        _popAndExecuteFunction(onPressedRightButton, context)
                    : () => Navigator.of(context).pop(),
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
          /// return object of type Dialog for android
          return AlertDialog(
            title: Center(
                child: new Text(
              title,
              style: TextStyle(
                  fontSize: titleFontSize,
                  fontWeight: FontWeight.bold,
                  color: titleTextColor),
            )),
            content: new Text(
              message,
              textAlign: TextAlign.justify,
              style: TextStyle(color: messageTextColor),
            ),
            actions: <Widget>[
              /// Usually buttons at the bottom of the dialog
              new FlatButton(
                child: new Text(
                  textLeftButton,
                  style: TextStyle(fontSize: buttonFontSize),
                ),
                onPressed: onPressedLeftButton != null

                    /// If the function is null, we just pop the dialog.
                    ? () => _popAndExecuteFunction(onPressedLeftButton, context)
                    : () => Navigator.of(context).pop(),
              ),
              new FlatButton(
                child: new Text(
                  textRightButton,
                  style: TextStyle(
                      fontSize: buttonFontSize,
                      color: isRightButtonADestructiveAction
                          ? Colors.redAccent
                          : Colors.white),
                ),
                onPressed: onPressedRightButton != null

                    /// If the function is null, we just pop the dialog.
                    ? () =>
                        _popAndExecuteFunction(onPressedRightButton, context)
                    : () => Navigator.of(context).pop(),
              ),
            ],
          );
        },
      );
    }
  }

  /// The function that will pop the dialog and execute the custom function we want to execute.
  static void _popAndExecuteFunction(Function function, BuildContext context) {
    Navigator.pop(context);
    function();
  }

  static void loadingDialog({
    @required BuildContext context,
    String title = "",
    Color titleTextColor,
    double titleFontSize = 25,
  }) {
    if (GetPlatform.isIos()) {
      /// This is to show the iOS dialog type with Cupertino Widgets
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return CupertinoAlertDialog(
            title: title.trim() != "" ? Center(child: new Text(title)) : null,
            content: new CupertinoActivityIndicator(),
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
                  style: TextStyle(
                      fontSize: titleFontSize,
                      fontWeight: FontWeight.bold,
                      color: titleTextColor),
                )
            ),
            content: new CircularProgressIndicator(),
          );
        },
      );
    }
  }
}
