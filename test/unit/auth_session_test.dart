import 'package:flutter_test/flutter_test.dart';
import 'package:snapspot/features/auth/domain/entities/auth_session.dart';

void main() {
  group('AuthSession', () {
    test('default values', () {
      const session = AuthSession();
      expect(session.hasCompletedOnboarding, false);
      expect(session.isAuthenticated, false);
      expect(session.isGuest, true);
      expect(session.email, isNull);
    });

    test('copyWith preserves unset fields', () {
      const session = AuthSession(
        hasCompletedOnboarding: true,
        isAuthenticated: true,
        isGuest: false,
        email: 'test@test.com',
      );
      final updated = session.copyWith(isGuest: true);
      expect(updated.hasCompletedOnboarding, true);
      expect(updated.isAuthenticated, true);
      expect(updated.isGuest, true);
      expect(updated.email, 'test@test.com');
    });

    test('copyWith overrides all fields', () {
      const session = AuthSession();
      final updated = session.copyWith(
        hasCompletedOnboarding: true,
        isAuthenticated: true,
        isGuest: false,
        email: 'user@snap.com',
      );
      expect(updated.hasCompletedOnboarding, true);
      expect(updated.isAuthenticated, true);
      expect(updated.isGuest, false);
      expect(updated.email, 'user@snap.com');
    });
  });
}
