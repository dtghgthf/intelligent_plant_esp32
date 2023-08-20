import 'package:intl/intl.dart';

String formatCurrency(num amount,{int decimalCount = 0}){
  final formatCurrency = new NumberFormat.simpleCurrency(decimalDigits: decimalCount);
  return formatCurrency.format(amount);

}

String capitalize(String string) {
  return "${string[0].toUpperCase()}${string.substring(1)}";
}