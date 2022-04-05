class User {
  final String uid;
  late final String role;
  final String name;
  final String email;
  final String password;

  User(
      {required this.uid,
      required this.role,
      required this.name,
      required this.email,
      required this.password});

  Map<String, dynamic> toJson() => {
        'uid': uid,
        'role': role,
        'name': name,
        'email': email,
        'password': password,
      };

  static User fromJson(Map<String, dynamic> json) => User(
        uid: json['uid'],
        role: json['role'],
        name: json['name'],
        email: json['email'],
        password: json['password'],
      );

  @override
  String toString() {
    return 'User{uid: $uid, role: $role, name: $name, email: $email, password: $password}';
  }
}
