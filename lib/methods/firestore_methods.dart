import 'dart:core';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';



class FirestoreMethods{


  String? currentUserMail = FirebaseAuth.instance.currentUser?.email;




  DatabaseReference ref = FirebaseDatabase.instance.ref("users/123");








  String _collectionName = "Docs";
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;



  Stream<List<String>> getDocuments() {
    return firebaseFirestore
        .collection(_collectionName)
        .snapshots()
        .map((event) {
      return event.docs.map((e) => e.id).toList();
    });
  }

  void addEnter(ref2,String enter,) async {

    await ref2.set({
      "enter": enter,
    });
  }

  void addExit(ref2,String exit) async {

    await ref2.set({
      "exit": exit,
    });
  }

  void addData(ref2,String enter,String exit) async {

    await ref2.set({
      "enter": enter,
    });
    }


    // int length = 0;
    // var ref = firebaseFirestore.collection('users');

    // length = await ref.get().then((value) => value.docs.length);
    // ref.doc(length.toString()).set({'docName': length.toString()});


    // firebaseFirestore.collection('users').add(user).then((value) => print('DocumentSnapshot added with ID:'));
    // firebaseFirestore.collection('users').doc(currentUser?.uid.toString()).set(user);


    // await newPostRef.set(data);
    // await docRef.set(city);
    // final washingtonRef = db.collection("cities").doc("LA");
    //  await washingtonRef.update({"capital" : true}).then((value) => print('awdwadwa')).onError((error, stackTrace) => print(error.toString()));  //Edit

    // db.collection("cities").doc("new-city-id").set({"name": "Chicago"});
    // db.collection("cities").add(data).then((documentSnapshot) =>
    //     print("Added Data with ID: ${documentSnapshot.id}"));

  void updateData() async {
    await ref.update({"age": 19});
  }

  void delete(String id) async {
    firebaseFirestore.collection(_collectionName).doc(id).delete();
  }
}




