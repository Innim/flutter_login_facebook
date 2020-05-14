import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final FacebookLogin _wrapper = FacebookLogin();
  FacebookAccessToken _token;
  FacebookUserProfile _profile;

  @override
  void initState() {
    super.initState();
    _updateLoginInfo();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Flutter Facebook wrapper example app'),
        ),
        body: Center(
            child: Column(
          children: <Widget>[
            Column(
              children: <Widget>[
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text('UserName: '),
                    Text((_profile?.firstName ?? 'null') +
                        ' ' +
                        (_profile?.lastName ?? 'null'))
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text('AccessToken: '),
                    Text(_token?.token ?? 'null')
                  ],
                )
              ],
            ),
            Column(
              children: <Widget>[
                OutlineButton(
                    onPressed: _onPressedLogInButton, child: Text('LogIn')),
                OutlineButton(
                    onPressed: _onPressedLogOutButton, child: Text('LogOut'))
              ],
            ),
          ],
        )),
      ),
    );
  }

  void _onPressedLogInButton() async {
    await _wrapper.logIn([]);
    _updateLoginInfo();
  }

  void _onPressedLogOutButton() async {
    await _wrapper.logOut();
    _updateLoginInfo();
  }

  void _updateLoginInfo() async {
    final token = await _wrapper.accessToken;
    final profile = await _wrapper.userProfile;
    setState(() {
      _token = token;
      _profile = profile;
    });
  }
}
