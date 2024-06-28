import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gasku/models/pangkalan.dart';

class DaftarPangkalanCubit extends Cubit<List<Pangkalan>> {
  DaftarPangkalanCubit() : super([]);

  Future<void> refresh() async => emit(await Pangkalan.get());

  Future<void> search(String keywords) async =>
      emit(await Pangkalan.get(search: keywords));

  // Future<void> tambahUlasan(
  //     String idPangkalan, Map<String, dynamic> ulasan) async {
  //   await Pangkalan.updateOnly(
  //     idPangkalan,
  //     {'ulasan': ulasan},
  //   );

  //   final List<Pangkalan> newState = List.from(state);
  //   final edittedIndex =
  //       newState.indexWhere((pangkalan) => pangkalan.id == idPangkalan);
  //   newState[edittedIndex].ulasan.add(ulasan);

  //   emit(newState);
  // }
}
