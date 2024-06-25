import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gasku/models/pengguna.dart';

class PenggunaMasukCubit extends Cubit<Pengguna?> {
  PenggunaMasukCubit() : super(null);

  Future<void> masuk({required String nik, required String kataSandi}) async {
    final pengguna = await Pengguna.get(nik);

    if (pengguna.kataSandi != sha1.convert(utf8.encode(kataSandi)).toString())
      throw 'Password salah';

    emit(pengguna);
  }

  void keluar() => emit(null);
}
