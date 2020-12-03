import 'package:cloud_firestore/cloud_firestore.dart';
import 'Shared/Idea.dart';
import 'Shared/User.dart';

class DatabaseService {

  final String uid;
  DatabaseService({ this.uid });

  // collection reference
  final CollectionReference ideasCollection = Firestore.instance.collection('ideas');

  final CollectionReference usersCollection = Firestore.instance.collection('users');

  Future<void> addUser(String name) async {
    return await usersCollection.document(uid).setData({
      'name' : name,
      'uid' : uid,
      'likedIdeas' : new List<String>(),
    });
  }

  Future<void> updateUser(UserData userData) async {
    return await usersCollection.document(uid).setData({
      'name' : userData.name,
      'uid' : userData.uid,
      'likedIdeas' : List.from(userData.votedIdeas),
    });
  }

  Future<void> addIdea(String idea, int votes) async {
    return await ideasCollection.add({
      'name' : idea,
      'votes' : votes,
    });
  }

  Future<void> updateIdeas(String idea, int votes, docID) async {
    return await ideasCollection.document(docID).updateData({
      'name' : idea,
      'votes' : votes,
    });
  }

  List<Idea> ideaListFromSnapshot(QuerySnapshot snapshot)
  {
    return snapshot.documents.map((doc){
      return Idea(
          name: doc.data['name'] ?? '',
          votes: doc.data['votes'] ?? 0,
          documentID: doc.documentID);
    }).toList();
  }

  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserData(uid, snapshot.data['name'], snapshot.data['likedIdeas']);
  }

  Stream<List<Idea>> get ideas {
    return ideasCollection.snapshots().map(ideaListFromSnapshot);
  }

  Stream<UserData> get userData {
    return usersCollection.document(this.uid).snapshots().map(_userDataFromSnapshot);
  }

}