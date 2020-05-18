import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  final plugin = FacebookLogin();

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _sdkVersion;
  FacebookAccessToken _token;
  FacebookUserProfile _profile;

  @override
  void initState() {
    super.initState();

    _getSdkVersion();
    _updateLoginInfo();
  }

  @override
  Widget build(BuildContext context) {
    final isLogin = _token != null;
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Login via Facebook example'),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 18.0, horizontal: 8.0),
          child: Center(
            child: Column(
              children: <Widget>[
                if (_sdkVersion != null) Text("SDK v$_sdkVersion"),
                if (isLogin)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: _buildUserInfo(context, _profile, _token),
                  ),
                isLogin
                    ? OutlineButton(
                        child: Text('Log Out'),
                        onPressed: _onPressedLogOutButton,
                      )
                    : OutlineButton(
                        child: Text('Log In'),
                        onPressed: _onPressedLogInButton,
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildUserInfo(BuildContext context, FacebookUserProfile profile,
      FacebookAccessToken accessToken) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text('User: '),
            Text(
              '${profile.firstName} ${profile.lastName}',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
        Text('AccessToken: '),
        Container(
          child: Text(
            accessToken.token,
            softWrap: true,
          ),
        ),
      ],
    );
  }

  void _onPressedLogInButton() async {
    await widget.plugin.logIn(permissions: [
      FacebookPermission.publicProfile,
      FacebookPermission.email,
    ]);
    _updateLoginInfo();
  }

  void _onPressedLogOutButton() async {
    await widget.plugin.logOut();
    _updateLoginInfo();
  }

  void _getSdkVersion() async {
    final sdkVesion = await widget.plugin.sdkVersion;
    setState(() {
      _sdkVersion = sdkVesion;
    });
  }

  void _updateLoginInfo() async {
    final plugin = widget.plugin;
    final token = await plugin.accessToken;
    final profile = await plugin.userProfile;
    setState(() {
      _token = token;
      _profile = profile;
    });
  }
}
