import 'Idea.dart';

class User {

  final String uid;
  User({this.uid});

}


class UserData {

  final String uid;
  List votedIdeas;
  final String name;

  UserData({this.uid, this.name, this.votedIdeas});

  hasVoted(String idea)
  {
    for(int i = 0; i < votedIdeas.length; i++)
    {
      if(votedIdeas[i] == idea)
        return true;
    }
    return false;
  }

  vote(String idea) {
    votedIdeas.add(idea);
  }

}