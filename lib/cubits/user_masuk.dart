import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gasku/models/user.dart';

class UserMasuk extends Cubit<User?> {
  UserMasuk() : super(null);

  void masuk({required String nik, required String kataSandi}) {
    // User.get(userID)
    // emit(user);
  }
}
