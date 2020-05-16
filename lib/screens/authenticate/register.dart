import 'package:engapp/shared/loading.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:engapp/services/auth.dart';

class Register extends StatefulWidget {

  final Function toggleView;
  Register({this.toggleView});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  //text field state
  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
        resizeToAvoidBottomPadding: false,
        body: Container(
        padding: EdgeInsets.symmetric(vertical: 30),
        width: double.infinity,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                colors: [
                  Colors.lightBlue[900],
                  Colors.lightBlue[800],
                  Colors.lightBlue[400]
                ]
            )
        ),
           child: Column (
        children: <Widget>[
        SizedBox(height: 30,),
        Padding(
        padding: EdgeInsets.all(10),
        child: Column(
            children: <Widget>[
        FlatButton.icon(
        onPressed: () {widget.toggleView();},
            icon: Icon(Icons.person, color: Colors.white),
            label: Text('Sign up',
              style: TextStyle(color: Colors.white),
            )
              ),
            ],
          ),
        ),
              Expanded(
              child: Container(
              decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(topLeft: Radius.circular(80), topRight: Radius.circular(80))
              ),


              padding: EdgeInsets.symmetric(vertical: 40.0, horizontal: 60.0),
                child: Form(
              key: _formKey,
              child: Column(

                  children: <Widget>[
                  SizedBox(height: 90.0),
                  TextFormField(

                  decoration: InputDecoration(
                  hintText: ' Enter email',

                  fillColor: Colors.lightBlue[50],
                  filled: true,
                  enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white, width: 2.0),
                      borderRadius: BorderRadius.all(Radius.circular(30))
                  ),
                  focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.lightBlue[200], width: 2.2)
                  ),
                  ),
                  validator: (val) => val.isEmpty ? 'Enter an email' : null,
                  onChanged: (val) {
                  setState(() => email = val );
                  },
                ),
                SizedBox(height: 30.0),
                TextFormField(
                decoration: InputDecoration(
                hintText: ' Enter password',
                fillColor: Colors.lightBlue[50],
                filled: true,
                enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white, width: 2.0),
                  borderRadius: BorderRadius.all(Radius.circular(30))
                ),
                focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.lightBlue[200], width: 2.2)
                ),
                ),
                  obscureText: true,
                  validator: (val) => val.length < 6 ? 'Enter a password 6+ chars long' : null,
                  onChanged: (val) {
                    setState(() => password = val );
                  },
                ),
                SizedBox(height: 40.0),
                RaisedButton(
                color: Colors.lightBlue[900],
                elevation: 4,
                shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(18.0)),
                ),
                child: Text(
                'Register',
                style: TextStyle(
                color: Colors.white,
                fontSize: 15.0,
                ),
                ),
                onPressed: () async {
                  if(_formKey.currentState.validate()) {
                    setState(() => loading = true);
                    dynamic result = await _auth.registerWithEmailAndPassword(
                        email, password);
                    if (result == null) {
                      setState(()
                          {
                            error = 'Please, suply a valid email!';
                            loading = false;
                          });
                    }
                  }
                },
              ),
              SizedBox(height: 12.0),
              Text(
                error,
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 14.0,
                ),
              )
            ],
          ),
        ),
      ),
    ),
    ],
    ),
      ),
    );
  }
}
