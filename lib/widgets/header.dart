import 'package:flutter/material.dart';

class Header extends StatelessWidget implements PreferredSizeWidget {
  const Header({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text(
        '방탈출 예약 앱',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      centerTitle: true,
      /**
         * leading: 아이콘 버튼이나 간단한 위젯을 왼쪽에 배치할 때 사용
         * onPressed: 아이콘 버튼을 클릭했을 때 함수의 형태로 일어날 이벤트 정의
         */
      leading: IconButton(
        onPressed: () {
          Scaffold.of(context).openDrawer();
        },
        icon: Icon(Icons.menu),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
