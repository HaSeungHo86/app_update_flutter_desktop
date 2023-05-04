import 'dart:convert';

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
      body: FutureBuilder(
        future: loadJsonFromGithub(),
        builder: (context, snapshot) {
          if (snapshot.hasData == false) {
            return const CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return _error(snapshot.error);
          } else {
            return _showVersion(snapshot.data!, context);
          }
        },
      ),
    );
  }

  Widget _error(Object? error) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        'Error: $error',
        style: const TextStyle(fontSize: 15),
      ),
    );
  }

  Widget _showVersion(Map<String, dynamic> data, BuildContext context) {
    return Column(
      children: [
        Text(data.toString()),
        FloatingActionButton(
          onPressed: () => showUpdateDialog(data, context),
          tooltip: "Check for Updates",
          child: const Icon(Icons.update),
        )
      ],
    );
  }

  Future<Map<String, dynamic>> loadJsonFromGithub() async {
    final response = await http.read(Uri.parse(
        "https://raw.githubusercontent.com/HaSeungHo86/app_update_flutter_desktop/master/app_version_check/version.json"));
    return jsonDecode(response);
  }

  // Future<void> _checkForUpdates() async {
  //   final josnVal = await loadjsonfrom
  // }

  showUpdateDialog(Map<String, dynamic> versionJson, BuildContext context) {
    final version = versionJson['version'];
    final updates = versionJson['description'] as List;
    return showDialog(
      context: context,
      builder: (context) {
        return SimpleDialog(
          contentPadding: const EdgeInsets.all(10),
          title: Text("Latest Version $version"),
          children: [
            Text("What's new in $version"),
            const SizedBox(height: 5),
            ...updates
                .map((e) => Row(
                      children: [
                        Container(
                            width: 4,
                            height: 4,
                            decoration: BoxDecoration(
                              color: Colors.grey[400],
                              borderRadius: BorderRadius.circular(20),
                            )),
                        const SizedBox(width: 10),
                        Text(
                          "$e",
                          style: TextStyle(
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ))
                .toList(),
            const SizedBox(height: 10),
            if (version > ApplicationConfig.currentVersion)
              TextButton.icon(
                  onPressed: () {
                    Navigator.pop(context);
                    downloadNewVersion(versionJson["windows_file_name"]);
                  },
                  icon: const Icon(Icons.update),
                  label: const Text("Update")),
          ],
        );
      },
    );
  }

  Future downloadNewVersion(String appPath) async {
    final fileName = appPath.split("/").last;
    //isDownloading = true;
  }
}
