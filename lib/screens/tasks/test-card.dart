import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:engapp/models/user.dart';

class TestCard extends StatefulWidget {
  @override
  _TestCardState createState() => _TestCardState();
}

class _TestCardState extends State<TestCard> {

  Future getWords() async {
    final user = Provider.of<User>(context);
    var firestore = Firestore.instance;

    QuerySnapshot wordsSnap = await firestore.collection('words').document(user.uid).collection('words').getDocuments();
    return wordsSnap.documents;
  }

  var random = new Random();
  
  bool randBool() {
    return random.nextBool();
  }
  
  int randIndex(index) {
    if(randBool()) {
      return index;
    }
    else {
      return random.nextInt(9);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder(
        future: getWords(),
          builder: (context, snapchot ){
          return ListView.builder(
            itemCount: 10,
              itemBuilder: (context, index){
                  return Container(
                    padding: EdgeInsets.fromLTRB(10,10,10,0),
                    height: 150,
                    //title: Text(snapchot.data[index].data["word"]),
                    child: Card(
                      shape: RoundedRectangleBorder(
                        side: new BorderSide(color: Colors.blue, width: 2.0),
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      color: Colors.white, elevation: 2,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        // !!!!!
                        // коментар ЖЕНІ ToDo
                        // ці карточки треба зробити вужчими і по центру,
                        //я пробувала то зробити сама, але вони все рівно ідуть за шириною контейнера
                        // !!!!
                        children: <Widget>[
                          new ListTile(
                            title: Text(snapchot.data[index].data["word"]),
                            subtitle: Text(snapchot.data[randIndex(index)].data["translate"]),
                            
                          )
                        ],
                      ),
                    ),
                  );
              });

      }
     ),
    );
  }
}
