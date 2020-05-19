import 'package:engapp/screens/widgets/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Results extends StatefulWidget {
  final int correct, incorrect, total;
  Results({@required this.correct, @required this.incorrect, @required this.total});

  @override
  _ResultsState createState() => _ResultsState();
}

class _ResultsState extends State<Results> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
            Text("${widget.correct}/${widget.total}"),
            SizedBox(height: 8,),
            Text("You answered ${widget.correct} answers correctly "
                "and ${widget.incorrect} answers incorrectly"
            ),
              GestureDetector(
              onTap: (){
                Navigator.pop(context);
              },
              child: orangeButton(context: context, label: "Go to Home"),
              )
          ],),
        ),
      ),
    );
  }
}
