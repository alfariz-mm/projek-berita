import 'package:flutter/material.dart';
import 'package:flutter_prak_11/berita.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

class AddNewsScreen extends StatefulWidget {
  const AddNewsScreen({Key? key}) : super(key: key);

  @override
  State<AddNewsScreen> createState() => _AddNewsScreenState();
}

class _AddNewsScreenState extends State<AddNewsScreen> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController categoryController = TextEditingController();
  final TextEditingController contentController = TextEditingController();
  final TextEditingController imageUrlController =
      TextEditingController(); // Input untuk gambar
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  Future<void> saveNews() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
    });

    final String title = titleController.text;
    final String category = categoryController.text;
    final String content = contentController.text;
    final String imageUrl = imageUrlController.text;

    try {
      final response = await http.post(
        Uri.parse(
            'http://192.168.56.1:3000/news'), // Ganti sesuai dengan URL JSON Server Anda
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "title": title,
          "category": category,
          "content": content,
          "imageUrl": imageUrl,
        }),
      );

      if (response.statusCode == 201) {
        // Jika data berhasil ditambahkan
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Berita berhasil ditambahkan!")),
        );
        Navigator.pop(context); // Kembali ke halaman sebelumnya
      } else {
        throw Exception(
            "Gagal menambah berita. Status: ${response.statusCode}");
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: $e")),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Tambah Berita',
              style: GoogleFonts.montserrat(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        backgroundColor: Colors.amberAccent,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.green.shade50, Colors.yellow.shade200],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                // Judul Berita
                TextFormField(
                  controller: titleController,
                  decoration: InputDecoration(
                    hintText: 'Masukkan Judul',
                    labelText: 'Judul Berita',
                    icon: const Icon(Icons.title, color: Colors.blueAccent),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide:
                          const BorderSide(color: Colors.blueAccent, width: 1),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide:
                          const BorderSide(color: Colors.blueAccent, width: 2),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Judul berita tidak boleh kosong';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                // Kategori Berita
                TextFormField(
                  controller: categoryController,
                  decoration: InputDecoration(
                    hintText: 'Masukkan Kategori',
                    labelText: 'Kategori Berita',
                    icon: const Icon(Icons.category, color: Colors.blueAccent),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide:
                          const BorderSide(color: Colors.blueAccent, width: 1),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide:
                          const BorderSide(color: Colors.blueAccent, width: 2),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Kategori tidak boleh kosong';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                // Konten Berita
                TextFormField(
                  controller: contentController,
                  decoration: InputDecoration(
                    hintText: 'Masukkan Konten',
                    labelText: 'Konten Berita',
                    icon: Icon(Icons.article, color: Colors.blueAccent),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide:
                          BorderSide(color: Colors.blueAccent, width: 1),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide:
                          BorderSide(color: Colors.blueAccent, width: 2),
                    ),
                  ),
                  maxLines: 6,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Konten berita tidak boleh kosong';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                // Link Gambar
                TextFormField(
                  controller: imageUrlController,
                  decoration: InputDecoration(
                    hintText: 'Masukkan Link Gambar',
                    labelText: 'Link Gambar',
                    icon: Icon(Icons.link, color: Colors.blueAccent),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide:
                          BorderSide(color: Colors.blueAccent, width: 1),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide:
                          BorderSide(color: Colors.blueAccent, width: 2),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Link gambar tidak boleh kosong';
                    }
                    if (!Uri.parse(value).isAbsolute) {
                      return 'Masukkan link gambar yang valid';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 30),

                // Tombol Simpan Data
                ElevatedButton.icon(
                  onPressed: _isLoading ? null : saveNews,
                  icon: _isLoading
                      ? const CircularProgressIndicator(
                          color: Colors.white, strokeWidth: 2)
                      : const Icon(Icons.save, color: Colors.white),
                  label: Text(_isLoading ? "Loading..." : "Simpan Data"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 15),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    elevation: 5,
                  ),
                ),
                const SizedBox(height: 30),

                // Tombol Kembali
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const NewsListScreen()),
                      (route) => false, // Menghapus semua rute sebelumnya
                    );
                  },
                  icon: const Icon(Icons.login, color: Colors.white),
                  label: const Text('Kembali Ke Berita'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green.shade600,
                    padding:
                        const EdgeInsets.symmetric(vertical: 15, horizontal: 5),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    elevation: 5,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
