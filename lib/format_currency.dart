import 'package:intl/intl.dart';

String formatCurrency(double amount) {
  return NumberFormat.currency(locale: 'he_IL', symbol: '₪').format(amount);
}
