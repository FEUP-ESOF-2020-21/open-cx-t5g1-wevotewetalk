import 'package:flutter/material.dart';

import '../shared/GenericWidgets.dart';
import 'ManageUsers.dart';
import 'MaganeUserInterface.dart';
import 'ManageSchedule.dart';
import 'OrderVotes.dart';
import 'ManageThemes.dart';

class ModeratorOptions extends StatefulWidget {
  @override
  _ModeratorOptionsState createState() => _ModeratorOptionsState();
}

class _ModeratorOptionsState extends State<ModeratorOptions> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: options(),
            )
        )
    );
  }

  List<Widget> options(){
    List<Widget> list = new List();
    list.add(button('Manage User Interface', navigateToManageUserInterface));
    list.add(button('Manage Themes', navigateToManageThemes));
    list.add(button('Manage Schedule', navigateToManageSchedule));
    list.add(button('Manage Users', navigateToBanUser));
    list.add(button('Order Votes', navigateToOrderVotes));
    list.add(button('Main Menu', navigateBackToMainMenu));
    return list;
  }



  Future navigateToManageUserInterface() async {
    Navigator.push(context, MaterialPageRoute(builder: (context) => ManageUserInterface()));
  }

  Future navigateToManageThemes() async {
    Navigator.push(context, MaterialPageRoute(builder: (context) => ManageThemes()));
  }

  Future navigateToManageSchedule() async {
    Navigator.push(context, MaterialPageRoute(builder: (context) => ManageSchedule()));
  }

  Future navigateToBanUser() async {
    Navigator.push(context, MaterialPageRoute(builder: (context) => ManageUsers()));
  }

  Future navigateToOrderVotes() async {
    Navigator.push(context, MaterialPageRoute(builder: (context) => MyApp()));
  }

  Future navigateBackToMainMenu() async {
    Navigator.pop(context);
  }

}
