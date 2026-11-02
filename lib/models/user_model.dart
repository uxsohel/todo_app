class UserModel {
  final String? id;
  final String name;
  final String email;
  final String password;
  final String? avatar;

  UserModel({
    this.id,
    required this.name,
    required this.email,
    required this.password,
    this.avatar,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id']?.toString(),
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      password: json['password'] ?? '',
      avatar: json['avatar'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'password': password,
    };
  }
}