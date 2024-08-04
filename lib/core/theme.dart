import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppTheme {
  static const primary = Color(0xffFF4F00);
  static const border = Color(0xffEEEEEE);
  static const hint = Color(0xff8c8c8c);
  static const inputBg = Color(0xffFAFAFA);
  static const textColor = Color(0xff191919);
  static const fontFamily = "Roboto";
  static const fontFamily2 = "Montserrat";
  static final mainBorderRadius = BorderRadius.circular(12.r);

  static ThemeData get light => ThemeData(
        fontFamily: fontFamily,
        scaffoldBackgroundColor: Colors.white,
        hintColor: hint,
        dividerColor: border,
        dividerTheme: DividerThemeData(color: border, space: 8.h),
        switchTheme: SwitchThemeData(
          trackColor: WidgetStateProperty.resolveWith((states) =>
              states.contains(WidgetState.selected)
                  ? primary
                  : const Color(0xff8C8C8C)),
        ),
        appBarTheme: AppBarTheme(
          // centerTitle: true,
          titleTextStyle: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
            fontFamily: fontFamily,
            color: textColor,
          ),
        ),
        dialogTheme: DialogTheme(
          backgroundColor: Colors.white,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
        ),
        colorScheme:
            ColorScheme.fromSwatch(primarySwatch: getMaterialColor(primary)),
        useMaterial3: true,
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            textStyle: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600),
            side: const BorderSide(color: primary),
            shape: RoundedRectangleBorder(
              borderRadius: mainBorderRadius,
            ),
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            textStyle: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        checkboxTheme: CheckboxThemeData(
            side: const BorderSide(color: Color(0xffEEEEEE)),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4.r)),
            fillColor: WidgetStateProperty.resolveWith((Set states) {
              if (states.contains(WidgetState.disabled)) {
                return const Color(0xffFAFAFA);
              }
              return null;
            })),
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(borderRadius: mainBorderRadius),
          filled: true,
          fillColor: inputBg,
          enabledBorder: OutlineInputBorder(
            borderRadius: mainBorderRadius,
            borderSide: const BorderSide(color: border),
          ),
        ),
        filledButtonTheme: FilledButtonThemeData(
          style: FilledButton.styleFrom(
            textStyle: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600),
            fixedSize: Size.fromHeight(48.h),
            shape: RoundedRectangleBorder(
              borderRadius: mainBorderRadius,
              // side: const BorderSide(color: primary),
            ),
          ),
        ),
      );

  static MaterialColor getMaterialColor(Color color) {
    final int red = color.red;
    final int green = color.green;
    final int blue = color.blue;
    final int alpha = color.alpha;

    final Map<int, Color> shades = {
      50: Color.fromARGB(alpha, red, green, blue),
      100: Color.fromARGB(alpha, red, green, blue),
      200: Color.fromARGB(alpha, red, green, blue),
      300: Color.fromARGB(alpha, red, green, blue),
      400: Color.fromARGB(alpha, red, green, blue),
      500: Color.fromARGB(alpha, red, green, blue),
      600: Color.fromARGB(alpha, red, green, blue),
      700: Color.fromARGB(alpha, red, green, blue),
      800: Color.fromARGB(alpha, red, green, blue),
      900: Color.fromARGB(alpha, red, green, blue),
    };

    return MaterialColor(color.value, shades);
  }
}
