import 'package:flutter/material.dart';

void main() {
  runApp(const TabungKuApp());
}

class TabungKuApp extends StatelessWidget {
  const TabungKuApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TabungKu Layout',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorSchemeSeed: Colors.blue,
        useMaterial3: true,
      ),
      home: const RingkasanPage(),
    );
  }
}

// Model data sederhana untuk transaksi
class Transaksi {
  final String judul;
  final String tanggal;
  final String nominal;

  const Transaksi(this.judul, this.tanggal, this.nominal);
}

class RingkasanPage extends StatelessWidget {
  const RingkasanPage({super.key});

  // Data statis transaksi (hard-coded)
  final List<Transaksi> daftarTransaksi = const [
    Transaksi('Setor Tabungan', '15 Nov 2026', '+ Rp 500.000'),
    Transaksi('Tarik Tunai', '10 Nov 2026', '- Rp 200.000'),
    Transaksi('Setor Tabungan', '01 Nov 2026', '+ Rp 1.000.000'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ringkasan Tabungan'),
      ),
      // Menggunakan SingleChildScrollView agar tata letak aman dari overflow pada berbagai ukuran layar
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. KARTU RINGKASAN TABUNGAN (Nama, Saldo, dan Target)
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: Colors.blue.shade50,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Tabungan Rumah Impian',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.blueGrey,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Rp 12.500.000',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text(
                          'Target: Rp 50.000.000',
                          style: TextStyle(fontSize: 14, color: Colors.grey),
                        ),
                        Text(
                          '25%',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            // 2. BARIS KATEGORI (Menabung, Tarik, Riwayat)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildKategoriItem(Icons.savings, 'Menabung'),
                _buildKategoriItem(Icons.account_balance_wallet, 'Tarik'),
                _buildKategoriItem(Icons.history, 'Riwayat'),
              ],
            ),
            const SizedBox(height: 24),

            // Judul Bagian Daftar Transaksi
            const Text(
              'Transaksi Terakhir',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),

            // 3. DAFTAR SEDERHANA TRANSAKSI (ListView.builder dengan Card & ListTile)
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: daftarTransaksi.length,
              itemBuilder: (context, index) {
                final item = daftarTransaksi[index];
                final isMasuk = item.nominal.startsWith('+');
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 6),
                  child: ListTile(
                    leading: Icon(
                      isMasuk ? Icons.arrow_downward : Icons.arrow_upward,
                      color: isMasuk ? Colors.green : Colors.red,
                    ),
                    title: Text(item.judul),
                    subtitle: Text(item.tanggal),
                    trailing: Text(
                      item.nominal,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: isMasuk ? Colors.green : Colors.red,
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  // Widget helper untuk merapikan ikon kategori
  Widget _buildKategoriItem(IconData icon, String label) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.blue.shade100,
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: Colors.blue.shade800, size: 28),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}