import 'package:engapp/screens/tasks/create_task.dart';
import 'package:engapp/services/auth.dart';
import 'package:engapp/screens/navDrawer.dart';
import 'package:engapp/services/database.dart';
import 'package:flutter/material.dart';

final AuthService _auth = AuthService();

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavDrawer(),
      appBar: AppBar(
        title: Text('Side menu'),
      ),
      body: Center(
        child: Text('Side Menu Tutorial'),
      ),
    );
  }
}

class _HomeState extends State<Home> {
  Stream taskStream;
  DatabaseService databaseService = new DatabaseService();

  Widget taskList(){
    return Container(
      child: StreamBuilder(
        stream: taskStream,
        builder: (context, snapshot){
          return snapshot.data == null
              ? Container():
              ListView.builder(
                itemCount: snapshot.data.documents.length,
                  itemBuilder: (context, index){
                    return TaskTitle(
                      imgUrl: snapshot.data.documents[index].data["taskImgurl"],
                      desc: snapshot.data
                          .documents[index]
                          .data["taskDesc"],
                      title: snapshot.data
                          .documents[index]
                          .data["taskTitle"],
                    );
                  }
              );
        },
      ),
    );
  }

  @override
  void initState(){
    databaseService.getTaskData().then((val){
      setState(() {
        taskStream = val;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepOrange[100],
      drawer: NavDrawer(),
      appBar: AppBar(
        title: Text('Daily English'),
        backgroundColor: Colors.deepOrange[800],
        elevation: 0.0,
        actions: <Widget>[
          FlatButton.icon(
            icon: Icon(
              Icons.person,
              color: Colors.white,
            ),
            label: Text(
              'Log out',
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () async {
              await _auth.signOut();
            },
          )
        ],
      ),
      body: taskList(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (contex) => CreateTask()));
        },
      ),
    );
  }
}

class TaskTitle extends StatelessWidget{
  final String imgUrl;
  final String title;
  final String desc;

  TaskTitle({@required this.imgUrl,
    @required this.title,
    @required this.desc});

  @override
  Widget build(BuildContext context){
    return Container(
      height: 150,
      child: Stack(
        children: [
          Image.network(
            imgUrl
          ),
          Container(
            child: Column(children: [
              Text(title),
              Text(desc)
            ],),
          )
        ],
      ),
    );
  }
}
