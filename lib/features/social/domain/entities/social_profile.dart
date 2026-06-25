class SocialProfile {
  const SocialProfile({
    required this.displayName,
    required this.username,
    this.instagramHandle,
    this.bio,
  });

  final String displayName;
  final String username;
  final String? instagramHandle;
  final String? bio;

  SocialProfile copyWith({
    String? displayName,
    String? username,
    String? instagramHandle,
    String? bio,
  }) {
    return SocialProfile(
      displayName: displayName ?? this.displayName,
      username: username ?? this.username,
      instagramHandle: instagramHandle ?? this.instagramHandle,
      bio: bio ?? this.bio,
    );
  }
}
