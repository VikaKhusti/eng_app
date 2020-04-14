import 'package:engapp/services/auth.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepOrange[100],
      appBar: AppBar(
        backgroundColor: Colors.deepOrange[800],
        elevation: 0.0,
        title: Text('Sign in'),
      ),
    body: Container(
      padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
      child: RaisedButton(
        child: Text('Sign in anon'),
        color: Colors.deepOrange[300],
        onPressed: () async {
          dynamic result = await _auth.signInAnon();

          if(result == null) {
            print('error while signing in');
          } else {
            print('signed in');
            print(result);
          }
        },
      ),
    ),
    );
  }
}
