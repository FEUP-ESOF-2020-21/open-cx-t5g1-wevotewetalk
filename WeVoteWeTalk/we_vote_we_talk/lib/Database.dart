import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'Shared/Idea.dart';
import 'Shared/User.dart';

class DatabaseService {

  final String uid;
  final String code;
  DatabaseService(this.uid, this.code);

  // collection reference

  final CollectionReference talksCollection = Firestore.instance.collection('talks');

  final CollectionReference usersCollection = Firestore.instance.collection('users');

  Future<void> addUser(String name) async {
    return await usersCollection.document(uid).setData({
      'name' : name,
      'uid' : uid,
      'joinedConferences' : new List<String>(),
    });
  }

  Future<void> addUserToTalk(UserData userData) async {
    return await talksCollection.document(code).collection('users').document(uid).setData({
      'name' : userData.name,
      'uid' : uid,
      'likedIdeas' : new List<String>(),
      'moderator' : false,
    });
  }

  Future<void> updateUser(UserData userData) async {
    return await usersCollection.document(uid).setData({
      'name' : userData.name,
      'uid' : userData.uid,
      'joinedConferences' : List.from(userData.joinedConferences),
    });
  }

  Future<void> updateUserTalk(ConferenceUserData userData) async {
    return await talksCollection.document(code).collection("users").document(uid).setData({
      'name' : userData.name,
      'uid' : userData.uid,
      'likedIdeas' : List.from(userData.votedIdeas),
      'moderator' : userData.moderator,
    });
  }

  Future<void> addIdea(String idea, int votes) async {
    return await talksCollection.document(code).collection("ideas").add({
      'name' : idea,
      'votes' : votes,
    });
  }

  Future<void> updateIdeas(String idea, int votes, docID) async {
    return await talksCollection.document(code).collection("ideas").document(docID).updateData({
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
    return UserData(uid, snapshot.data['name'], snapshot.data['joinedConferences']);
  }

  Stream<List<Idea>> get ideas {
    return talksCollection.document(code).collection("ideas").snapshots().map(ideaListFromSnapshot);
  }

  Stream<UserData> get userData {
    return usersCollection.document(uid).snapshots().map(_userDataFromSnapshot);
  }

  ConferenceUserData _conferenceUserDataFromSnapshot(DocumentSnapshot snapshot) {
    return ConferenceUserData(uid, snapshot.data['moderator'], snapshot.data['name'], snapshot.data['likedIdeas']);
  }

  Stream<ConferenceUserData> get conferenceUserData {
    return talksCollection.document(code).collection('users').document(uid).snapshots().map(_conferenceUserDataFromSnapshot);
  }

  Future<int> existsConferenceWithoutUser() async {
    var doc = await talksCollection.document(code).get();
    if(doc.exists)
    {
      var usr = await talksCollection.document(code).collection('users').document(uid).get();
      if(!usr.exists) // user nao existe
        return 0;
      else
        return 2; // user exite
    }
    return 1; // conferencia nao existe
  }

  String createConference(String conferenceName, UserData userData) {

    var docID = talksCollection.document().documentID;

    talksCollection.document(docID).setData({
      'name' : conferenceName,
    });

    talksCollection.document(docID).collection('ideas');
    talksCollection.document(docID).collection('users').document(uid).setData({
      'name' : userData.name,
      'moderator' : true,
      'uid' : uid,
      'likedIdeas' : new List<String>(),
    });

    return docID;
  }


  String _conferenceNameFromSnapshot(DocumentSnapshot snapshot) {
    return snapshot.data['name'];
  }

  Stream<String> get conferenceName {
    return talksCollection.document(code).snapshots().map(_conferenceNameFromSnapshot);
  }

  
}