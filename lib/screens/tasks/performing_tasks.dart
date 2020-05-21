import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:engapp/models/question_model.dart';
import 'package:engapp/screens/tasks/result.dart';
import 'package:engapp/screens/widgets/performing_tasks_widgets.dart';
import 'package:engapp/services/database.dart';
import "package:flutter/material.dart";
class PerformingTasks extends StatefulWidget{

  final String taskId;
  PerformingTasks(this.taskId);

  @override
  _PerformingTasksState createState() => _PerformingTasksState();
}

int total = 0;
int _correct = 0;
int _incorrect = 0;
int _notAttempted = 0;
class _PerformingTasksState extends State<PerformingTasks>{

  DatabaseService databaseService = new DatabaseService();
  QuerySnapshot questionSnaphot;

  bool isLoading = true;

  QuestionModel getQuestionModelFromDatasnapshot(
      DocumentSnapshot questionSnapshot
      ){
    QuestionModel questionModel = new QuestionModel();

    questionModel.question = questionSnapshot.data["question"];

    List<String> options =
        [
          questionSnapshot.data["option1"],
          questionSnapshot.data["option2"],
          questionSnapshot.data["option3"],
          questionSnapshot.data["option4"]
        ];
    options.shuffle();

    questionModel.option1 = options[0];
    questionModel.option2 = options[1];
    questionModel.option3 = options[2];
    questionModel.option4 = options[3];
    questionModel.correctOption = questionSnapshot.data["option1"];
    questionModel.answered = false;

    return questionModel;
  }

  @override
  void initState(){
    print("${widget.taskId}");
    databaseService.getQuestionData(widget.taskId).then((value){
      questionSnaphot = value;
      _notAttempted = 0;
      _correct = 0;
      _incorrect = 0;
      isLoading = false;
      total = questionSnaphot.documents.length;
      
      print("$total this is total");
      setState(() {

      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Colors.deepOrange[100],
      appBar: AppBar(
        backgroundColor: Colors.deepOrange[800],
        elevation: 0.0,
        title: Text('Task'),
        actions: [
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
      body:
      Container(
          child: Column(
            children: [
              SizedBox(
                height: 10,
              ),
              questionSnaphot.documents == null ?
              Container(
                child: Center(child: Text("No Data"),),
              )
                  : ListView.builder(

                itemCount: questionSnaphot.documents.length,
                shrinkWrap: true,
                physics: ClampingScrollPhysics(),
                itemBuilder: (context, index){

                  return TasksPerformingPart(
                    questionModel: getQuestionModelFromDatasnapshot(
                        questionSnaphot.documents[index]),
                    index: index,
                  );
                }
              )
            ],
          ),
        ),
          floatingActionButton: FloatingActionButton(
          child: Icon(Icons.check),
          onPressed: (){
            Navigator.pushReplacement(context, MaterialPageRoute(
              builder: (context) => Results(
                correct: _correct,
                incorrect: _incorrect,
                total: total,
              )
            ));
          },
        ),

    );
  }
}

class TasksPerformingPart extends StatefulWidget{
  final QuestionModel questionModel;
  final int index;
  TasksPerformingPart({@required this.questionModel, @required this.index});
  @override
  _TasksPerformingPartState createState() => _TasksPerformingPartState();
}

class _TasksPerformingPartState extends State<TasksPerformingPart>{

  String optionSelected = "";

@override
  Widget build(BuildContext context){
  return Container(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.symmetric(
              horizontal: 20
          ),
          child: Text(
            "T${widget.index + 1} ${widget.questionModel.question}",
            style:
            TextStyle(fontSize: 18, color: Colors.black.withOpacity(0.8)),
          ),
        ),
        SizedBox(
          height: 12,
        ),
        GestureDetector(
          onTap: () {
            if (!widget.questionModel.answered) {
              ///correct
              if (widget.questionModel.option1 ==
                  widget.questionModel.correctOption) {
                setState(() {
                  optionSelected = widget.questionModel.option1;
                  widget.questionModel.answered = true;
                  _correct = _correct + 1;
                  _notAttempted = _notAttempted + 1;
                });
              } else {
                setState(() {
                  optionSelected = widget.questionModel.option1;
                  widget.questionModel.answered = true;
                  _incorrect = _incorrect + 1;
                  _notAttempted = _notAttempted - 1;
                });
              }
            }
          },
          child: OptionPart(
            option: "A",
            description: "${widget.questionModel.option1}",
            correctAnswer: widget.questionModel.correctOption,
            optionSelected: optionSelected,
          ),
        ),
        SizedBox(
          height: 4,
        ),
        GestureDetector(
          onTap: () {
            if (!widget.questionModel.answered) {
              ///correct
              if (widget.questionModel.option2 ==
                  widget.questionModel.correctOption) {
                setState(() {
                  optionSelected = widget.questionModel.option2;
                  widget.questionModel.answered = true;
                  _correct = _correct + 1;
                  _notAttempted = _notAttempted + 1;
                });
              } else {
                setState(() {
                  optionSelected = widget.questionModel.option2;
                  widget.questionModel.answered = true;
                  _incorrect = _incorrect + 1;
                  _notAttempted = _notAttempted - 1;
                });
              }
            }
          },
          child: OptionPart(
            option: "B",
            description: "${widget.questionModel.option2}",
            correctAnswer: widget.questionModel.correctOption,
            optionSelected: optionSelected,
          ),
        ),
        SizedBox(
          height: 4,
        ),
        GestureDetector(
          onTap: () {
            if (!widget.questionModel.answered) {
              ///correct
              if (widget.questionModel.option3 ==
                  widget.questionModel.correctOption) {
                setState(() {
                  optionSelected = widget.questionModel.option3;
                  widget.questionModel.answered = true;
                  _correct = _correct + 1;
                  _notAttempted = _notAttempted + 1;
                });
              } else {
                setState(() {
                  optionSelected = widget.questionModel.option3;
                  widget.questionModel.answered = true;
                  _incorrect = _incorrect + 1;
                  _notAttempted = _notAttempted - 1;
                });
              }
            }
          },
          child: OptionPart(
            option: "C",
            description: "${widget.questionModel.option3}",
            correctAnswer: widget.questionModel.correctOption,
            optionSelected: optionSelected,
          ),
        ),
        SizedBox(
          height: 4,
        ),
        GestureDetector(
          onTap: () {
            if (!widget.questionModel.answered) {
              ///correct
              if (widget.questionModel.option4 ==
                  widget.questionModel.correctOption) {
                setState(() {
                  optionSelected = widget.questionModel.option4;
                  widget.questionModel.answered = true;
                  _correct = _correct + 1;
                  _notAttempted = _notAttempted + 1;
                });
              } else {
                setState(() {
                  optionSelected = widget.questionModel.option4;
                  widget.questionModel.answered = true;
                  _incorrect = _incorrect + 1;
                  _notAttempted = _notAttempted - 1;
                });
              }
            }
          },
          child: OptionPart(
            option: "D",
            description: "${widget.questionModel.option4}",
            correctAnswer: widget.questionModel.correctOption,
            optionSelected: optionSelected,
          ),
        ),
        SizedBox(
          height: 20,
        ),
      ],
    ),
  );
}
}