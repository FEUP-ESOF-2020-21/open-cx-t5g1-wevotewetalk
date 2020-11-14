class Idea with Comparable<Idea>{
  final String name;
  int votes;

  Idea ({this.name, this.votes});

  @override
  int compareTo(Idea other) {
    return this.name.compareTo(other.name);
  }

}
