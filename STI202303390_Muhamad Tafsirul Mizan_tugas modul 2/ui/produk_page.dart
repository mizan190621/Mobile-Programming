import 'package:flutter/material.dart';
import 'produk_detail.dart';
import 'produk_form.dart';

class ProdukPage extends StatefulWidget {
  const ProdukPage({Key? key}) : super(key: key);

  @override
  _ProdukPageState createState() => _ProdukPageState();
}

class _ProdukPageState extends State<ProdukPage> {
  final List<Map<String, dynamic>> produkList = [
    {
      'kodeProduk': 'A001',
      'namaProduk': 'Kulkas LG 2 Pintu',
      'harga': 2500000,
    },
    {
      'kodeProduk': 'A002',
      'namaProduk': 'TV Samsung 55 Inch',
      'harga': 5000000,
    },
    {
      'kodeProduk': 'A003',
      'namaProduk': 'Mesin Cuci Sharp 8kg',
      'harga': 1500000,
    },
  ];

  void _tambahProdukBaru(Map<String, dynamic> produk) {
    setState(() {
      produkList.add(produk);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Data Produk',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue,
        actions: [
          IconButton(
            icon: const Icon(Icons.add, color: Colors.white),
            onPressed: () async {
              final result = await Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ProdukForm()),
              );
              
              if (result != null) {
                _tambahProdukBaru(result);
              }
            },
            tooltip: 'Tambah Produk',
          ),
        ],
      ),
      body: produkList.isEmpty
          ? const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.inventory_2, size: 64, color: Colors.grey),
                  SizedBox(height: 16),
                  Text(
                    'Belum ada produk',
                    style: TextStyle(fontSize: 18, color: Colors.grey),
                  ),
                ],
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16.0),
              itemCount: produkList.length,
              itemBuilder: (context, index) {
                return ItemProduk(
                  kodeProduk: produkList[index]['kodeProduk'],
                  namaProduk: produkList[index]['namaProduk'],
                  harga: produkList[index]['harga'],
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProdukDetail(
                          kodeProduk: produkList[index]['kodeProduk'],
                          namaProduk: produkList[index]['namaProduk'],
                          harga: produkList[index]['harga'],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const ProdukForm()),
          );
          
          if (result != null) {
            _tambahProdukBaru(result);
          }
        },
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        child: const Icon(Icons.add),
        tooltip: 'Tambah Produk',
      ),
    );
  }
}

class ItemProduk extends StatelessWidget {
  final String? kodeProduk;
  final String? namaProduk;
  final int? harga;
  final VoidCallback? onTap;

  const ItemProduk({
    Key? key,
    this.kodeProduk,
    this.namaProduk,
    this.harga,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: const Icon(Icons.shopping_bag, color: Colors.blue),
        title: Text(
          namaProduk ?? 'No Name',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Kode: ${kodeProduk ?? '-'}'),
            Text(
              'Rp ${harga?.toStringAsFixed(0) ?? '0'}',
              style: const TextStyle(
                color: Colors.green,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: onTap,
      ),
    );
  }
}