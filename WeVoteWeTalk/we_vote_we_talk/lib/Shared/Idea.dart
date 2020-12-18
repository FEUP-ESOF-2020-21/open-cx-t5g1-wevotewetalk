class Idea with Comparable<Idea> {
  final String name;
  int votes;
  String documentID;
  int index;

  Idea({this.name, this.votes, this.documentID, this.index});

  @override
  int compareTo(Idea other) {
    return this.name.compareTo(other.name);
  }
}
