import 'package:engapp/screens/widgets/widgets.dart';
import 'package:engapp/services/database.dart';
import 'package:engapp/shared/loading.dart';
import 'package:flutter/material.dart';

class AddQuestion extends StatefulWidget {
  final String taskId;

  AddQuestion(this.taskId);

  @override
  _AddQuestionState createState() => _AddQuestionState();
}

class _AddQuestionState extends State<AddQuestion> {

  final _formKey = GlobalKey<FormState>();
  String question, option1, option2, option3, option4;
  bool _isLoading = false;

  DatabaseService databaseService = new DatabaseService();

  uploadQuestionData() async {

    if(_formKey.currentState.validate()){
      setState(() {
        _isLoading = true;
      });

      Map<String, String> questionMap = {
        "question" : question,
        "option1" : option1,
        "option2" : option2,
        "option3" : option3,
        "option4" : option4
      };
      await databaseService.addQuestionData(questionMap, widget.taskId)
          .then((value){
        setState(() {
          _isLoading = false;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepOrange[100],
      appBar: AppBar(
        backgroundColor: Colors.deepOrange[800],
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
      body: _isLoading ? Container(
        child: Center(child: CircularProgressIndicator(),),
      ) : Form(
        key: _formKey,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: Column(children: [
            TextFormField(
              validator: (val) =>
              val.isEmpty ? "Enter Question" : null,
              decoration: InputDecoration(
                hintText: "Question",
              ),
              onChanged: (val) {
                question = val;
              },
            ),
            SizedBox(
              height: 6,
            ),
            TextFormField(
              validator: (val) =>
              val.isEmpty ? "Enter Enter Option1" : null,
              decoration: InputDecoration(
                hintText: "Option1 (Correct Answer)",
              ),
              onChanged: (val) {
                option1 = val;
              },
            ),
            SizedBox(
              height: 6,
            ),
            TextFormField(
              validator: (val) =>
              val.isEmpty ? "Enter Option2" : null,
              decoration: InputDecoration(
                hintText: "Option2",
              ),
              onChanged: (val) {
                option2 = val;
              },
            ),
            SizedBox(
              height: 6,
            ),
            TextFormField(
              validator: (val) =>
              val.isEmpty ? "Enter Option3" : null,
              decoration: InputDecoration(
                hintText: "Option3",
              ),
              onChanged: (val) {
                option3 = val;
              },
            ),
            SizedBox(
              height: 6,
            ),
            TextFormField(
              validator: (val) =>
              val.isEmpty ? "Enter Option4" : null,
              decoration: InputDecoration(
                hintText: "Option4",
              ),
              onChanged: (val) {
                option4 = val;
              },
            ),
            Spacer(),
            Row(
              children: [
                GestureDetector (
                  onTap: (){
                    Navigator.pop(context);
                  },
                  child: orangeButton(context: context,
                    label: "Submit",
                    buttonWidth: MediaQuery.of(context).size.width/2 - (36)
                  ),
                ),
                SizedBox(width: 24,),

                GestureDetector(
                  onTap: (){
                    uploadQuestionData();
                  },
                  child: orangeButton(context: context,
                      label: "Add Question",
                      buttonWidth: MediaQuery.of(context).size.width/2 - 36
                  ),
                )
              ],
            ),
            SizedBox(
              height: 60,
            ),
          ],),
        ),
      ),
    );
  }
}
