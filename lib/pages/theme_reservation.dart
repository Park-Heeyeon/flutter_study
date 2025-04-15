import 'package:flutter/material.dart';
import 'package:flutter_application_1/widgets/header.dart';

class ThemeReservationPage extends StatefulWidget {
  final Map<String, dynamic> theme;

  const ThemeReservationPage({super.key, required this.theme});

  @override
  State<ThemeReservationPage> createState() => _ThemeReservationPageState();
}

class _ThemeReservationPageState extends State<ThemeReservationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const Header(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('예약할 테마를 선택하세요.'),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // 예약하기 버튼 클릭 시 동작
              },
              child: const Text('예약하기'),
            ),
          ],
        ),
      ),
    );
  }
}
