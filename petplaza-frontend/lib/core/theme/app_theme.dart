import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppThemes {
  static ThemeData get lightTheme {
    return ThemeData(
        brightness: Brightness.light,
        primaryColor: Colors.deepPurple,
        appBarTheme: AppBarTheme(
          color: Colors.deepPurple[400],
          titleTextStyle: TextStyle(color: Colors.white),
        ),
        scaffoldBackgroundColor: Colors.white,
        textTheme: TextTheme(
          titleLarge: GoogleFonts.barriecito(
              fontSize: 38, color: Colors.black, fontWeight: FontWeight.bold),
          displayLarge: GoogleFonts.barriecito(
              fontSize: 38,
              color: Colors.deepPurpleAccent,
              fontWeight: FontWeight.bold),
          displayMedium: GoogleFonts.barriecito(
              fontSize: 24, color: Colors.deepPurpleAccent),
          displaySmall: GoogleFonts.barriecito(
              fontSize: 22, color: Colors.deepPurpleAccent),
          bodySmall: GoogleFonts.barriecito(fontSize: 18, color: Colors.black),
          bodyMedium: GoogleFonts.barriecito(fontSize: 20, color: Colors.black),
          bodyLarge: GoogleFonts.barriecito(fontSize: 22, color: Colors.black),
        ),
        buttonTheme: ButtonThemeData(
          buttonColor: Colors.deepPurple,
          textTheme: ButtonTextTheme.primary,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
            style: ButtonStyle(
                elevation: WidgetStateProperty.all(5),
                backgroundColor:
                    WidgetStateProperty.all(Colors.deepPurpleAccent),
                foregroundColor: WidgetStateProperty.all(Colors.white),
                textStyle: WidgetStateProperty.all(
                    GoogleFonts.openSansCondensed(
                        fontWeight: FontWeight.bold, fontSize: 20)))),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: ButtonStyle(
            foregroundColor: WidgetStateProperty.all(Colors.deepPurpleAccent),
            textStyle: WidgetStateProperty.all(
              GoogleFonts.openSansCondensed(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            side: WidgetStateProperty.all(BorderSide(
              color: Colors.deepPurpleAccent, // Set the border color
              width: 2, // Adjust border width if needed
            )),
          ),
        ));
  }

  static ThemeData get darkTheme {
    return ThemeData(
      brightness: Brightness.dark,
      primaryColor: Colors.deepPurple,
      appBarTheme: AppBarTheme(
        color: Colors.deepPurple[800],
        titleTextStyle: TextStyle(color: Colors.white),
      ),
      scaffoldBackgroundColor: Colors.black,
      textTheme: TextTheme(
        bodyMedium: TextStyle(color: Colors.white),
        bodyLarge: TextStyle(color: Colors.white70),
      ),
      buttonTheme: ButtonThemeData(
        buttonColor: Colors.deepPurple[600],
        textTheme: ButtonTextTheme.primary,
      ),
    );
  }
}
