import 'dart:convert';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<Album> fetchAlbum() async {
  final response = await http
      .get(Uri.parse('https://jsonplaceholder.typicode.com/albums/10'));

  if (response.statusCode == 200) {
    return Album.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
  }
  throw Exception('Failed to load album.');
}

Future<Album> createAlbum(String title) async {
  final response = await http.post(
      Uri.parse('https://jsonplaceholder.typicode.com/albums'),
      headers: <String, String>{
        'content-type': 'application/json; charset=UTF-8'
      },
      body: jsonEncode(<String, String>{"title": title}));

  if (response.statusCode == 201) {
    return Album.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
  } else {
    throw Exception('Failed to create album');
  }
}

List<Album> parsePhotos(String responseBody) {
  final parsed =
      (jsonDecode(responseBody) as List).cast<Map<String, dynamic>>();
  return parsed.map<Album>((json) => Album.fromJson(json)).toList();
}

class Album {
  final int? userId;
  final int id;
  final String title;

  const Album({this.userId, required this.id, required this.title});

  factory Album.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'userId': int userId,
        'id': int id,
        'title': String title,
      } =>
        Album(userId: userId, id: id, title: title),
      {
        'id': int id,
        'title': String title,
      } =>
        Album(id: id, title: title),
      _ => throw const FormatException('Failed to load album'),
    };
  }
}

class MyHttpDemo extends StatelessWidget {
  const MyHttpDemo({super.key}); 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fetch Data Example'),
      ),
      body: Center(
        child: FutureBuilder<Album>(
          future: createAlbum('another-mid-album'),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Text(snapshot.data!.title);
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }

            // By default, show a loading spinner.
            return const CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}
