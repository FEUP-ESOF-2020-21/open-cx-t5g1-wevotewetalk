import 'package:cloud_firestore/cloud_firestore.dart';

class Idea {
  final String name;
  final int votes;
  DocumentReference reference;

  Idea ({this.name, this.votes});

  Idea.fromMap(Map<String, dynamic> map, {this.reference})
      : assert(map['name'] != null),
        assert(map['votes'] != null),
        name = map['name'],
        votes = map['votes'];

  Idea.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data, reference: snapshot.reference);

}
