import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:gasku/models/rupiah.dart';

@immutable
class Pangkalan {
  final String nama;
  final String alamat;
  final String urlGambar;
  final double rating;
  final Rupiah harga;

  Pangkalan({
    required this.nama,
    required this.alamat,
    required this.urlGambar,
    required this.rating,
    required this.harga,
  });

  Pangkalan copyWith({
    String? nama,
    String? alamat,
    String? urlGambar,
    double? rating,
    Rupiah? harga,
  }) {
    return Pangkalan(
      nama: nama ?? this.nama,
      alamat: alamat ?? this.alamat,
      urlGambar: urlGambar ?? this.urlGambar,
      rating: rating ?? this.rating,
      harga: harga ?? this.harga,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'nama': nama,
      'alamat': alamat,
      'urlGambar': urlGambar,
      'rating': rating,
      'harga': harga.nilai,
    };
  }

  factory Pangkalan.fromMap(Map<String, dynamic> map) {
    return Pangkalan(
      nama: map['nama'] as String,
      alamat: map['alamat'] as String,
      urlGambar: map['urlGambar'] as String,
      rating: map['rating'] as double,
      harga: Rupiah(map['harga'] as int),
    );
  }

  String toJson() => json.encode(toMap());

  factory Pangkalan.fromJson(String source) =>
      Pangkalan.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Pangkalan(nama: $nama, alamat: $alamat, urlGambar: $urlGambar, rating: $rating, harga: $harga)';
  }

  @override
  bool operator ==(covariant Pangkalan other) {
    if (identical(this, other)) return true;

    return other.nama == nama &&
        other.alamat == alamat &&
        other.urlGambar == urlGambar &&
        other.rating == rating &&
        other.harga == harga;
  }

  @override
  int get hashCode {
    return nama.hashCode ^
        alamat.hashCode ^
        urlGambar.hashCode ^
        rating.hashCode ^
        harga.hashCode;
  }
}
