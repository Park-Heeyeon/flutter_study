import 'package:flutter/material.dart';
import 'package:flutter_application_1/widgets/header.dart';

class AppScaffold extends StatelessWidget {
  final Widget body;
  final PreferredSizeWidget? appBar;

  const AppScaffold({
    super.key,
    required this.body,
    this.appBar = const Header(),
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      drawer: Drawer(
        child: ListView(
          children: [
            const UserAccountsDrawerHeader(
              accountName: Text("게스트"),
              accountEmail: Text('guest@test.com'),
              decoration: BoxDecoration(
                color: Color(0xFF9575CD), // Colors.deepPurple[300]
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.list),
              iconColor: Colors.deepPurple,
              title: const Text('방탈출 테마 리스트'),
              trailing: const Icon(Icons.navigate_next),
              onTap: () {
                // 방탈출 테마 리스트 페이지로 이동
                Navigator.pushNamed(context, '/');
              },
            ),
            ListTile(
              leading: const Icon(Icons.add_box),
              iconColor: Colors.deepPurple,
              title: const Text('방탈출 테마 등록'),
              trailing: const Icon(Icons.navigate_next),
              onTap: () {
                // 방탈출 테마 등록 페이지로 이동
                Navigator.pushNamed(context, '/theme_register');
              },
            ),
          ],
        ),
      ),
      body: body,
    );
  }
}
