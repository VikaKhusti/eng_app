import 'package:engapp/screens/dictionary/myDictionary.dart';
import 'package:engapp/screens/tasks/quick-test.dart';
import 'package:engapp/screens/tasks/sections.dart';
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
          Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Row(

                ),
                new  FlatButton(

                  color: Colors.lightBlue[900],
                  child: Text("My Dictionary", style: TextStyle(color: Colors.white, fontSize: 18.0),),
                  onPressed: () {
                    Navigator.push(context,
                      MaterialPageRoute(builder: (context) => MyDictionary()),
                    );
                  },
                ),
                new  FlatButton(
                  color: Colors.lightBlue[900],
                  child: Text("Quick Test", style: TextStyle(color: Colors.white, fontSize: 18.0),),
                  onPressed: () {
                    Navigator.push(context,
                      MaterialPageRoute(builder: (context) => QuickTest()),
                    );
                  },
                ),
                new  FlatButton(
                  color: Colors.lightBlue[900],
                  child: Text("Rubric quizzes", style: TextStyle(color: Colors.white, fontSize: 18.0),),
                  onPressed: () {
                    Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Sections()),
                    );
                  },
                ),


              ],
            ),
    )
          );
  }
}

