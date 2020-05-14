import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:engapp/models/word.dart';
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

  final FirebaseAuth _auth = FirebaseAuth.instance;
  getCurrentUser() async {
    final FirebaseUser user = await _auth.currentUser();
    final uid = user.uid;
    // Similarly we can get email as well
    //final uemail = user.email;
    print(uid);
  }

  String uid = getCurrentUser();

  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<Word>>.value(
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
                   DialogButton(child: Text('Add'), onPressed: () {
                     String uid = getCurrentUser();
                     print(getCurrentUser().toString());
                     if( word != null && translation != null && synonyms != null)

                       Firestore.instance.collection('words').document(uid)
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
          backgroundColor: Colors.deepOrange[800],
          elevation: 0.0,
        ),
      ),
    );
  }
}
