import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

import '../../../core/firebase/firebase_bootstrap.dart';

class FirebaseAuthRepository {
  FirebaseAuth? get _auth =>
      FirebaseBootstrap.isReady ? FirebaseAuth.instance : null;

  bool get isAvailable => _auth != null;

  Future<UserCredential> signInWithEmail(String email, String password) async {
    final auth = _auth;
    if (auth == null) {
      throw StateError('Firebase Auth is not initialized');
    }
    return auth.signInWithEmailAndPassword(email: email, password: password);
  }

  Future<UserCredential> registerWithEmail(String email, String password) async {
    final auth = _auth;
    if (auth == null) {
      throw StateError('Firebase Auth is not initialized');
    }
    return auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<void> signOut() async {
    try {
      await _auth?.signOut();
    } catch (e) {
      debugPrint('Firebase signOut: $e');
    }
  }
}
