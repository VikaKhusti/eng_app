import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';

class WordsList extends StatefulWidget {
  @override
  _WordsListState createState() => _WordsListState();
}

class _WordsListState extends State<WordsList> {
  @override
  Widget build(BuildContext context) {
    
    final words = Provider.of<QuerySnapshot>(context);
    print(words.documents);

    for (var doc in words.documents){
      print(doc.data);
    }
    
    return Container();
  }
}
