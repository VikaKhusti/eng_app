import 'package:engapp/screens/tasks/test-card.dart';
import 'package:flutter/material.dart';
import 'package:engapp/models/user.dart';
import 'package:provider/provider.dart';

class QuickTest extends StatefulWidget {
  @override
  _QuickTestState createState() => _QuickTestState();
}

class _QuickTestState extends State<QuickTest> {

  String word;
  String translation;

  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User>(context);

    return Scaffold(
      body: TestCard(),
    );
  }
}
