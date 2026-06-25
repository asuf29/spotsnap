class AuthSession {
  const AuthSession({
    this.hasCompletedOnboarding = false,
    this.isAuthenticated = false,
    this.isGuest = true,
    this.email,
  });

  final bool hasCompletedOnboarding;
  final bool isAuthenticated;
  final bool isGuest;
  final String? email;

  AuthSession copyWith({
    bool? hasCompletedOnboarding,
    bool? isAuthenticated,
    bool? isGuest,
    String? email,
  }) {
    return AuthSession(
      hasCompletedOnboarding:
          hasCompletedOnboarding ?? this.hasCompletedOnboarding,
      isAuthenticated: isAuthenticated ?? this.isAuthenticated,
      isGuest: isGuest ?? this.isGuest,
      email: email ?? this.email,
    );
  }
}
