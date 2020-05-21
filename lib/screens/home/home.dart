import 'package:engapp/screens/tasks/sections.dart';
import 'package:engapp/screens/widgets/widgets.dart';
import 'package:engapp/services/auth.dart';
import 'package:engapp/screens/navDrawer.dart';
import 'package:engapp/services/database.dart';
import 'package:flutter/material.dart';

final AuthService _auth = AuthService();

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavDrawer(),
      appBar: AppBar(
        title: Text('Side menu'),
      ),

    );
  }
}

class _HomeState extends State<Home> {

  DatabaseService databaseService = new DatabaseService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      drawer: NavDrawer(),
      appBar: AppBar(
        title: Text('Daily English'),
        backgroundColor: Colors.lightBlue[900],
        elevation: 0.0,
        actions: <Widget>[
          FlatButton.icon(
            icon: Icon(
              Icons.person,
              color: Colors.white,
            ),
            label: Text(
              'Log out',
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () async {
              await _auth.signOut();
            },
          )
        ],
      ),
      body:
    Text("Sections"));
  }
}

