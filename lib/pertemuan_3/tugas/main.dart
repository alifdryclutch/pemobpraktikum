import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Barang {
  String nama;
  int jumlah;
  String kategori;
  bool sudahDibeli;

  Barang(this.nama, this.jumlah, this.kategori, {this.sudahDibeli = false});
}

class BelanjaModel extends ChangeNotifier {
  final List<Barang> _items = [];

  List<Barang> get items => List.unmodifiable(_items);
  int get belumDibeli => _items.where((b) => !b.sudahDibeli).length;

  void tambah(Barang barang) {
    _items.add(barang);
    notifyListeners();
  }

  void toggle(int index) {
    _items[index].sudahDibeli = !_items[index].sudahDibeli;
    notifyListeners();
  }

  void hapus(int index) {
    _items.removeAt(index);
    notifyListeners();
  }
}

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => BelanjaModel(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Daftar Belanja',
      theme: ThemeData(colorSchemeSeed: Colors.green, useMaterial3: true),
      home: const BelanjaPage(),
    );
  }
}

class BelanjaPage extends StatelessWidget {
  const BelanjaPage({super.key});

  @override
  Widget build(BuildContext context) {
    final model = context.watch<BelanjaModel>();

    return Scaffold(
      appBar: AppBar(
        title: Text('Belum dibeli: ${model.belumDibeli} barang'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: model.items.isEmpty
          ? const Center(
        child: Text(
          'Daftar belanja masih kosong',
          style: TextStyle(fontSize: 18, color: Colors.grey),
        ),
      )
          : ListView.builder(
        itemCount: model.items.length,
        itemBuilder: (context, i) {
          final b = model.items[i];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            child: ListTile(
              leading: Checkbox(
                value: b.sudahDibeli,
                onChanged: (_) => context.read<BelanjaModel>().toggle(i),
              ),
              title: Text(
                b.nama,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  decoration: b.sudahDibeli ? TextDecoration.lineThrough : null,
                  color: b.sudahDibeli ? Colors.grey : Colors.black,
                ),
              ),
              subtitle: Text('Jumlah: ${b.jumlah} | Kategori: ${b.kategori}'),
              trailing: IconButton(
                icon: const Icon(Icons.delete, color: Colors.redAccent),
                onPressed: () => context.read<BelanjaModel>().hapus(i),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const TambahBelanjaPage()),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class TambahBelanjaPage extends StatefulWidget {
  const TambahBelanjaPage({super.key});

  @override
  State<TambahBelanjaPage> createState() => _TambahBelanjaPageState();
}

class _TambahBelanjaPageState extends State<TambahBelanjaPage> {
  final _formKey = GlobalKey<FormState>();
  final _namaController = TextEditingController();
  final _jumlahController = TextEditingController();
  String? _kategoriDipilih;

  final List<String> _pilihanKategori = [
    'Makanan',
    'Minuman',
    'Kebersihan',
    'Elektronik',
    'Lainnya'
  ];

  @override
  void dispose() {
    _namaController.dispose();
    _jumlahController.dispose();
    super.dispose();
  }

  void _simpan() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final nama = _namaController.text.trim();
    final jumlah = int.parse(_jumlahController.text.trim());
    final kategori = _kategoriDipilih!;

    final barangBaru = Barang(nama, jumlah, kategori);
    context.read<BelanjaModel>().tambah(barangBaru);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Barang berhasil ditambahkan ke daftar belanja'),
        duration: Duration(seconds: 2),
      ),
    );

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tambah Barang'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _namaController,
                decoration: const InputDecoration(
                  labelText: 'Nama Barang',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.shopping_bag),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Nama barang wajib diisi';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _jumlahController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Jumlah',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.numbers),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Jumlah wajib diisi';
                  }
                  final angka = int.tryParse(value.trim());
                  if (angka == null || angka <= 0) {
                    return 'Jumlah harus berupa angka dan lebih dari 0';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: _kategoriDipilih,
                decoration: const InputDecoration(
                  labelText: 'Kategori',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.category),
                ),
                items: _pilihanKategori.map((String kategori) {
                  return DropdownMenuItem(
                    value: kategori,
                    child: Text(kategori),
                  );
                }).toList(),
                onChanged: (String? nilaiBaru) {
                  setState(() {
                    _kategoriDipilih = nilaiBaru;
                  });
                },
                validator: (value) {
                  if (value == null) {
                    return 'Kategori wajib dipilih';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                onPressed: _simpan,
                child: const Text('Simpan Barang', style: TextStyle(fontSize: 16)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}