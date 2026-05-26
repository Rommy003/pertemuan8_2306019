import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/post_provider.dart';
import 'providers/photo_provider.dart';
import 'photos.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => PostProvider()),
        ChangeNotifierProvider(create: (_) => PhotoProvider()),
      ],
      child: MaterialApp(
        title: 'Tugas Pertemuan 9',
        theme: ThemeData(
          primarySwatch: Colors.teal,
        ),
        home: const PhotosScreen(),
      ),
    );
  }
}
