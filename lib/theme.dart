import 'package:flutter/material.dart';

ThemeData get themeData {
  return ThemeData(
    inputDecorationTheme: textFieldInputDecoration,
    elevatedButtonTheme: elevatedButtonThemeData,
    bottomSheetTheme: BottomSheetThemeData(
      backgroundColor: Colors.black.withOpacity(0),
    ),
    dropdownMenuTheme: DropdownMenuThemeData(
      inputDecorationTheme: textFieldInputDecoration
    ),
    dividerTheme: const DividerThemeData(
      thickness: 1,
      color: Colors.grey,
    ),
    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.blueAccent,
    ),
    useMaterial3: false,
  );
}

ElevatedButtonThemeData get elevatedButtonThemeData {
  return ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 7),
        backgroundColor: Colors.blueAccent,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5))),
  );
}

InputDecorationTheme get textFieldInputDecoration {
  return InputDecorationTheme(
      filled: true,
      fillColor: Colors.white,
      isDense: true,
      hintStyle: const TextStyle(
        color: Colors.grey,
        fontSize: 16.0,
        fontWeight: FontWeight.w400,
      ),
      errorStyle: const TextStyle(
        color: Colors.red,
        fontSize: 16.0,
        fontWeight: FontWeight.w400,
      ),
      contentPadding: const EdgeInsets.only(top: 15, bottom: 13, left: 20),
      border: InputBorder.none,
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(5),
        borderSide: const BorderSide(color: Colors.grey),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(5),
        borderSide: const BorderSide(color: Colors.grey),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(5),
        borderSide: const BorderSide(color: Colors.grey),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(5),
        borderSide: const BorderSide(color: Colors.grey),
      ));
}
