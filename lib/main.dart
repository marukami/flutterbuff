import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'gen/protos/user.pb.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'FlutterBuffer Demo'),
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
  static const platform = const MethodChannel("com.mtilbrook.app");

  User user;

  Future<dynamic> _authHandler(MethodCall call) {
    switch (call.method) {
      case "authResult":
        User newUser;
        if (call.arguments == null) {
          newUser = null;
          debugPrint("user authResult failed");
        } else {
          newUser = User.fromBuffer(call.arguments);
        }
        setState(() {
          this.user = newUser;
        });
    }
    return Future.value(null);
  }

  @override
  void initState() {
    super.initState();
    platform.setMethodCallHandler(_authHandler);
  }

  @override
  Widget build(BuildContext context) {
    final name = user == null ? 'Null' : user.email;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'User name is: $name',
            ),
            RaisedButton(
              child: Text('SignUp/Login'),
              onPressed: () async {
                await platform.invokeMethod('authorize');
              },
            ),
            RaisedButton(
              child: Text('Current User'),
              onPressed: () async {
                await platform.invokeMethod('currentUser');
              },
            ),
          ],
        ),
      ),
    );
  }
}
