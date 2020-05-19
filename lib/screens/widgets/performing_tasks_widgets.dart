import 'package:flutter/material.dart';

class OptionPart extends StatefulWidget {
  final String option, description, correctAnswer, optionSelected;

  OptionPart(
      {this.optionSelected, this.correctAnswer,
       this.description, this.option});
  @override
  _OptionPartState createState() => _OptionPartState();
}

class _OptionPartState extends State<OptionPart> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
              border: Border.all(
                  color: widget.description == widget.optionSelected
     ? widget.description == widget.correctAnswer ?
              Colors.green.withOpacity(0.7) : Colors.red.withOpacity(0.7) : Colors.grey
              ),
             borderRadius:BorderRadius.circular(30)
            ),
            color: widget.optionSelected == widget.description
                ? widget.description == widget.correctAnswer
                ? Colors.green.withOpacity(0.7)
                : Colors.red.withOpacity(0.7)
                : Colors.white,
            child: Text(
              widget.option,
              style: TextStyle(
              color: widget.optionSelected == widget.description ?
                  Colors.white:
                  Colors.grey
            ),),
          ),
          Text(widget.description)
        ],
      ),
    );
  }
}
