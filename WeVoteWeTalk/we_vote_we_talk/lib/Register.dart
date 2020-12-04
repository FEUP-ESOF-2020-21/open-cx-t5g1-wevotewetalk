import 'package:we_vote_we_talk/shared/Constants.dart';
import 'package:we_vote_we_talk/shared/Loading.dart';
import 'package:flutter/material.dart';

import 'Authentication/Auth.dart';


class Register extends StatefulWidget {

  final Function toggleView;
  Register({ this.toggleView });

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  String error = '';
  bool loading = false;

  // text field state
  String name = '';
  String email = '';
  String password = '';
  String confirmPassword = '';

  Pattern pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text('Register'),
        actions: <Widget>[
          FlatButton.icon(
            icon: Icon(Icons.person),
            label: Text('Login'),
            onPressed: () => widget.toggleView(),
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  SizedBox(height: 20.0),
                  TextFormField(
                    decoration: textInputDecoration.copyWith(hintText: 'First and Last Name'),
                    validator: (val) => val.isEmpty || !val.contains(' ')? 'Enter at least two names' : null,
                    onChanged: (val) {
                      setState(() => name = val);
                    },
                  ),
                  SizedBox(height: 20.0),
                  TextFormField(
                    decoration: textInputDecoration.copyWith(hintText: 'E-mail'),
                    validator: (val) {
                      RegExp regex = new RegExp(pattern);
                      return !regex.hasMatch(val) || val.isEmpty ? 'Enter a valid e-mail' : null;
                    },
                    onChanged: (val) {
                      setState(() => email = val);
                    },
                  ),
                  SizedBox(height: 20.0),
                  TextFormField(
                    obscureText: true,
                    decoration: textInputDecoration.copyWith(hintText: 'Password'),
                    validator: (val) => val.length < 8 ? 'Password must be at least 8 chars long' : null,
                    onChanged: (val) {
                      setState(() => confirmPassword = val);
                    },
                  ),
                  SizedBox(height: 20.0),
                  TextFormField(
                    obscureText: true,
                    decoration: textInputDecoration.copyWith(hintText: 'Confirm Password'),
                    validator: (val) => val.length < 8 ? 'Password must be at least 8 chars long' : null,
                    onChanged: (val) {
                      setState(() => password = val);
                    },
                  ),
                  SizedBox(height: 20.0),
                  RaisedButton(
                      color: Colors.pink[400],
                      child: Text(
                        'Register',
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () async {
                        error = '';
                        if(_formKey.currentState.validate()) {
                          if(password != confirmPassword)
                          {
                            setState(() {
                              loading = false;
                              error = 'Passwords did not match';
                            });
                          }
                          else {
                            setState(() => loading = true);
                            dynamic result = await _auth
                                .registerWithEmailAndPassword(name, email, password);
                            if (result == null) {
                              setState(() {
                                loading = false;
                                error = 'That email is already in use.';
                              });
                            }
                          }
                        }
                      }
                  ),
                  SizedBox(height: 12.0),
                  Text(
                    error,
                    style: TextStyle(color: Colors.red, fontSize: 14.0),
                  )
                ],
              ),
          ),
        )
      ),
    );
  }
}