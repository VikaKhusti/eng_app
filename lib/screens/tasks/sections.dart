import 'package:engapp/screens/tasks/performing_tasks.dart';
import 'package:engapp/services/database.dart';
import 'package:flutter/material.dart';
import 'package:engapp/services/auth.dart';
import '../navDrawer.dart';
import 'create_task.dart';

final AuthService _auth = AuthService();

class Sections extends StatefulWidget {
@override
_SectionsState createState() => _SectionsState();
}

class _SectionsState extends State<Sections> {
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
                        .data["taskId"]
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
      backgroundColor: Colors.white,
      drawer: NavDrawer(),
      appBar: AppBar(
        title: Text('Daily English'),
        backgroundColor: Colors.lightBlue[900],
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
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
        child: Stack(
          children: [
            Image.network(
                imgUrl,
              fit: BoxFit.cover,
              width: MediaQuery.of(context).size.width,
            ),
            Container(
              color: Colors.black26,
              child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                Text(
                    title,
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.w500
                  ),
                ),
                SizedBox(height: 4,),
                Text(
                    desc,
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.white,
                      fontWeight: FontWeight.w500
                    )
                )
              ],),

            ))

          ],
        ),)
      ),
    );
  }
}