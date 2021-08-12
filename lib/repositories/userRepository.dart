import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserRepository {
  final FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _firestore;

  UserRepository({FirebaseFirestore? firestore, FirebaseAuth? firebaseAuth})
      : _firestore = firestore ?? FirebaseFirestore.instance,
        _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;

  Future<void> singInWithEmail(String email, String password) async {
    await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
  }

  Future<bool> isFirstTime(String userId) async {
    bool exists = false;
    await FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .get()
        .then((user) => {exists = user.exists});
    return exists;
  }

  Future<void> signUpWithEmail(String email, String password) async {
    print(_firebaseAuth);
    await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  Future<bool> isSignedIn() async {
    return _firebaseAuth.currentUser!=null;

  }

  Future<String?> getUser() async {
    return _firebaseAuth.currentUser?.uid;
  }
}
