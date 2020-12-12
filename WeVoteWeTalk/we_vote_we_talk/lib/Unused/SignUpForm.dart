import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../shared/GenericWidgets.dart';
import '../StartPage.dart';

class SignUpForm extends StatefulWidget {

  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _formKey = GlobalKey<FormState>();
  var _passKey = GlobalKey<FormFieldState>();

  TextEditingController tecName = new TextEditingController();
  TextEditingController tecEmail = new TextEditingController();
  TextEditingController tecPassword = new TextEditingController();

  String _name = "";
  String _email = "";
  String _password = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
                      title: Text('We Vote We Talk'),
                      backgroundColor: Color(0xFF106799),
      ),
      body: new Form(
          key: _formKey,
          child: ListView(
            children: getListWidget(),
          )
      ),
    );
  }

  List<Widget> getListWidget() {
    List<Widget> list = new List();

    list.add(title());
    list.add(nameInput());
    list.add(emailInput());
    list.add(passwordInput());
    list.add(confirmPasswordInput());
    list.add(blueButton('Sign Up', pressSignUpButton));

    return list;
  }

  Widget title() {
    return Text(
      '\nSign up\n',
      style: TextStyle(fontSize: 32.0,),
      textAlign: TextAlign.center,
    );
  }

  Widget nameInput(){
    return Padding(
        padding: EdgeInsets.symmetric(
          vertical: 10.0,
          horizontal: 20.0,
        ),
        child: TextFormField(
          controller: tecName,
          decoration: InputDecoration(labelText: 'First and Last Name *'),
          validator: (value) {
            return value.isEmpty || !value.contains(' ') ? 'Enter your first and last name.' : null;
          },
        )
    );
  }

  Widget emailInput(){
    return Padding(
        padding: EdgeInsets.symmetric(
          vertical: 10.0,
          horizontal: 20.0,
        ),
        child: TextFormField(
          controller: tecEmail,
          decoration: InputDecoration(labelText: 'Email *'),
          keyboardType: TextInputType.emailAddress,
          validator: validateEmail,
        )
    );
  }

  String validateEmail(String value) {
    if (value.isEmpty) {
      return 'Please enter mail';
    }

    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value))
      return 'Enter Valid Email';
    else
      return null;
  }

  Widget passwordInput(){
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: 10.0,
        horizontal: 20.0,
      ),
      child: TextFormField(
          controller: tecPassword,
          key: _passKey,
          obscureText: true,
          decoration: InputDecoration(labelText: 'Password *'),
          validator: (value) {
            if (value.isEmpty) return 'Please Enter password';
            if (value.length < 8)
              return 'Password should be more than 8 characters';
            return null;
          }
      ),
    );
  }

  Widget confirmPasswordInput(){
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: 10.0,
        horizontal: 20.0,
      ),
      child: TextFormField(
        obscureText: true,
        decoration: InputDecoration(labelText: 'Confirm Password *'),
        validator: (confirmPassword) {
          if (confirmPassword.isEmpty) return 'Enter confirm password';
          var password = _passKey.currentState.value;
          if (confirmPassword != password)
            return 'Confirm Password invalid';
          return null;
        },
      ),
    );
  }

  pressSignUpButton(){
    setState(() {
      _name = tecName.text;
      _email = tecEmail.text;
      _password = tecPassword.text;
    });


    if (_formKey.currentState.validate()){
      navigateToStartPage();
    }

  }

  Future navigateToStartPage() async {
    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => StartPage()), (Route<dynamic> route) => false);
  }
}

























