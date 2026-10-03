import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kartu Perkenalan',
      home: const KartuPerkenalanPage(),
    );
  }
}

class KartuPerkenalanPage extends StatelessWidget {
  const KartuPerkenalanPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kartu Perkenalan'),
        backgroundColor: Colors.blueAccent,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(
              Icons.account_circle,
              size: 120,
              color: Colors.blueAccent,
            ),
            SizedBox(height: 24),
            Text(
              'Muhammad Aliff Al Fitroh',
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'NIM: 20240801067',
              style: TextStyle(
                fontSize: 18,
                color: Colors.black54,
              ),
            ),
            SizedBox(height: 24),
            Text(
              'Jurusan: Teknik Informatika',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 8),
            Text(
              'Hobi: Ngoding dan Mendengarkan Musik',
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}