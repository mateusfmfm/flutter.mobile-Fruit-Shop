import 'package:flutter/material.dart';

class DosisStyle {
  static TextStyle regular(BuildContext context) {
    return Theme.of(context).textTheme.headline1!.copyWith(
        fontFamily: 'Dosis', color: Colors.white, fontWeight: FontWeight.w400);
  }

  static TextStyle bold(BuildContext context) {
    return Theme.of(context).textTheme.headline1!.copyWith(
        fontFamily: 'Dosis', color: Colors.white, fontWeight: FontWeight.w700);
  }
}
