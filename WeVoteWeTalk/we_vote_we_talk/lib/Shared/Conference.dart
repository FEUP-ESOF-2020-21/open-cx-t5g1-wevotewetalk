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

  ban(String uid) {
    banned.add(uid);
  }

  unban(String uid) {
    banned.remove(uid);
  }

}