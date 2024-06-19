class UserModel {
  int id;
  String name;
  String email;
  String username;
  String? password;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.username,
    required this.password,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      username: json['username'],
      password: json['password'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'username': username,
      'password': password,
    };
  }
}
