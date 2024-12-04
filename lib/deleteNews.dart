import 'package:flutter/material.dart';
import 'package:flutter_prak_11/berita.dart';
import 'package:http/http.dart' as http;

class DeleteNewsScreen extends StatefulWidget {
  const DeleteNewsScreen({Key? key}) : super(key: key);

  @override
  State<DeleteNewsScreen> createState() => _DeleteNewsScreenState();
}

class _DeleteNewsScreenState extends State<DeleteNewsScreen> {
  final TextEditingController idController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  Future<void> deleteNews() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
    });

    final String id = idController.text;

    try {
      final response = await http.delete(
        Uri.parse(
            'http://192.168.56.1:3000/news/$id'), // Ganti sesuai URL JSON Server
      );

      if (response.statusCode == 200 || response.statusCode == 204) {
        // Jika berhasil dihapus
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Berita berhasil dihapus!")),
        );
        idController.clear(); // Kosongkan input
      } else if (response.statusCode == 404) {
        throw Exception("Berita dengan ID tersebut tidak ditemukan.");
      } else {
        throw Exception(
            "Gagal menghapus berita. Status: ${response.statusCode}");
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
          children: const [
            Text(
              'Hapus Berita',
              style: TextStyle(color: Colors.white, fontSize: 26),
            ),
          ],
        ),
        backgroundColor: Colors.amberAccent,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.yellow.shade100, Colors.white],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: idController,
                  decoration: const InputDecoration(
                    hintText: 'Masukkan ID Berita',
                    labelText: 'ID Berita',
                    icon: Icon(Icons.delete),
                  ),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'ID berita tidak boleh kosong';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 30),
                ElevatedButton.icon(
                  onPressed: _isLoading ? null : deleteNews,
                  icon: _isLoading
                      ? const CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2,
                        )
                      : const Icon(Icons.delete, color: Colors.white),
                  label: Text(_isLoading ? "Loading..." : "Hapus Berita"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.redAccent,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 15),
                  ),
                ),
                const SizedBox(height: 30),
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
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    padding:
                        const EdgeInsets.symmetric(vertical: 15, horizontal: 5),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
