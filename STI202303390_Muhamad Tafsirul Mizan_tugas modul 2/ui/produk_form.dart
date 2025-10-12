import 'package:flutter/material.dart';
import 'produk_detail.dart';

class ProdukForm extends StatefulWidget {
  const ProdukForm({Key? key}) : super(key: key);

  @override
  _ProdukFormState createState() => _ProdukFormState();
}

class _ProdukFormState extends State<ProdukForm> {
  final _kodeProdukTextboxController = TextEditingController();
  final _namaProdukTextboxController = TextEditingController();
  final _hargaProdukTextboxController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Form Produk'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    _textboxKodeProduk(),
                    const SizedBox(height: 15),
                    _textboxNamaProduk(),
                    const SizedBox(height: 15),
                    _textboxHargaProduk(),
                    const SizedBox(height: 20),
                    _tombolSimpan(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _textboxKodeProduk() {
    return TextField(
      decoration: const InputDecoration(
        labelText: "Kode Produk",
        border: OutlineInputBorder(),
        prefixIcon: Icon(Icons.code),
      ),
      controller: _kodeProdukTextboxController,
    );
  }

  Widget _textboxNamaProduk() {
    return TextField(
      decoration: const InputDecoration(
        labelText: "Nama Produk",
        border: OutlineInputBorder(),
        prefixIcon: Icon(Icons.shopping_bag),
      ),
      controller: _namaProdukTextboxController,
    );
  }

  Widget _textboxHargaProduk() {
    return TextField(
      decoration: const InputDecoration(
        labelText: "Harga",
        border: OutlineInputBorder(),
        prefixIcon: Icon(Icons.attach_money),
      ),
      keyboardType: TextInputType.number,
      controller: _hargaProdukTextboxController,
    );
  }

  Widget _tombolSimpan() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          if (_kodeProdukTextboxController.text.isEmpty ||
              _namaProdukTextboxController.text.isEmpty ||
              _hargaProdukTextboxController.text.isEmpty) {
            _showDialog('Error', 'Semua field harus diisi!');
            return;
          }

          try {
            String kodeProduk = _kodeProdukTextboxController.text;
            String namaProduk = _namaProdukTextboxController.text;
            int harga = int.parse(_hargaProdukTextboxController.text);

            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProdukDetail(
                  kodeProduk: kodeProduk,
                  namaProduk: namaProduk,
                  harga: harga,
                ),
              ),
            );
          } catch (e) {
            _showDialog('Error', 'Harga harus berupa angka!');
          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.green,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 15),
        ),
        child: const Text(
          'Simpan Produk',
          style: TextStyle(fontSize: 16),
        ),
      ),
    );
  }

  void _showDialog(String title, String content) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
}