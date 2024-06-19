import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gasku/models/user.dart';

class UserMasukCubit extends Cubit<User?> {
  UserMasukCubit() : super(null);

  Future<void> masuk({required String nik, required String kataSandi}) async {
    final user = await User.get(nik);

    if (user == null) throw 'Akun tidak terdaftar';

    if (user.kataSandi != sha1.convert(utf8.encode(kataSandi)).toString())
      throw 'Password salah';

    emit(user);
  }
}
