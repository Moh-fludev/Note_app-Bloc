import 'package:flutter/material.dart';

enum AppTheme { darkTheme, lightTheme }

class AppThemes {
  static final appThemData = {
    AppTheme.darkTheme: ThemeData(
        primaryColor: Colors.black,
        brightness: Brightness.dark,
        dividerColor: Colors.black54,
        floatingActionButtonTheme:
            const FloatingActionButtonThemeData(backgroundColor: Colors.white),
        textButtonTheme: const TextButtonThemeData(
            style: ButtonStyle(
                foregroundColor: MaterialStatePropertyAll(Colors.white))),
        textTheme: const TextTheme(
          titleMedium: TextStyle(color: Colors.white),
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
            backgroundColor: Colors.grey, unselectedItemColor: Colors.black),
      ),
    AppTheme.lightTheme: ThemeData(
        primarySwatch: Colors.grey,
        primaryColor: Colors.white,
        brightness: Brightness.light,
        dividerColor: Colors.grey,
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
            backgroundColor: Colors.black, focusColor: Colors.white),
        textButtonTheme: const TextButtonThemeData(
            style: ButtonStyle(
                foregroundColor: MaterialStatePropertyAll(Colors.black))),
        textTheme: const TextTheme(
          titleMedium: TextStyle(color: Colors.black),
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
            backgroundColor: Colors.grey,
            selectedItemColor: Colors.black,
            unselectedItemColor: Colors.white)),
  };
}
