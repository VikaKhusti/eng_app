import 'package:flutter/material.dart';

Widget BlueButton({BuildContext context, String label, buttonWidth}) {
  return Container(
    padding: EdgeInsets.symmetric(vertical: 18),
    decoration: BoxDecoration(
      color: Colors.lightBlue[900],
  borderRadius: BorderRadius.circular(30)     
    ),
    alignment: Alignment.center,
    width: buttonWidth != null ? buttonWidth : MediaQuery.of(context).size.width - 48,
    child: Text(
      label,
      style: TextStyle(color: Colors.white, fontSize: 16),
    ),
  );
}