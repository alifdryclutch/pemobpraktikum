import 'package:flutter/material.dart';

String formatRibuan(int angka) {
  String teks = angka.toString();
  String hasil = '';
  int hitung = 0;
  for (int i = teks.length - 1; i >= 0; i--) {
    hitung++;
    hasil = teks[i] + hasil;
    if (hitung % 3 == 0 && i != 0) {
      hasil = '.$hasil';
    }
  }
  return hasil;
}

class Makanan {
  final String nama;
  final int harga;
  final String deskripsi;
  const Makanan(this.nama, this.harga, this.deskripsi);
}

const daftarMenu = [
  Makanan('Nasgor Goreng', 15000, 'Nasi digoreng dengan bumbu kecap manis dan telur mata sapi.'),
  Makanan('Mie Ayam', 12000, 'Mie kenyal dengan taburan ayam kecap dan sawi hijau segar.'),
  Makanan('Es Teh', 4000, 'Teh manis segar dengan es batu.'),
  Makanan('Ayam Bakar', 20000, 'Ayam bakar manis gurih lengkap dengan sambal terasi.'),
  Makanan('Sate Ayam', 18000, '10 tusuk sate ayam dengan siraman bumbu kacang kental.'),
  Makanan('Soto Daging', 22000, 'Kuah soto bening dengan irisan daging sapi empuk.'),
  Makanan('Es Teh Anget', 5000, 'perpaduan hangat dan dingin yang menyegarkan dahaga.'),
];

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Praktikum 2',
      theme: ThemeData(colorSchemeSeed: Colors.blue, useMaterial3: true),
      home: const MenuPage(),
    );
  }
}

class MenuPage extends StatelessWidget {
  const MenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Daftar Menu')),
      body: ListView.builder(
        itemCount: daftarMenu.length,
        itemBuilder: (context, index) {
          final item = daftarMenu[index];
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.blue.shade50,
              borderRadius: BorderRadius.circular(12),
            ),
            child: ListTile(
              leading: const Icon(Icons.restaurant),
              title: Text(item.nama),
              subtitle: Text('Rp ${formatRibuan(item.harga)}'),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => DetailPage(makanan: item)),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

class DetailPage extends StatelessWidget {
  final Makanan makanan;
  const DetailPage({super.key, required this.makanan});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(makanan.nama)),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.restaurant_menu, size: 80),
            const SizedBox(height: 16),
            Text(makanan.nama, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            Text('Rp ${formatRibuan(makanan.harga)}', style: const TextStyle(fontSize: 20)),
            const SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Text(
                makanan.deskripsi,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 16),
              ),
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Kembali'),
            ),
          ],
        ),
      ),
    );
  }
}

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profil')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.blue.shade50,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              const CircleAvatar(
                radius: 32,
                child: Icon(Icons.person, size: 32),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Text(
                      'Muhammad Aliff Al Fitroh',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text('20240801067'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}