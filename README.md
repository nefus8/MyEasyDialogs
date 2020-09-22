# MyEasyDialogs

This package will make your life easier. It allows you to create dialogues that adapt visually to the OS used and allows you to display simple pop-up messages or with actions.
  
## Getting Started  
  
To use this package, add `my_easy_dialogs` as a [dependency in your pubspec.yaml file](https://flutter.io/platform-plugins/).  

There is three types of dialogs for now. The first one is **infoDialog**. It will display a simple dialog with a title, a message adn a button to dismiss the dialog. The second one is **dialogWithOptions**. It will display a dialog with two buttons and you can add your custom function for each buttons. The third one is **loadingDialog**. It will display a dialog with a title if you want and a loading indicator.
 
## Parameters

There is multiple parameters in order to custom your dialogs the way you want to.

The required parameters are the **title**, the **message** to display and the **Buildcontext**.
But you can customize other parameters, like the **button text** that by default is 'OK' for the **infoDialog** and are 'OK' and 'Cancel' for the **dialogWithOptions**. You can customize the **title font size** and the **buttons font size** for the android version of the dialog. You can even set the right button as a destructive button on the **dialogWithOptions** so that the text will be colored in red. (It's set to true by default.)

## Example  
  
```dart  
import 'package:flutter/material.dart';
import 'package:my_easy_dialogs/dialogs/my_easy_dialog.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(title: 'MyEasyDialogs'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FlatButton(
              onPressed: () => MyEasyDialog.infoDialog(
                  context: context,
                  title: "Exemple",
                  message: "I'm an infoDialog exemple !"
              ),
              child: Text("Show infoDialog"),
            ),
            FlatButton(
              onPressed: () => MyEasyDialog.dialogWithOptions(
                  context: context,
                  title: "Exemple",
                  message: "I'm an infoDialog exemple !",
                  textLeftButton: "Yes",
                  onPressedLeftButton: () => print("yes")
              ),
              child: Text("Show dialogWithOptions"),
            ),
          ],
        ),
      ),
    );
  }
}
```
