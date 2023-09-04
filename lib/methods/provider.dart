import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';


class CameProvider with ChangeNotifier{






  String? currentUserMail = FirebaseAuth.instance.currentUser?.email;
  var currentUser = FirebaseAuth.instance.currentUser;



  DatabaseReference ref = FirebaseDatabase.instance.ref("");
}