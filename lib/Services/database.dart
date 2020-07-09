import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_firebase/Models/brew.dart';
import 'package:flutter_firebase/Models/user.dart';

class DatabaseService {
  
  final String uid;
  DatabaseService({this.uid});

  //collection reference
  final CollectionReference brewCollection = Firestore.instance.collection('Brews');
  
  Future updateUserData(String sugars, String brewName, int strength,String name) async {
    return await brewCollection.document(uid).setData({
      'sugars': sugars,
      'brewName': brewName,
      'strength': strength,
      'name': name,
    });
  }

  //brew list from snapshot
  List<Brew> _brewListFromSnapshot(QuerySnapshot snapshot){
    return snapshot.documents.map((doc){
      return Brew(
        brewName: doc.data['brewName'] ?? '',
        name: doc.data['name'] ?? '',
        strength: doc.data['strength'] ?? 0,
        sugars: doc.data['sugars'] ?? '0',
      );
    }).toList();
  }

  //userData from Snapshot
  UserData _userDataFromSnapshot(DocumentSnapshot snapshot){
    return UserData(
      uid: uid,
      name: snapshot.data['name'],
      brewName: snapshot.data['brewName'],
      sugars: snapshot.data['sugars'],
      strength: snapshot.data['strength'],
    );
  }

  //get brews stream                    
  Stream<List<Brew>> get brews {
    return brewCollection.snapshots()
    .map(_brewListFromSnapshot);
  }

  //get user doc stream                    
  Stream<UserData> get userData {
    return brewCollection.document(uid).snapshots()
    .map(_userDataFromSnapshot);
  }

}