import 'package:engapp/screens/dictionary/word_card.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:engapp/models/word.dart';

class WordsList extends StatefulWidget {
  @override
  _WordsListState createState() => _WordsListState();
}

class _WordsListState extends State<WordsList> {
  @override
  Widget build(BuildContext context) {
    final words = Provider.of<List<Word>>(context);

    return ListView.builder(
      itemCount: words.length,
      itemBuilder: (context, index) {
        return WordCard(word: words[index]);
      },
    );
  }
}
