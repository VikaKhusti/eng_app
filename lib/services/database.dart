import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {

  final String uid;
  DatabaseService({this.uid});

  //collection reference
  final CollectionReference wordsCollection = Firestore.instance.collection('words');

  Future updateUserWord(String word, String translate, String synonyms) async {
    return await wordsCollection.document(uid).setData({
      'word': word,
      'translate': translate,
      'synonyms': synonyms,
    });
  }

  //get words stream
  Stream<QuerySnapshot> get words {
    return wordsCollection.snapshots();
  }
}