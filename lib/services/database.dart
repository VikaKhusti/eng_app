import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:engapp/models/word.dart';

class DatabaseService {

  final String uid;
  DatabaseService({this.uid});

  //collection reference
  final CollectionReference wordsCollection = Firestore.instance.collection('words');

  Future addUserWord(String word, String translation, String synonyms) async {
    return await wordsCollection.document(uid).setData({
      'word': word,
      'translate': translation,
      'synonyms': synonyms,
    });
  }

  //words list from snapshot
  List<Word> _wordsListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return Word(
        word: doc.data['word'] ?? '',
        translate: doc.data['translate'] ?? '',
        synonyms: doc.data['synonyms'] ?? ''
      );
    }).toList();
  }


  //get words stream
  Stream<List<Word>> get words {
    return wordsCollection.snapshots()
    .map(_wordsListFromSnapshot) ;
  }
}