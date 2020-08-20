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
                  message: "I'm an infoDialog exemple !"),
              child: Text("Show infoDialog"),
            ),
            FlatButton(
              onPressed: () => MyEasyDialog.dialogWithOptions(
                  context: context,
                  title: "Exemple",
                  message: "I'm an infoDialog exemple !",
                  textLeftButton: "Yes",
                  onPressedLeftButton: () => print("yes")),
              child: Text("Show dialogWithOptions"),
            ),
          ],
        ),
      ),
    );
  }
}
