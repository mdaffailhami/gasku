import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gasku/models/pangkalan.dart';

class DaftarPangkalanCubit extends Cubit<List<Pangkalan>> {
  DaftarPangkalanCubit() : super([]);

  Future<void> refresh() async => emit(await Pangkalan.getAll());
}