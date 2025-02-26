class UserProfileFormState {
  const UserProfileFormState({
    this.username = '',
  });
  final String username;

  UserProfileFormState copyWith({
    String? username,
  }) {
    return UserProfileFormState(
      username: username ?? this.username,
    );
  }
}
