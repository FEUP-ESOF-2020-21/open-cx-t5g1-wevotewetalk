class ConferenceData {

  String name;
  bool brainstorm;
  bool voting;
  bool joinTalks;
  var banned;

  ConferenceData(name, brainstorm, voting, joinTalks, list) {
    this.name = name;
    this.brainstorm = brainstorm;
    this.voting = voting;
    this.joinTalks = joinTalks;
    this.banned = List.from(list);
  }

  isBanned(String uid) {
    for(int i = 0; i < banned.length; i++)
    {
      if(banned[i] == uid)
        return true;
    }
    return false;
  }

  ban(String uid) {
    banned.add(uid);
  }

  unban(String uid) {
    banned.remove(uid);
  }

}