import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gasku/utils/get_current_position.dart';
import 'package:geolocator/geolocator.dart';

class PosisiPenggunaCubit extends Cubit<Position?> {
  PosisiPenggunaCubit() : super(null);

  Future<void> refresh() async => emit(await getCurrentPosition());

  List? get coordinates =>
      state == null ? null : [state!.latitude, state!.longitude];
}
