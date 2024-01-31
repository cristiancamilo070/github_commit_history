import 'dart:convert';

import 'package:github_commit_history/domain/entities/user.dart';

UserModel profileModelFromJson(String str) =>
    UserModel.fromJson(json.decode(str));

String profileModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel extends User {
  const UserModel({
    required String id,
    String? name,
    String? email,
  }) : super(
          id: id,
          name: name,
          email: email,
        );

  @override
  String toString() {
    return 'id: $id, name: $name, email: $email';
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] ?? 0,
      name: map['name'] ?? '',
      email: map['email'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source));
}
