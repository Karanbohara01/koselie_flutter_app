import 'package:flutter/material.dart';

ThemeData getApplicationTheme() {
  return ThemeData(
    primarySwatch: Colors.red,
    scaffoldBackgroundColor: Colors.grey[300],
    fontFamily: 'Montserrat Regular',
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
          textStyle: const TextStyle(
              fontSize: 18,
              color: Colors.white,
              fontWeight: FontWeight.w500,
              fontFamily: 'Montserrat Regular'),
          backgroundColor: const Color.fromARGB(255, 212, 112, 11),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(5))),
    ),
  );
}
