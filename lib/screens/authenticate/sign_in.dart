import 'package:engapp/services/auth.dart';
import 'package:engapp/shared/loading.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SignIn extends StatefulWidget {
  final Function toggleView;
  SignIn({this.toggleView});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
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
          crossAxisAlignment: CrossAxisAlignment.start,
           children: <Widget>[
            SizedBox(height: 30,),
            Padding(
              padding: EdgeInsets.all(10),
               child: Column(

                children: <Widget>[
                 FlatButton.icon(
                  onPressed: () {widget.toggleView();},
                     icon: Icon(Icons.person, color: Colors.white),
                     label: Text('Register', style: TextStyle(color: Colors.white),
                         textDirection: TextDirection.ltr,
                         textAlign: TextAlign.center)
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
                              borderSide: BorderSide(color: Colors.lightBlue[50], width: 2.2)
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
                              borderSide: BorderSide(color: Colors.lightBlue[50], width: 2.2)
                              ),
                              ),
                                validator: (val) => val.length < 6 ? 'Enter a password 6+ chars long' : null,
                                obscureText: true,
                                onChanged: (val) {
                                  setState(() => password = val );
                                },
                              ),
                      SizedBox(
                        height: 40.0,
                      ),
                      RaisedButton(
                        color: Colors.lightBlue[900],
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(18.0)),
                        ),
                          child: Text(
                            'Sign in',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15.0,
                            ),
                          ),
                          onPressed: () async {
                          if(_formKey.currentState.validate()) {
                          setState(() => loading = true);
                          dynamic result = await _auth.signInWithEmailAndPassword(email, password);
                          if (result == null) {
                          setState(()
                          {
                          error = 'Could not sign in!';
                          loading = false;
                          });
                          }
                          }
                          },
                      ),
                      SizedBox(height: 15.0),
                      Text(
                        error,
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 14.0,
                        ),
                      ),
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
