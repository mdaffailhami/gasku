import 'package:intl/intl.dart';

class Rupiah {
  Rupiah(this.nilai);

  int nilai;

  @override
  String toString() {
    return NumberFormat.currency(
      locale: 'id',
      symbol: 'Rp',
      decimalDigits: 0,
    ).format(nilai);
  }
}
