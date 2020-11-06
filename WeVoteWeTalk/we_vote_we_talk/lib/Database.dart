import 'package:cloud_firestore/cloud_firestore.dart';
import 'Idea.dart';

class DatabaseService {

  // collection reference
  final CollectionReference ideasCollection = Firestore.instance.collection('ideas');

  Future<void> updateIdeas(String idea) async {
    return await ideasCollection.document('ideas').setData({
      'ideas' : idea,
    });
  }

  List<Idea> _ideaListFromSnapshot(QuerySnapshot snapshot)
  {
    return snapshot.documents.map((doc){
      return Idea(idea: doc.data['ideas']) ?? "-empty-";
    }).toList();
  }

  Stream<List<Idea>> get ideas {
    return ideasCollection.snapshots().map(_ideaListFromSnapshot);
  }

}