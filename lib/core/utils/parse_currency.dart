import 'package:intl/intl.dart';

// TODO: 1 FORMA DE FAZER
class ParseCurrency {
    static double? parseCurrency(String value) {
    try {
      return NumberFormat.simpleCurrency(locale: 'pt_BR')
          .parse(value)
          .toDouble();
    } catch (e) {
      return double.tryParse(value.replaceAll(',', '.'));
    }
  }
}
// TODO: 2 FORMA DE FAZER USANDO EXTENSION
extension ParseCurrencyFormatter on String {
    double? parseCurrency() {
    try {
      return NumberFormat.simpleCurrency(locale: 'pt_BR')
          .parse(this)
          .toDouble();
    } catch (e) {
      return double.tryParse(replaceAll(',', '.'));
    }
  }
}