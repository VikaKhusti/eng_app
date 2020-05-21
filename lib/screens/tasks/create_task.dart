import 'package:engapp/screens/tasks/addquestion.dart';
import 'package:engapp/screens/widgets/widgets.dart';
import 'package:engapp/services/database.dart';
import 'package:flutter/material.dart';
import 'package:random_string/random_string.dart';

class CreateTask extends StatefulWidget {
  @override
  _CreateTaskState createState() => _CreateTaskState();
}

class _CreateTaskState extends State<CreateTask> {
  final _formKey = GlobalKey<FormState>();
  String taskImageUrl, taskTitle, taskDescription, taskId;
  DatabaseService databaseService = new DatabaseService();

  bool _isLoading = false;

  createTaskOnline() async {
    if (_formKey.currentState.validate()) {
      setState(() {
        _isLoading = true;
      });
      taskId = randomAlphaNumeric(16);

      Map<String, String> tasksMap = {
        "taskId": taskId,
        "taskImgurl": taskImageUrl,
        "taskTitle": taskTitle,
        "taskDesc": taskDescription
      };
      await databaseService.addTaskData(tasksMap, taskId).then((value) {
        setState(() {
          _isLoading = false;
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => AddQuestion(
              taskId
          )));
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.lightBlue[900],
        elevation: 0.0,
        title: Text('Create Task'),
        actions: <Widget>[
          FlatButton.icon(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
              label: Text(
                'Back',
                style: TextStyle(color: Colors.white),
              )),
        ],
      ),
      body: _isLoading
          ? Container(
        child: Center(
          child: CircularProgressIndicator(),
        ),
      )
          : Form(
        key: _formKey,
        child: Container(
            padding: EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              children: [
                TextFormField(
                  validator: (val) =>
                  val.isEmpty ? "Enter Image Url" : null,
                  decoration: InputDecoration(
                    hintText: "Task Image Url",
                  ),
                  onChanged: (val) {
                    taskImageUrl = val;
                  },
                ),
                SizedBox(
                  height: 6,
                ),
                TextFormField(
                  validator: (val) =>
                  val.isEmpty ? "Enter Task Title" : null,
                  decoration: InputDecoration(
                    hintText: "Task Title",
                  ),
                  onChanged: (val) {
                    taskTitle = val;
                  },
                ),
                SizedBox(
                  height: 6,
                ),
                TextFormField(
                  validator: (val) =>
                  val.isEmpty ? "Enter Task Description" : null,
                  decoration: InputDecoration(
                    hintText: "Task Description",
                  ),
                  onChanged: (val) {
                    taskDescription = val;
                  },
                ),
                Spacer(),
                GestureDetector(
                    onTap: () {
                      createTaskOnline();
                    },
                    child: BlueButton(
                        context: context,
                        label: "Create Task"
                    )),
                SizedBox(
                  height: 60,
                ),
              ],
            )),
      ),
    );
  }
}