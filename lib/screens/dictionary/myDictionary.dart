import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:engapp/screens/dictionary/words_list.dart';
import 'package:engapp/services/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyDictionary extends StatefulWidget {
  @override
  _MyDictionaryState createState() => _MyDictionaryState();
}

class _MyDictionaryState extends State<MyDictionary> {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<QuerySnapshot>.value(
      value: DatabaseService().words,
      child: Scaffold(
        backgroundColor: Colors.deepOrange[100],
        appBar: AppBar(
          backgroundColor: Colors.deepOrange[800],
          elevation: 0.0,
          title: Text('My Dictionary'),
          actions: <Widget>[
            FlatButton.icon(
                onPressed: () {Navigator.pop(context);},
                icon: Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                ),
                label: Text(
                    'Back',
                    style: TextStyle(
                      color: Colors.white
                    ),
                )
            ),
          ],
        ),
        body: WordsList(),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            print('Pressed');
          },
          child: Icon(Icons.add),
          backgroundColor: Colors.deepOrange[800],
          elevation: 0.0,
        ),
      ),
    );
  }
}
