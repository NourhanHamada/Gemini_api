import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

Future<bool?> showToast({
  required String message,
  Color? backgroundColor,
  ToastGravity? toastGravity,
}) {
  return Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_LONG,
    gravity: toastGravity ?? ToastGravity.BOTTOM,
    timeInSecForIosWeb: 2,
    backgroundColor: backgroundColor ?? Colors.grey.withOpacity(.6),
    textColor: Colors.white,
    fontSize: 14,
  );
}
