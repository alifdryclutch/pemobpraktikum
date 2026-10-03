import 'package:flutter/material.dart';

class Kontak {
  final String nama;
  final String telepon;
  final String email;
  const Kontak(this.nama, this.telepon, this.email);
}

const daftarKontak = [
  Kontak('Andi Saputra', '081234567890', 'andi.s@email.com'),
  Kontak('Budi Santoso', '082345678901', 'budi.santoso@email.com'),
  Kontak('Citra Kirana', '083456789012', 'citra.k@email.com'),
  Kontak('Dewi Lestari', '084567890123', 'dewi.l@email.com'),
  Kontak('Eko Prasetyo', '085678901234', 'eko.p@email.com'),
  Kontak('Fajar Nugraha', '086789012345', 'fajar.n@email.com'),
];

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Daftar Kontak',
      theme: ThemeData(colorSchemeSeed: Colors.deepPurple, useMaterial3: true),
      home: const ContactListPage(),
    );
  }
}

class ContactListPage extends StatelessWidget {
  const ContactListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Daftar Kontak')),
      body: ListView.builder(
        itemCount: daftarKontak.length,
        itemBuilder: (context, index) {
          final kontak = daftarKontak[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            child: ListTile(
              leading: CircleAvatar(
                child: Text(
                  kontak.nama[0],
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              title: Text(kontak.nama),
              subtitle: Text(kontak.telepon),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ContactDetailPage(kontak: kontak),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

class ContactDetailPage extends StatelessWidget {
  final Kontak kontak;
  const ContactDetailPage({super.key, required this.kontak});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(kontak.nama)),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 60,
              child: Text(
                kontak.nama[0],
                style: const TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              kontak.nama,
              style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.phone, color: Colors.grey),
                const SizedBox(width: 8),
                Text(kontak.telepon, style: const TextStyle(fontSize: 18)),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.email, color: Colors.grey),
                const SizedBox(width: 8),
                Text(kontak.email, style: const TextStyle(fontSize: 18)),
              ],
            ),
            const SizedBox(height: 40),
            ElevatedButton.icon(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.arrow_back),
              label: const Text('Kembali'),
            ),
          ],
        ),
      ),
    );
  }
}