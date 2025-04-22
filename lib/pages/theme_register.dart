import 'dart:io';

import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:flutter_application_1/widgets/app_scaffold.dart';
import 'package:image_picker/image_picker.dart';

Future<void> sendDataWithImage({
  required BuildContext context,
  required File imageFile,
  required String name,
  required String description,
  required int difficulty,
  required int scariness,
}) async {
  final url = Uri.parse('http://44.211.123.1:3000/api/theme');
  /**
    * HTTP POST 요청을 보내기 위한 MultipartRequest 객체 생성
    * http.post()와 달리 파일 포함 전송이 가능함
   */
  final request = http.MultipartRequest('POST', url);

  request.fields['title'] = name;
  request.fields['description'] = description;
  request.fields['difficulty'] = difficulty.toString();
  request.fields['scariness'] = scariness.toString();

  request.files.add(await http.MultipartFile.fromPath('image', imageFile.path));

  final response = await request.send();
  final responseBody = await response.stream.bytesToString();

  if (response.statusCode == 200) {
    print('업로드 성공');
    print('서버 응답: $responseBody');
    // ThemeListPage로 이동
    Navigator.pushReplacementNamed(context, '/');
  } else {
    print('업로드 실패: ${response.statusCode}');
    print('서버 응답: $responseBody');
  }
  return;
}

class ThemeRegisterPage extends StatefulWidget {
  const ThemeRegisterPage({super.key});

  @override
  State<ThemeRegisterPage> createState() => _ThemeRegisterPageState();
}

class _ThemeRegisterPageState extends State<ThemeRegisterPage> {
  final _formKey = GlobalKey<FormState>();
  File? _thumbnamailImage;

  Future<void> pickImage() async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      setState(() {
        _thumbnamailImage = File(picked.path);
      });
    }
  }

  String? imageUrl;
  String name = '';
  String description = '';
  int difficulty = 1;
  int scariness = 1;

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              GestureDetector(
                onTap: pickImage,
                child: Container(
                  height: 200,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.deepPurple[50],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        if (_thumbnamailImage != null)
                          Image.file(_thumbnamailImage!, fit: BoxFit.cover)
                        else
                          Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Icon(
                                  Icons.add_a_photo,
                                  size: 40,
                                  // color: Colors.deepPurple,
                                ),
                                SizedBox(height: 8),
                                Text(
                                  '썸네일을 등록하세요',
                                  // style: TextStyle(color: Colors.deepPurple),
                                ),
                              ],
                            ),
                          ),
                        if (_thumbnamailImage != null)
                          Container(
                            color: Colors.black45,
                            alignment: Alignment.center,
                            child: const Text(
                              '다시 선택하려면 탭하세요',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: '테마 이름'),
                validator:
                    (value) =>
                        value == null || value.isEmpty ? '이름을 입력해주세요' : null,
                onChanged: (value) => name = value,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: '테마 설명'),
                onChanged: (value) => description = value,
              ),
              const SizedBox(height: 12),
              // 난이도 (1~5)
              DropdownButtonFormField<int>(
                decoration: const InputDecoration(labelText: '난이도'),
                value: difficulty,
                items: List.generate(
                  5,
                  (index) => DropdownMenuItem(
                    value: index + 1,
                    child: Text('${index + 1}'),
                  ),
                ),
                onChanged:
                    (value) => setState(() {
                      difficulty = value!;
                    }),
              ),
              const SizedBox(height: 12),
              // 공포도 (1~5)
              DropdownButtonFormField<int>(
                decoration: const InputDecoration(labelText: '공포도'),
                value: scariness,
                items: List.generate(
                  5,
                  (index) => DropdownMenuItem(
                    value: index + 1,
                    child: Text('${index + 1}'),
                  ),
                ),
                onChanged:
                    (value) => setState(() {
                      scariness = value!;
                    }),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple[500],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    if (_thumbnamailImage == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('썸네일 이미지를 선택해주세요')),
                      );
                      return;
                    }

                    sendDataWithImage(
                      context: context,
                      imageFile: _thumbnamailImage!,
                      name: name,
                      description: description,
                      difficulty: difficulty,
                      scariness: scariness,
                    );
                  }
                },
                child: const Text(
                  '테마 등록',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
