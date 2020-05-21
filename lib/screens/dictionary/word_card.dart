import 'package:engapp/models/word.dart';
import 'package:flutter/material.dart';

class WordCard extends StatelessWidget {

  final Word word;
  WordCard({this.word});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(6.0),
      child: Card(
        color: Colors.lightBlue[50],
        elevation: 4,
        margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
        child: ListTile(
          title: Text(
            word.word,
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Text(
            word.translate,
            style: TextStyle(
              //style
            ),
          ),
          onTap: () {
            showDialog(
                context: context,
                builder: (BuildContext) {
                  return AlertDialog(
                      title: Text(
                        word.word,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 25.0
                        ),
                      ),
                      content: SingleChildScrollView(
                        child: ListBody(
                          children: <Widget>[
                            Text(
                                word.translate,
                              style: TextStyle(
                                  fontSize: 18.0,
                                  color: Colors.black.withOpacity(0.7)
                              ),
                            ),
                            Text(''),
                            Text(
                              word.synonyms,
                              style: TextStyle(
                                  fontStyle: FontStyle.italic,
                                  color: Colors.black.withOpacity(0.6)
                              ),
                            )
                          ],
                        ),
                      ),
                      actions: <Widget>[
                        FlatButton(
                          child: Text(
                            'Delete',
                            style: TextStyle(color: Colors.red, fontSize: 18.0),
                          ),
                          onPressed: () {Navigator.pop(context);},
                        ),
                        FlatButton(
                          child: Text(
                            'Close',
                            style: TextStyle(color: Colors.lightBlue[900], fontSize: 18.0),
                          ),
                          onPressed: () {Navigator.pop(context);},
                        ),

                      ]
                  );

                }
            );
          },
        ),
      ),
    );
  }
}