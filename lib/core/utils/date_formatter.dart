import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class AppDateFormatter {
  static String format(DateTime date, BuildContext context) {
    return DateFormat.yMMMd(context.locale.toString()).format(date);
  }
}
