import 'dart:convert';

class UserModel {
  final int? id;
  final String? nama;
  final String? email;
  final String? password;

  UserModel({this.id, this.nama, this.email, this.password});

  Map<String, dynamic> toMap() {
    print('toMap() called:');
    print('   id: $id');
    print('   nama: $nama');
    print('   email: $email');
    print('   password: $password');

    return {'nama': nama, 'email': email, 'password': password};
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] as int?,
      nama: map['nama'] as String?,
      email: map['email'] as String?,
      password: map['password'] as String?,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
