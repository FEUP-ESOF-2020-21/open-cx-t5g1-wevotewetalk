import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'Shared/Idea.dart';
import 'Shared/User.dart';

class DatabaseService {

  final String uid;
  final String code;
  bool moderator;
  DatabaseService(this.uid, this.code);

  // collection reference

  final CollectionReference talksCollection = Firestore.instance.collection('talks');

  final CollectionReference ideasCollection = Firestore.instance.collection('ideas');

  final CollectionReference usersCollection = Firestore.instance.collection('users');

  Future<void> addUser(String name) async {
    return await usersCollection.document(uid).setData({
      'name' : name,
      'uid' : uid,
      'likedIdeas' : new List<String>(),
    });
  }

  Future<void> addUserToTalk(ConferenceUserData userData) async {
    return await talksCollection.document(code).collection('users').document(uid).setData({
      'name' : userData.name,
      'uid' : uid,
      'likedIdeas' : new List<String>(),
      'moderator' : userData.moderator,
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

  ConferenceUserData _conferenceUserDataFromSnapshot(DocumentSnapshot snapshot) {
    print(snapshot.data['moderator']);
    print(snapshot.data['name']);
    print(snapshot.data['likedIdeas']);
    return ConferenceUserData(uid, snapshot.data['moderator'], snapshot.data['name'], snapshot.data['likedIdeas']);
  }

  Stream<ConferenceUserData> get conferenceUserData {
    return usersCollection.document(this.uid).snapshots().map(_conferenceUserDataFromSnapshot);
  }



  Future<bool> existsConference() async {
    var doc = await talksCollection.document(code).get();
    return doc.exists;
  }

/*
  Future<void> addConference(String name) async {
    CollectionReference newTalk = await talksCollection.add({
      'name' : name,
    });


    await newTalk.document(uid).setData({
      'name' : userData.name,
      'uid' : userData.uid,
      'likedIdeas' : List.from(userData.votedIdeas),
    });


  }
*/
}