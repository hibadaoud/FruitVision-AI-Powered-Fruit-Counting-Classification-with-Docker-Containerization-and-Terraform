import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final _auth = FirebaseAuth.instance;
  //SignIN
  Future<UserCredential> signInWithEmailPassword(String email, password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }

  //SignUp
  Future<UserCredential> signUpWithEmailPassword(
      String userName, email, password) async {
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);
      //Creating the user(document) in the firebase firestore Users
      FirebaseFirestore.instance
          .collection("Users")
          .doc(userCredential.user!.email)
          .set({'username': userName});
      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }

  //SignOut
  Future<void> signOut() async {
    return await _auth.signOut();
  }
}