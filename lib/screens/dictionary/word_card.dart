import 'package:engapp/models/word.dart';
import 'package:flutter/material.dart';

class WordCard extends StatelessWidget {

  final Word word;
  WordCard({this.word});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(5.0),
      child: Card(
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

        ),
      ),
    );
  }
}
