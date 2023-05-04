import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:windows_update/application.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyPage(),
    );
  }
}

class MyPage extends StatelessWidget {
  const MyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Current Version - ${ApplicationConfig.currentVersion}"),
        centerTitle: true,
      ),
    );
  }

  // Future<Map<String, dynamic>> loadJsonFromGithub() async {
  //   final response = await http.read(Uri.parse("uri"))
  // }

  // Future<void> _checkForUpdates() async {
  //   final josnVal = await loadjsonfrom
  // }
}
