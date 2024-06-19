// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:firebase_database/firebase_database.dart';

class User {
  final String nik;
  final String nama;
  final String kk;
  final String noTelepon;
  final String kataSandi;

  User({
    required this.nik,
    required this.nama,
    required this.kk,
    required this.noTelepon,
    required this.kataSandi,
  });

  User copyWith({
    String? nik,
    String? nama,
    String? kk,
    String? noTelepon,
    String? kataSandi,
  }) {
    return User(
      nik: nik ?? this.nik,
      nama: nama ?? this.nama,
      kk: kk ?? this.kk,
      noTelepon: noTelepon ?? this.noTelepon,
      kataSandi: kataSandi ?? this.kataSandi,
    );
  }

  static Future<void> add(User user) async {
    if (await User.get(user.nik) != null) throw 'NIK sudah terdaftar';

    final hashedPassword = sha1.convert(utf8.encode(user.kataSandi)).toString();
    final newUser = user.copyWith(kataSandi: hashedPassword);

    await FirebaseDatabase.instance
        .ref('users/${newUser.nik}')
        .set(newUser.toMap());
  }

  static Future<User?> get(String nik) async {
    final snapshot = await FirebaseDatabase.instance.ref('users/$nik').get();

    if (!snapshot.exists) return null;

    return User.fromMap(snapshot.value as Map);
  }

  static Future<void> resetKataSandi(String nik, String kataSandiBaru) async {
    final hashedPassword = sha1.convert(utf8.encode(kataSandiBaru)).toString();

    await FirebaseDatabase.instance
        .ref('users/$nik')
        .update({'kataSandi': hashedPassword});
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'nik': nik,
      'nama': nama,
      'kk': kk,
      'noTelepon': noTelepon,
      'kataSandi': kataSandi,
    };
  }

  factory User.fromMap(Map map) {
    return User(
      nik: map['nik'] as String,
      nama: map['nama'] as String,
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
    return 'User(nik: $nik, nama: $nama, kk: $kk, noTelepon: $noTelepon, kataSandi: $kataSandi)';
  }

  @override
  bool operator ==(covariant User other) {
    if (identical(this, other)) return true;

    return other.nik == nik &&
        other.nama == nama &&
        other.kk == kk &&
        other.noTelepon == noTelepon &&
        other.kataSandi == kataSandi;
  }

  @override
  int get hashCode {
    return nik.hashCode ^
        nama.hashCode ^
        kk.hashCode ^
        noTelepon.hashCode ^
        kataSandi.hashCode;
  }
}
