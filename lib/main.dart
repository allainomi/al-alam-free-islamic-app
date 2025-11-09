import 'package:flutter/material.dart';

void main() {
  runApp(const AlAlamApp());
}

class AlAlamApp extends StatelessWidget {
  const AlAlamApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'الْعَلَمْ Islamic App',
      theme: ThemeData(primarySwatch: Colors.green),
      home: const HomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('الْعَلَمْ - Free Islamic App'),
        backgroundColor: Colors.green,
      ),
      body: const Center(
        child: Text(
          'بِسْمِ اللّٰهِ الرَّحْمَٰنِ الرَّحِيْمِ\n\nنماز، قرآن، اذکار، حدیث\n\nآپ کا اسلامی ساتھی',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
