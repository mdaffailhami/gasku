import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:intl/intl.dart';

class ETiket {
  final DateTime tanggal;
  ETiket({
    required this.tanggal,
  });

  ETiket copyWith({
    DateTime? tanggal,
  }) {
    return ETiket(
      tanggal: tanggal ?? this.tanggal,
    );
  }

  String get nomor => 'LPG-${DateFormat('ddMMyyyy').format(tanggal)}';

  String get tanggalKedaluwarsa => DateFormat('dd/MM/yyyy')
      .format(tanggal.add(Duration(days: 6)))
      .toString();

  String generateUrl(String nik) =>
      '${dotenv.env['SERVER_URL']}/konfirmasi-e-tiket/${nik}/${sha1.convert(utf8.encode('${nik}(${DateFormat('dd-MM-yyyy').format(tanggal).toString()})')).toString()}';

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'tanggal': tanggal.millisecondsSinceEpoch,
    };
  }

  factory ETiket.fromMap(Map<String, dynamic> map) {
    return ETiket(
      tanggal: DateTime.fromMillisecondsSinceEpoch(map['tanggal'] as int),
    );
  }

  String toJson() => json.encode(toMap());

  factory ETiket.fromJson(String source) =>
      ETiket.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'ETiket(tanggal: $tanggal)';

  @override
  bool operator ==(covariant ETiket other) {
    if (identical(this, other)) return true;

    return other.tanggal == tanggal;
  }

  @override
  int get hashCode => tanggal.hashCode;
}
