import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

class  FirebaseBd {

  static var auth = FirebaseAuth.instance;
  static var db  = FirebaseFirestore.instance;


}