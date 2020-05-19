import 'package:engapp/screens/tasks/create_task.dart';
import 'package:engapp/screens/tasks/performing_tasks.dart';
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
                shrinkWrap: true,
                itemCount: snapshot.data.documents.length,
                  itemBuilder: (context, index){
                    return TaskPart(
                      imgUrl: snapshot.data.documents[index].data["taskImgurl"],
                      desc: snapshot.data
                          .documents[index]
                          .data["taskDesc"],
                      title: snapshot.data
                          .documents[index]
                          .data["taskTitle"],
                      taskId: snapshot.data
                          .documents[index]
                          .data["tskId"]
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
      taskStream = val;
      setState(() {
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

class TaskPart extends StatelessWidget{
  final String imgUrl;
  final String title;
  final String desc;
  final String taskId;

  TaskPart({@required this.imgUrl,
    @required this.title,
    @required this.desc,
  @required this.taskId});

  @override
  Widget build(BuildContext context){
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(
          builder: (context) => PerformingTasks(
            taskId
          )
        ));
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 24),
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
      ),
    );
  }
}
