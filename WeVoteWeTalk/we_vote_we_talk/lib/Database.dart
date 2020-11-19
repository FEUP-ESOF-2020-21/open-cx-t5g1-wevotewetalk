import 'package:cloud_firestore/cloud_firestore.dart';
import 'Shared/Idea.dart';

class DatabaseService {

  final String docID;
  DatabaseService({ this.docID });

  // collection reference
  final CollectionReference ideasCollection = Firestore.instance.collection('ideas');

  Future<void> addIdea(String idea, int votes) async {
    return await ideasCollection.add({
      'name' : idea,
      'votes' : votes,
    });
  }

  Future<void> updateIdeas(String idea, int votes) async {
    return await ideasCollection.document(docID).updateData({
      'name' : idea,
      'votes' : votes,
    });
  }

  List<Idea> _ideaListFromSnapshot(QuerySnapshot snapshot)
  {
    return snapshot.documents.map((doc){
      return Idea(
          name: doc.data['name'] ?? '',
          votes: doc.data['votes'] ?? 0,
          documentID: doc.documentID);
    }).toList();
  }

  Stream<List<Idea>> get ideas {
    return ideasCollection.snapshots().map(_ideaListFromSnapshot);
  }

}