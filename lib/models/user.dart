class User {
  final String uid;
  final String role;
  final String name;

  User({required this.uid, required this.role, required this.name});

  @override
  String toString() {
    return 'User{uid: $uid, role: $role, name: $name}';
  }
}
