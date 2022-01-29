import 'package:finance_tracker/app/repository/auth_irepository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
class AuthRepository implements AuthIRepository{
  final FirebaseAuth _auth;
  AuthRepository():_auth  = FirebaseAuth.instance;



  @override
  Future<void> googleSignIn() {
    throw UnimplementedError();
  }

  @override
  Future<void> ignInAnonymously() {
    throw UnimplementedError();
  }

  @override
  Future<void> emailSignIn({required String email, required String password}) async{
    try {
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email,
          password: password
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        debugPrint('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        debugPrint('The account already exists for that email.');
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}