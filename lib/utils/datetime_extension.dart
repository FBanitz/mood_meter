import 'package:intl/intl.dart';

extension ToDateString on DateTime {
  get dateString {
    return DateFormat('dd/MM/yyyy').format(this);
  }
}