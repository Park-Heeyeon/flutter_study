import 'package:flutter/material.dart';
import 'package:flutter_application_1/widgets/header.dart';
import 'package:flutter_application_1/widgets/app_scaffold.dart';

class ThemeListPage extends StatelessWidget {
  const ThemeListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(body: Center(child: Text('방탈출 테마 리스트')));
  }
}
