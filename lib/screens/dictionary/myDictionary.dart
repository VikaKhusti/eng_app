import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:engapp/models/word.dart';
import 'package:engapp/models/user.dart';
import 'package:engapp/screens/dictionary/words_list.dart';
import 'package:engapp/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class MyDictionary extends StatefulWidget {
  @override
  _MyDictionaryState createState() => _MyDictionaryState();
}

class _MyDictionaryState extends State<MyDictionary> {

  String word;
  String translation;
  String synonyms;


  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User>(context);

    return StreamProvider<List<Word>>.value(
      value: DatabaseService(uid: user.uid).words,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.lightBlue[900],
          elevation: 2,
          title: Text('My Dictionary')
        ),
        body: WordsList(),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            return Alert(
              context: context,
              title: 'Add new word',
              content: Form(
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'new word',
                      ),
                      onChanged: (val) {
                        setState(() {
                          word = val;
                        });
                      },
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'translation',
                      ),
                      onChanged: (val) {
                        setState(() {
                          translation = val;
                      }); },
                    ),

                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'synonyms',
                      ),
                        onChanged: (val) {
                      setState(() {
                        synonyms = val;
                       });
                      },
                    ),
                  ],
                ),
              ),
                 buttons: [
                   DialogButton(child: Text('Add', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)), color: Colors.lightBlue[900], radius: BorderRadius.all(Radius.circular(20)), onPressed: () {
                     if( word != null && translation != null && synonyms != null)
                       Firestore.instance.collection('words').document(user.uid).collection('words').document(word)
                         .setData(
                         {
                           'word': word,
                           'translate': translation,
                           'synonyms': synonyms,
                         }
                       );
                      Navigator.pop(context);
                   },)
                ]
            ).show();
          },
          child: Icon(Icons.add),
          backgroundColor: Colors.lightBlue[900],
          elevation: 0.0,
        ),
      ),
    );
  }
}
