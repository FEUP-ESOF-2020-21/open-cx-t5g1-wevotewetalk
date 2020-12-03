class Idea with Comparable<Idea> {
  final String name;
  int votes;
  String documentID;

  Idea({this.name, this.votes, this.documentID});

  @override
  int compareTo(Idea other) {
    return this.name.compareTo(other.name);
  }
}
