import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyEasyDialog {

  /// The info dialog will only show a text, a message and a dismiss button
  static void infoDialog({
    required BuildContext context,
    required String title,
    required String message,
    String dismissButtonText = 'OK',
    VoidCallback? onPressed,

    /// you can change the dismiss button text
    double dismissButtonFontSize = 20,

    /// you can change the dismiss button font size too but only on android
    double titleFontSize = 25,

    /// You can change all the colors
    Color? titleTextColor,
    Color? messageTextColor,
    Color dismissAndroidButtonColor = Colors.lightBlue
  }) {
    /// This is to show the iOS dialog type with Cupertino Widgets
    if (Platform.isIOS) {

      /// Cupertino dialogs
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return CupertinoAlertDialog(
            title: Center(child: new Text(title)),
            content: new Text(message, style: TextStyle(color: titleTextColor),),
            actions: <Widget>[
              CupertinoDialogAction(
                child: Text(
                  dismissButtonText,
                  textAlign: TextAlign.justify,
                  style: TextStyle(color: messageTextColor),
                ),
                onPressed: () {
                  /// Does buttons are only to dismiss so the only function is the navigator that pops.
                  Navigator.pop(context);
                  if (onPressed != null) {
                    onPressed();
                  }
                },
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
                  style: TextStyle(
                      fontSize: titleFontSize,
                      fontWeight: FontWeight.bold,
                      color: titleTextColor == null ? Colors.grey.shade800 : titleTextColor),
                )),
            content: new Text(
              message,
              textAlign: TextAlign.justify,
              style: TextStyle(color: messageTextColor == null ? Colors.grey.shade800 : messageTextColor),
            ),
            actions: <Widget>[
              new TextButton(
                /// usually buttons at the bottom of the dialog
                child: new Text(
                  dismissButtonText,
                  style: TextStyle(fontSize: dismissButtonFontSize, color: dismissAndroidButtonColor),
                ),
                onPressed: () {
                  Navigator.pop(context);
                  /// Does buttons are only to dismiss so the only function is the navigator that pops.
                  if (onPressed != null) {
                    onPressed();
                  }
                },
              ),
            ],
          );
        },
      );
    }
  }

  /// Here is the dialog with options, it's useful if you want to pop up a dialog where you can choose between two
  /// options. One of them can be set as destructive action.
  static void dialogWithOptions(
      {required BuildContext context,
        required String title,
        required String message,
        String textLeftButton = 'OK',
        Color? titleTextColor,
        Color? messageTextColor,

        /// You can change the dismiss button text
        String textRightButton = 'Cancel',
        Function? onPressedLeftButton,
        Function? onPressedRightButton,

        /// If set to true, the right button will be considered as a destructive button and will be colored in red
        bool isRightButtonADestructiveAction = true,
        double buttonFontSize = 20,
        double titleFontSize = 25}) {
    if (Platform.isIOS) {
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
                    ? () {
                  Navigator.pop(context);
                  onPressedLeftButton();
                }
                    : () => Navigator.of(context).pop(),
              ),
              CupertinoDialogAction(
                child: Text(
                  textRightButton,
                  textAlign: TextAlign.justify,
                ),
                /// If the function is null, we just pop the dialog.
                onPressed: onPressedRightButton != null
                    ? () {
                  Navigator.pop(context);
                  onPressedRightButton();
                }
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
              new TextButton(
                child: new Text(
                  textLeftButton,
                  style: TextStyle(fontSize: buttonFontSize),
                ),
                onPressed: onPressedLeftButton != null
                    ? () {
                  Navigator.pop(context);
                  onPressedLeftButton();
                }
                    : () => Navigator.of(context).pop(),
              ),
              new TextButton(
                child: new Text(
                  textRightButton,
                  style: TextStyle(
                      fontSize: buttonFontSize,
                      color: isRightButtonADestructiveAction
                          ? Colors.redAccent
                          : Colors.white),
                ),
                /// If the function is null, we just pop the dialog.
                onPressed: onPressedRightButton != null
                    ? () {
                  Navigator.pop(context);
                  onPressedRightButton();
                } /// If the function is null, we just pop the dialog.
                    : () => Navigator.of(context).pop(),
              ),
            ],
          );
        },
      );
    }
  }

  static void loadingDialog({

    required BuildContext context,
    String title = "",
    double titleFontSize = 25,
    Color? androidLoadingColor,
  }) {
    if (Platform.isIOS) {
      /// This is to show the iOS dialog type with Cupertino Widgets
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return CupertinoAlertDialog(
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
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Center(child: new CircularProgressIndicator(color: androidLoadingColor,)),
                ],
              )
          );
        },
      );
    }
  }

  static void textInputDialog({
    required BuildContext context,
    required String title,
    required String message,
    TextEditingController? editingController,
    String dismissButtonText = 'OK',
    Color? titleTextColor,
    Color? messageTextColor,
    VoidCallback? onPressed,
    VoidCallback? onEditingComplete,
    Function? onChanged,
    double dismissButtonFontSize = 20,
    double titleFontSize = 25,
    String? placeHolder,
  }) {
    if (Platform.isIOS) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return CupertinoAlertDialog(
            title: Center(child: new Text(title)),
            content: Column(
              children: [
                new Text(message),
                SizedBox(height: 10,),
                CupertinoTextField(
                  controller: editingController,
                  onChanged: (value) => onChanged == null ? {} : onChanged(value),
                  onEditingComplete: () => onEditingComplete == null ? {} : onEditingComplete(),
                  placeholder: placeHolder,
                )
              ],
            ),
            actions: <Widget>[
              CupertinoDialogAction(
                child: Text(
                  dismissButtonText,
                  textAlign: TextAlign.justify,
                ),
                onPressed: () {
                  Navigator.pop(context);
                  /// Pop and do the function if not null
                  if (onPressed != null) {
                    onPressed();
                  }
                },
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
                  style: TextStyle(
                      fontSize: titleFontSize,
                      fontWeight: FontWeight.bold,
                      color: titleTextColor),
                )),
            content: Column(
              children: [
                new Text(
                  message,
                  textAlign: TextAlign.justify,
                  style: TextStyle(color: messageTextColor),
                ),
                TextField(
                  onChanged: (value) => onChanged == null ? {} : onChanged(value),
                  onEditingComplete: () => onEditingComplete == null ? {} : onEditingComplete(),
                  controller: editingController,
                  decoration: InputDecoration(
                    labelText: placeHolder,
                  ),
                )
              ],
            ),
            actions: <Widget>[
              new TextButton(
                child: new Text(
                  dismissButtonText,
                  style: TextStyle(fontSize: dismissButtonFontSize),
                ),
                onPressed: () {
                  Navigator.pop(context);
                  /// Pop and do the function if not null
                  if (onPressed != null) {
                    onPressed();
                  }
                },
              ),
            ],
          );
        },
      );
    }
  }
}
