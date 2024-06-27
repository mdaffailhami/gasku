import 'package:intl/intl.dart';

String formatRupiah(int value, {bool useSymbol = false}) {
  return NumberFormat.currency(
    locale: 'id',
    symbol: useSymbol ? 'Rp' : '',
    decimalDigits: 0,
  ).format(value);
}
