import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/theme_list.dart';
import 'package:flutter_application_1/pages/theme_register.dart';

void main() {
  runApp(
    MaterialApp(
      title: '방탈출 테마 예약 앱',
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          backgroundColor: Color.fromARGB(255, 141, 101, 209),
          foregroundColor: Colors.white,
        ),
      ),
      debugShowCheckedModeBanner: false,
      // 라우터 설정
      initialRoute: "/",
      routes: {
        '/': (context) => const ThemeListPage(),
        '/theme_register': (context) => const ThemeRegisterPage(),
        // '/theme_reservation': (context) => const ThemeReservationPage(),
      },
    ),
  );
}
