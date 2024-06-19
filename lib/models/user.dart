import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:firebase_database/firebase_database.dart';

class User {
  final String id;
  final String nama;
  final String nik;
  final String kk;
  final String noTelepon;
  final String kataSandi;

  User({
    required this.id,
    required this.nama,
    required this.nik,
    required this.kk,
    required this.noTelepon,
    required this.kataSandi,
  });

  factory User.autoID({
    required String nama,
    required String nik,
    required String kk,
    required String noTelepon,
    required String kataSandi,
  }) {
    final id = DateTime.now().millisecondsSinceEpoch.toString();

    return User(
      id: id,
      nama: nama,
      nik: nik,
      kk: kk,
      noTelepon: noTelepon,
      kataSandi: kataSandi,
    );
  }

  User copyWith({
    String? id,
    String? nama,
    String? nik,
    String? kk,
    String? noTelepon,
    String? kataSandi,
  }) {
    return User(
      id: id ?? this.id,
      nama: nama ?? this.nama,
      nik: nik ?? this.nik,
      kk: kk ?? this.kk,
      noTelepon: noTelepon ?? this.noTelepon,
      kataSandi: kataSandi ?? this.kataSandi,
    );
  }

  static Future<void> add(User user) async {
    final hashedPassword = sha1.convert(utf8.encode(user.kataSandi)).toString();
    final newUser = user.copyWith(kataSandi: hashedPassword);

    await FirebaseDatabase.instance
        .ref('users/${newUser.id}')
        .set(newUser.toMap());
  }

  static Future<User?> get(String userID) async {
    final snapshot = await FirebaseDatabase.instance.ref('users/$userID').get();

    if (!snapshot.exists) {
      print('User tidak ditemukan!');
      return null;
    }

    print(snapshot.value);
    return User.fromMap(snapshot.value as Map<String, dynamic>);
  }

  static Future<void> resetKataSandi(
      String userID, String kataSandiBaru) async {
    final hashedPassword = sha1.convert(utf8.encode(kataSandiBaru)).toString();

    await FirebaseDatabase.instance
        .ref('users/${userID}')
        .update({'kataSandi': hashedPassword});
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'nama': nama,
      'nik': nik,
      'kk': kk,
      'noTelepon': noTelepon,
      'kataSandi': kataSandi,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'] as String,
      nama: map['nama'] as String,
      nik: map['nik'] as String,
      kk: map['kk'] as String,
      noTelepon: map['noTelepon'] as String,
      kataSandi: map['kataSandi'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) =>
      User.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'User(id: $id, nama: $nama, nik: $nik, kk: $kk, noTelepon: $noTelepon, kataSandi: $kataSandi)';
  }

  @override
  bool operator ==(covariant User other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.nama == nama &&
        other.nik == nik &&
        other.kk == kk &&
        other.noTelepon == noTelepon &&
        other.kataSandi == kataSandi;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        nama.hashCode ^
        nik.hashCode ^
        kk.hashCode ^
        noTelepon.hashCode ^
        kataSandi.hashCode;
  }
}
