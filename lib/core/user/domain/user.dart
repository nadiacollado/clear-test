typedef UserID = String;

class User {
  const User({
    required this.uid,
    required this.email,
  });
  final String uid;
  final String email;
}
