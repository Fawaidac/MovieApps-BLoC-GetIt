import 'package:intl/intl.dart';

String formatDate(String date) {
  final parsedDate = DateTime.parse(date);
  return DateFormat('dd MMMM yyyy').format(parsedDate);
}
