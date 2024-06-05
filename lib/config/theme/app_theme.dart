import 'package:flutter/material.dart';

class AppTheme {
  static const Color primaryColor = Color(0xFF5F33E1);
  static const Color secondaryColor = Color(0xFFEBE5FF);
  static const Color scaffoldBackgroundColor = Color(0xFFFFFFFF);

  static const String fontFamily = 'DM Sans';

  static  ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: scaffoldBackgroundColor,
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.white,
    ),
    primaryColor: primaryColor,
    useMaterial3: true,
    textTheme: const TextTheme(),
    // colorSchemeSeed: primaryColor,
    colorScheme: ColorScheme.fromSeed(
        seedColor: primaryColor,
        brightness: Brightness.light,
        primary: primaryColor,
        onPrimary: Colors.white,
        secondary: secondaryColor,
        onSecondary: Colors.white,
        background: Colors.white,
        onBackground: Colors.white,

    ),
    textSelectionTheme: const TextSelectionThemeData(
      cursorColor: primaryColor,
      selectionColor: primaryColor,
      selectionHandleColor: primaryColor,
    ),
    fontFamily: fontFamily,
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          alignment: Alignment.center),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: const Color(0xffffffff),
      contentPadding: const EdgeInsets.all(14.0),
      isDense: true,
      hintStyle: const TextStyle(color: Color(0xff9E9E9E)),
      labelStyle: const TextStyle(color: Color(0xff9E9E9E)),
      focusColor: primaryColor,
      floatingLabelStyle: const TextStyle(color: primaryColor, fontSize: 18),
      border: OutlineInputBorder(
        borderSide: const BorderSide(
          width: 1,
          color: Color(0xffE4E4E4),
        ),
        borderRadius: BorderRadius.circular(15.0),
      ),
      enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(color: Color(0xffE4E4E4), width: 1.0)),
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(
          width: 1,
          color: primaryColor,
        ),
        borderRadius: BorderRadius.circular(15.0),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: const BorderSide(
          color: Colors.red,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(15.0),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
            shape: MaterialStateProperty.all<OutlinedBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0))),
            backgroundColor: MaterialStateProperty.all<Color>(primaryColor),
            foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
            overlayColor: MaterialStateProperty.all<Color>(Colors.black26))),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        shape: CircleBorder()),
    bottomSheetTheme: const BottomSheetThemeData(

      backgroundColor: Color(0xFFF6F6F6),
    //  modalBackgroundColor: Color(0xFFF6F6F6),

    )
  );

  static  ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    useMaterial3: true,
    textSelectionTheme: const TextSelectionThemeData(
      cursorColor: primaryColor,
      selectionColor: primaryColor,
      selectionHandleColor: primaryColor,
    ),
    fontFamily: fontFamily,
    scaffoldBackgroundColor: const Color(0xFF222222),
    primaryColor: primaryColor,
    switchTheme: SwitchThemeData(
      trackColor: MaterialStateProperty.all<Color>(Colors.grey),
      thumbColor: MaterialStateProperty.all<Color>(Colors.white),
    ),
    buttonTheme: const ButtonThemeData(
      buttonColor: primaryColor,
    ),
    inputDecorationTheme: InputDecorationTheme(
      isDense: true,
      focusColor: primaryColor,
      floatingLabelStyle: const TextStyle(color: primaryColor, fontSize: 25),
      border: OutlineInputBorder(
        borderSide: const BorderSide(
          width: 1,
        ),
        borderRadius: BorderRadius.circular(15.0),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(
          width: 1,
          color: primaryColor,
        ),
        borderRadius: BorderRadius.circular(15.0),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: const BorderSide(
          color: Colors.red,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(15.0),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
            shape: MaterialStateProperty.all<OutlinedBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0))),
            backgroundColor: MaterialStateProperty.all<Color>(primaryColor),
            foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
            overlayColor: MaterialStateProperty.all<Color>(Colors.black26))),
  );
}
