import 'dart:math';

bool validasiKedekatanLokasi(List center, List target) {
  // List<double> center = [-3.2989219004074415, 114.59046167785267];

  double limitKm = 5;

  List<double> max = [
    center[0] + limitKm * 0.009,
    center[1] + (limitKm * 0.009 / cos(center[0] * pi / 180))
  ];

  List<double> min = [
    center[0] - limitKm * 0.009,
    center[1] - (limitKm * 0.009 / cos(center[0] * pi / 180))
  ];

  final bool isLatitudeValid = target[0] <= max[0] && target[0] >= min[0];
  final bool isLongitudeValid = target[1] <= max[1] && target[1] >= min[1];

  return isLatitudeValid && isLongitudeValid;
}
