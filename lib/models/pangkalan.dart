import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class Pangkalan {
  final String? id;
  final String nama;
  final String alamat;
  final int harga;
  final int stok;
  final String email;
  final String telepon;
  final String gmap;
  final String kataSandi;
  final List coordinates;
  final List foto;
  final List ulasan;

  Pangkalan({
    this.id,
    required this.nama,
    required this.alamat,
    required this.harga,
    required this.stok,
    required this.email,
    required this.telepon,
    required this.gmap,
    required this.kataSandi,
    required this.coordinates,
    required this.foto,
    required this.ulasan,
  });

  static final url = '${dotenv.env['SERVER_URL']}/pangkalan';

  Pangkalan copyWith({
    String? id,
    String? nama,
    String? alamat,
    int? harga,
    int? stok,
    String? email,
    String? telepon,
    String? gmap,
    String? kataSandi,
    List? coordinates,
    List? foto,
    List? ulasan,
  }) {
    return Pangkalan(
      id: id ?? this.id,
      nama: nama ?? this.nama,
      alamat: alamat ?? this.alamat,
      harga: harga ?? this.harga,
      stok: stok ?? this.stok,
      email: email ?? this.email,
      telepon: telepon ?? this.telepon,
      gmap: gmap ?? this.gmap,
      kataSandi: kataSandi ?? this.kataSandi,
      coordinates: coordinates ?? this.coordinates,
      foto: foto ?? this.foto,
      ulasan: ulasan ?? this.ulasan,
    );
  }

  static Future<List<Pangkalan>> get({String? search}) async {
    final Map<String, dynamic> response = json.decode((await http.get(
      Uri.parse(search == null ? url : '$url?search=$search'),
      headers: <String, String>{
        'Accept': 'application/json; charset=UTF-8',
      },
    ))
        .body);

    if (response['status'] == 'failed') throw response['message'];

    final List<Pangkalan> daftarPangkalan = [];

    for (Map<String, dynamic> pangkalan in response['pangkalan']) {
      daftarPangkalan.add(
        Pangkalan(
          id: pangkalan['_id'],
          nama: pangkalan['nama'],
          alamat: pangkalan['alamat'],
          harga: pangkalan['harga'],
          stok: pangkalan['stok'],
          email: pangkalan['email'],
          telepon: pangkalan['telepon'],
          gmap: pangkalan['gmap'],
          kataSandi: pangkalan['kata_sandi'],
          coordinates: pangkalan['coordinates'],
          foto: pangkalan['foto'],
          ulasan: pangkalan['ulasan'],
        ),
      );
    }

    return daftarPangkalan;
  }

  static Future<void> updateOnly(String id, Map<String, dynamic> data) async {
    final Map<String, dynamic> response = json.decode((await http.patch(
      Uri.parse('$url/$id'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(data),
    ))
        .body);

    if (response['status'] == 'failed') throw response['message'];
  }

  double get ratingAverage {
    double sum = 0;
    for (var u in ulasan) {
      sum = sum + u['rating'];
    }

    final double average = sum / ulasan.length;

    return ulasan.isEmpty ? 0 : double.parse(average.toStringAsFixed(1));
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      '_id': id,
      'nama': nama,
      'alamat': alamat,
      'harga': harga,
      'stok': stok,
      'email': email,
      'telepon': telepon,
      'gmap': gmap,
      'kata_sandi': kataSandi,
      'coordinates': coordinates,
      'foto': foto,
      'ulasan': ulasan,
    };
  }

  factory Pangkalan.fromMap(Map<String, dynamic> map) {
    return Pangkalan(
      id: map['_id'] as String,
      nama: map['nama'] as String,
      alamat: map['alamat'] as String,
      harga: map['harga'] as int,
      stok: map['stok'] as int,
      email: map['email'] as String,
      telepon: map['telepon'] as String,
      gmap: map['gmap'] as String,
      kataSandi: map['kata_sandi'] as String,
      coordinates: List.from(
        (map['coordinates'] as List),
      ),
      foto: List.from(
        (map['foto'] as List),
      ),
      ulasan: List.from(
        (map['ulasan'] as List),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory Pangkalan.fromJson(String source) =>
      Pangkalan.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Pangkalan(id: $id, nama: $nama, alamat: $alamat, harga: $harga, stok: $stok, email: $email, telepon: $telepon, gmap: $gmap, kataSandi: $kataSandi, coordinates: $coordinates, foto: $foto, ulasan: $ulasan)';
  }

  @override
  bool operator ==(covariant Pangkalan other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.nama == nama &&
        other.alamat == alamat &&
        other.harga == harga &&
        other.stok == stok &&
        other.email == email &&
        other.telepon == telepon &&
        other.gmap == gmap &&
        other.kataSandi == kataSandi &&
        listEquals(other.coordinates, coordinates) &&
        listEquals(other.foto, foto) &&
        listEquals(other.ulasan, ulasan);
  }

  @override
  int get hashCode {
    return id.hashCode ^
        nama.hashCode ^
        alamat.hashCode ^
        harga.hashCode ^
        stok.hashCode ^
        email.hashCode ^
        telepon.hashCode ^
        gmap.hashCode ^
        kataSandi.hashCode ^
        coordinates.hashCode ^
        foto.hashCode ^
        ulasan.hashCode;
  }
}
