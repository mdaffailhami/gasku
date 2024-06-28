import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gasku/models/pengguna.dart';

class PenggunaMasukCubit extends Cubit<Pengguna?> {
  PenggunaMasukCubit() : super(null);

  Future<void> masuk({required String nik, required String kataSandi}) async {
    final pengguna = await Pengguna.get(nik);

    if (pengguna.kataSandi != sha1.convert(utf8.encode(kataSandi)).toString()) {
      throw 'Password salah';
    }

    emit(pengguna);
  }

  Future<void> masukTanpaSandi({required String nik}) async {
    final pengguna = await Pengguna.get(nik);

    emit(pengguna);
  }

  Future<void> edit(Pengguna pengguna) async {
    await Pengguna.edit(pengguna.nik, pengguna);

    emit(pengguna);
  }

  void keluar() => emit(null);
}
