import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class Pengguna {
  final String nik;
  final String nama;
  final String kk;
  final String email;
  final String kataSandi;
  final List riwayatETiket;

  static final url = dotenv.env['SERVER_URL']! + '/pengguna';

  Pengguna({
    required this.nik,
    required this.nama,
    required this.kk,
    required this.email,
    required this.kataSandi,
    List? riwayatETiket,
  }) : riwayatETiket = riwayatETiket ?? [];

  Pengguna copyWith({
    String? nik,
    String? nama,
    String? kk,
    String? email,
    String? kataSandi,
    List? riwayatETiket,
  }) {
    return Pengguna(
      nik: nik ?? this.nik,
      nama: nama ?? this.nama,
      kk: kk ?? this.kk,
      email: email ?? this.email,
      kataSandi: kataSandi ?? this.kataSandi,
      riwayatETiket: riwayatETiket ?? this.riwayatETiket,
    );
  }

  static Future<void> add(Pengguna pengguna) async {
    final Map<String, dynamic> response = json.decode((await http.post(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: pengguna.toJson(),
    ))
        .body);

    if (response['status'] == 'failed') throw response['message'];
  }

  static Future<Pengguna> get(String nik) async {
    final Map<String, dynamic> response = json.decode((await http.get(
      Uri.parse(url + '/' + nik),
      headers: <String, String>{
        'Accept': 'application/json; charset=UTF-8',
      },
    ))
        .body);

    if (response['status'] == 'failed') throw response['message'];

    return Pengguna.fromMap(response['pengguna']);
  }

  static Future<String> kirimEmailVerifikasi(String emailPenerima) async {
    final url =
        '${dotenv.env['SERVER_URL']}/kirim-email-verifikasi/$emailPenerima';

    final Map<String, dynamic> response = json.decode((await http.post(
      Uri.parse(url),
      headers: <String, String>{
        'Accept': 'application/json; charset=UTF-8',
      },
    ))
        .body);

    if (response['status'] == 'failed') {
      if (response['code'] == 553) throw 'Email tidak valid';

      return response['message'];
    }

    return response['kode_verifikasi'];
  }

  static Future<void> gantiKataSandi(String nik, String kataSandiBaru) async {
    final url = '${dotenv.env['SERVER_URL']}/ganti-kata-sandi/$nik';

    final Map<String, dynamic> response = json.decode((await http.patch(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: json.encode({"kata_sandi": kataSandiBaru}),
    ))
        .body);

    if (response['status'] == 'failed') throw response['message'];
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'nik': nik,
      'nama': nama,
      'kk': kk,
      'email': email,
      'kata_sandi': kataSandi,
      'riwayat_e_tiket': riwayatETiket,
    };
  }

  factory Pengguna.fromMap(Map map) {
    return Pengguna(
      nik: map['nik'] as String,
      nama: map['nama'] as String,
      kk: map['kk'] as String,
      email: map['email'] as String,
      kataSandi: map['kata_sandi'] as String,
      riwayatETiket: map['riwayat_e_tiket'] as List,
    );
  }

  String toJson() => json.encode(toMap());

  factory Pengguna.fromJson(String source) =>
      Pengguna.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Pengguna(nik: $nik, nama: $nama, kk: $kk, email: $email, kataSandi: $kataSandi, riwayatETiket: $riwayatETiket)';
  }

  @override
  bool operator ==(covariant Pengguna other) {
    if (identical(this, other)) return true;

    return other.nik == nik &&
        other.nama == nama &&
        other.kk == kk &&
        other.email == email &&
        other.kataSandi == kataSandi &&
        other.riwayatETiket == riwayatETiket;
  }

  @override
  int get hashCode {
    return nik.hashCode ^
        nama.hashCode ^
        kk.hashCode ^
        email.hashCode ^
        kataSandi.hashCode ^
        riwayatETiket.hashCode;
  }
}
