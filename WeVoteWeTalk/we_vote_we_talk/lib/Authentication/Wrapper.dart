import 'package:we_vote_we_talk/ConferenceSelection/ConferenceSelect.dart';
import 'package:we_vote_we_talk/Database.dart';

import '../Authenticate.dart';
import '../MainMenu.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:we_vote_we_talk/Shared/User.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    var user = Provider.of<User>(context);
    // return either the Home or Authenticate widget
    if (user == null){
      return Authenticate();
    } else {
      return ConferenceSelect(user_id: user.uid);
    }
  }
}