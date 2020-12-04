import 'Idea.dart';

class User {

  final String uid;
  User({this.uid});

}


class UserData {

  String uid;
  var joinedConferences;
  String name;

  UserData(uid, name, list) {
    this.uid = uid;
    this.name = name;
    this.joinedConferences = List.from(list);
  }

  addConference(String code) {
    joinedConferences.add(code);
  }

}

class ConferenceUserData {

  String uid;
  var votedIdeas;
  String name;
  bool moderator;

  ConferenceUserData(uid, moderator, name, list) {
    this.uid = uid;
    this.name = name;
    this.votedIdeas = List.from(list);
    print("crl");
    print(moderator);
    this.moderator = moderator;
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