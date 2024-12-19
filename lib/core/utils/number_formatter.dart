import 'package:intl/intl.dart';

class NumberFormatter {
  static String format(double value) {
    final NumberFormat formatter = NumberFormat.decimalPattern('pt_BR');
    return formatter.format(value);
  }
}
