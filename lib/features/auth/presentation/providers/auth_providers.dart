import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/config/app_config.dart';
import '../../data/auth_persistence.dart';
import '../../data/firebase_auth_repository.dart';
import '../../domain/entities/auth_session.dart';

class AuthNotifier extends StateNotifier<AuthSession> {
  AuthNotifier(
    this._persistence,
    AuthSession initial, {
    FirebaseAuthRepository? firebase,
  })  : _firebase = firebase,
        super(initial);

  final AuthPersistence _persistence;
  final FirebaseAuthRepository? _firebase;

  Future<void> _persist(AuthSession next) async {
    state = next;
    await _persistence.save(next);
  }

  Future<void> completeOnboarding() => _persist(
        state.copyWith(hasCompletedOnboarding: true),
      );

  Future<void> signInGuest() async {
    await _firebase?.signOut();
    await _persist(
      state.copyWith(
        isAuthenticated: true,
        isGuest: true,
        email: null,
      ),
    );
  }

  Future<void> signInWithEmail(String email, {String password = ''}) async {
    final firebase = _firebase;
    if (AppConfig.useFirebase &&
        firebase != null &&
        firebase.isAvailable &&
        password.length >= 6) {
      try {
        await firebase.signInWithEmail(email, password);
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          await firebase.registerWithEmail(email, password);
        } else {
          rethrow;
        }
      }
    }
    await _persist(
      state.copyWith(
        isAuthenticated: true,
        isGuest: false,
        email: email,
      ),
    );
  }

  Future<void> signOut() async {
    await _firebase?.signOut();
    await _persistence.clear();
    state = const AuthSession();
  }
}

final authSessionProvider =
    StateNotifierProvider<AuthNotifier, AuthSession>(
  (ref) => throw UnimplementedError('Override via AppBootstrap.load()'),
);

final firebaseAuthRepositoryProvider = Provider<FirebaseAuthRepository>(
  (ref) => FirebaseAuthRepository(),
);
