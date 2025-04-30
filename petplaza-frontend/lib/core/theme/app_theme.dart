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
            fontSize: 30, color: Colors.black, fontWeight: FontWeight.bold),
        displayLarge: GoogleFonts.barriecito(
            fontSize: 38,
            color: Colors.deepPurpleAccent,
            fontWeight: FontWeight.bold),
        displayMedium: GoogleFonts.barriecito(
            fontSize: 24, color: Colors.deepPurpleAccent),
        displaySmall: GoogleFonts.barriecito(
            fontSize: 22, color: Colors.deepPurpleAccent),
        bodySmall: GoogleFonts.mulish(fontSize: 12, color: Colors.black),
        bodyMedium: GoogleFonts.mulish(fontSize: 14, color: Colors.black),
        bodyLarge: GoogleFonts.mulish(fontSize: 20, color: Colors.black,fontWeight: FontWeight.bold),
        labelLarge: GoogleFonts.mulish(fontSize: 38, color: Colors.black, fontWeight: FontWeight.bold),
        labelMedium: GoogleFonts.gruppo(fontSize: 50, color: Colors.black, fontWeight: FontWeight.bold),
      ),
      buttonTheme: ButtonThemeData(
        buttonColor: Colors.deepPurple,
        textTheme: ButtonTextTheme.primary,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          elevation: MaterialStateProperty.all(5),
          backgroundColor: MaterialStateProperty.all(Colors.deepPurpleAccent),
          foregroundColor: MaterialStateProperty.all(Colors.white),
          textStyle: MaterialStateProperty.all(GoogleFonts.openSansCondensed(
              fontWeight: FontWeight.bold, fontSize: 20)),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                  10), // Adjust the radius value as needed
            ),
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: ButtonStyle(
          foregroundColor: MaterialStateProperty.all(Colors.deepPurpleAccent),
          textStyle: MaterialStateProperty.all(
            GoogleFonts.openSansCondensed(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          side: MaterialStateProperty.all(BorderSide(
            color: Colors.deepPurpleAccent, // Set the border color
            width: 2, // Adjust border width if needed
          )),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                  10), // Adjust the radius value as needed
            ),
          ),
        ),
      ),
      iconButtonTheme: IconButtonThemeData(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Colors.deepPurpleAccent),
          foregroundColor: MaterialStateProperty.all(Colors.black),
          textStyle: MaterialStateProperty.all(
            GoogleFonts.openSansCondensed(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                  50), // Adjust the radius value as needed
            ),
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.transparent,
        contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.deepPurpleAccent, width: 1),
          borderRadius: BorderRadius.circular(12),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.deepPurpleAccent, width: 3),
          borderRadius: BorderRadius.circular(12),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.deepPurpleAccent, width: 1),
          borderRadius: BorderRadius.circular(12),
        ),
        hintStyle: TextStyle(color: Colors.black45),
        labelStyle: TextStyle(color: Colors.deepPurpleAccent),
      ),
    );
  }

/////////////////////////////////////////////////////////////////////////

  static ThemeData get darkTheme {
    return ThemeData(
      brightness: Brightness.light,
      primaryColor: Colors.deepPurple,
      appBarTheme: AppBarTheme(
        color: const Color.fromARGB(255, 85, 48, 187),
        titleTextStyle: TextStyle(color: Colors.white),
      ),
      scaffoldBackgroundColor: const Color.fromARGB(255, 36, 8, 106),
      textTheme: TextTheme(
        titleLarge: GoogleFonts.barriecito(
            fontSize: 30, color: Colors.white, fontWeight: FontWeight.bold),
        displayLarge: GoogleFonts.barriecito(
            fontSize: 38,
            color: const Color.fromARGB(255, 158, 127, 246),
            fontWeight: FontWeight.bold),
        displayMedium: GoogleFonts.barriecito(
            fontSize: 24, color: Colors.deepPurpleAccent),
        displaySmall: GoogleFonts.barriecito(
            fontSize: 22, color: Colors.deepPurpleAccent),
        bodySmall: GoogleFonts.mulish(fontSize: 12, color: Colors.white),
        bodyMedium: GoogleFonts.mulish(fontSize: 14, color: Colors.white),
        bodyLarge: GoogleFonts.mulish(fontSize: 20, color: Colors.white,fontWeight: FontWeight.bold),
        labelLarge: GoogleFonts.mulish(fontSize: 38, color: Colors.white, fontWeight: FontWeight.bold),
        labelMedium: GoogleFonts.gruppo(fontSize: 50, color: Colors.white, fontWeight: FontWeight.bold),
      ),
      buttonTheme: ButtonThemeData(
        buttonColor: Colors.deepPurple,
        textTheme: ButtonTextTheme.primary,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          elevation: MaterialStateProperty.all(5),
          backgroundColor: MaterialStateProperty.all(Colors.deepPurpleAccent),
          foregroundColor: MaterialStateProperty.all(Colors.white),
          textStyle: MaterialStateProperty.all(GoogleFonts.openSansCondensed(
              fontWeight: FontWeight.bold, fontSize: 20)),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                  10), // Adjust the radius value as needed
            ),
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: ButtonStyle(
          foregroundColor: MaterialStateProperty.all(Colors.deepPurpleAccent),
          textStyle: MaterialStateProperty.all(
            GoogleFonts.openSansCondensed(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          side: MaterialStateProperty.all(BorderSide(
            color: Colors.deepPurpleAccent, // Set the border color
            width: 2, // Adjust border width if needed
          )),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                  10), // Adjust the radius value as needed
            ),
          ),
        ),
      ),
      iconButtonTheme: IconButtonThemeData(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Colors.deepPurpleAccent),
          foregroundColor: MaterialStateProperty.all(Colors.white),
          textStyle: MaterialStateProperty.all(
            GoogleFonts.openSansCondensed(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                  50), // Adjust the radius value as needed
            ),
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.transparent,
        contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.deepPurpleAccent, width: 1),
          borderRadius: BorderRadius.circular(12),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.deepPurpleAccent, width: 3),
          borderRadius: BorderRadius.circular(12),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.deepPurpleAccent, width: 1),
          borderRadius: BorderRadius.circular(12),
        ),
        hintStyle: TextStyle(color: Colors.black45),
        labelStyle: TextStyle(color: Colors.deepPurpleAccent),
      ),
    );
  }
}



//       brightness: Brightness.dark,
//       primaryColor: Colors.deepPurple,
//       appBarTheme: AppBarTheme(
//         color: Colors.deepPurple[800],
//         titleTextStyle: TextStyle(color: Colors.white),
//       ),
//       scaffoldBackgroundColor: Colors.deepPurpleAccent,
//       textTheme: TextTheme(
//         bodyMedium: TextStyle(color: Colors.white),
//         bodyLarge: TextStyle(color: Colors.white70),
//       ),
//       buttonTheme: ButtonThemeData(
//         buttonColor: Colors.deepPurple[600],
//         textTheme: ButtonTextTheme.primary,
//       ),
//       inputDecorationTheme: InputDecorationTheme(
//         filled: true,
//         fillColor: Colors.grey[800],
//         contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
//         border: OutlineInputBorder(
//           borderSide: BorderSide(color: Colors.deepPurpleAccent, width: 2),
//           borderRadius: BorderRadius.circular(12),
//         ),
//         focusedBorder: OutlineInputBorder(
//           borderSide: BorderSide(color: Colors.deepPurple, width: 2),
//           borderRadius: BorderRadius.circular(12),
//         ),
//         enabledBorder: OutlineInputBorder(
//           borderSide: BorderSide(color: Colors.deepPurpleAccent, width: 2),
//           borderRadius: BorderRadius.circular(12),
//         ),
//         hintStyle: TextStyle(color: Colors.white38),
//         labelStyle: TextStyle(color: Colors.deepPurpleAccent),
//       ),
//     );
//   }
// }
