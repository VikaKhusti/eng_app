import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:engapp/models/word.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});


  //collection reference
  final CollectionReference wordsCollection =
      Firestore.instance.collection('words');

  Future updateUserData(String word, String translation, String synonyms) async {
    return await wordsCollection.document(uid).collection("words").document(word).setData({
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
          synonyms: doc.data['synonyms'] ?? '');
    }).toList();
  }


  //get words stream
  Stream<List<Word>> get words {
    return wordsCollection.snapshots().map(_wordsListFromSnapshot);
  }

  Future<void> addTaskData(Map taskData, String taskId) async {
    await Firestore.instance
        .collection("Tasks")
        .document(taskId)
        .setData(taskData)
        .catchError((e) {
      print(e.toString());
    });
  }

  Future<void> addQuestionData(Map questionData, String taskId) async{
    await Firestore.instance.collection("Tasks")
        .document(taskId).collection("TNA")
        .add(questionData).catchError((e){
          print(e);
    });
  }
  getTaskData() async{
    return await Firestore.instance.collection("Tasks").snapshots();
  }
}



  //get user doc stream
  Stream<DocumentSnapshot> get userData{
    return wordsCollection.document(uid).snapshots();
  }

}

