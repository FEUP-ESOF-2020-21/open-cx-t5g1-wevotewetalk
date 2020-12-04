import 'Idea.dart';

class User {

  final String uid;
  User({this.uid});

}

class UserData {

  String uid;
  var votedIdeas;
  String name;

  UserData(uid, name, list) {
    this.uid = uid;
    this.name = name;
    this.votedIdeas = List.from(list);
  }

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

  removeIdea(String idea) {
    //votedIdeas.removeWhere((item) => item.name == 'idea');
    votedIdeas.remove(idea);
  }

}