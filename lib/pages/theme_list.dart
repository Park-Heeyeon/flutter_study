import 'package:flutter/material.dart';
import 'package:flutter_application_1/widgets/app_scaffold.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

Future<List<dynamic>> getData() async {
  final url = Uri.parse('http://44.211.123.1:3000/api/theme');
  final res = await http.get(url);

  if (res.statusCode != 200) {
    throw Exception('Failed to load data');
  }

  print(res.body);
  final decoded = jsonDecode(res.body);
  return decoded['data'];
}

class ThemeListPage extends StatefulWidget {
  const ThemeListPage({super.key});

  @override
  ThemeListPageState createState() => ThemeListPageState();
}

class ThemeListPageState extends State<ThemeListPage> {
  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      body: FutureBuilder<List<dynamic>>(
        future: getData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('에러 발생: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            final data = snapshot.data!;
            return ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                final item = data[index];
                return Card(
                  margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Column(
                    children: [
                      Image(
                        image:
                            item['image_url'] != null
                                ? NetworkImage(item['image_url'])
                                : AssetImage('assets/images/default.jpg')
                                    as ImageProvider,
                        fit: BoxFit.cover,
                        height: 180,
                        width: double.infinity,
                      ),
                      ListTile(
                        title: Text(item['title'] ?? '제목 없음'),
                        subtitle: Text(item['description'] ?? '설명 없음'),
                        trailing: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('난이도: ${item['difficulty']}'),
                            Text('공포도: ${item['scariness']}'),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          } else {
            return Center(child: Text('데이터 없음'));
          }
        },
      ),
    );
  }
}
