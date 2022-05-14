import 'package:intl/intl.dart';

class LuxFormatter{
  static String doubleAsCurrency(double? toConvert){
    final oCcy = new NumberFormat("#,##0.00", "en_US");
    return oCcy.format(toConvert).replaceAll(".00", "");
  }
}