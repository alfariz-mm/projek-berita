import 'package:flutter/material.dart';
import 'package:flutter_prak_11/berita.dart';
import 'package:flutter_prak_11/login.dart';
import 'package:flutter_prak_11/model.dart';

class NewsDetailScreen extends StatelessWidget {
  final News news;

  const NewsDetailScreen({super.key, required this.news});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Detail Berita",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.blueAccent,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          // decoration: BoxDecoration(
          //   gradient: LinearGradient(
          //     colors: [
          //       Colors.amber.shade100,
          //       Colors.amber.shade300,
          //     ],
          //     begin: Alignment.topLeft,
          //     end: Alignment.bottomRight,
          //   ),
          // ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Gambar Berita
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                    news.imageUrl,
                    height: 200,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(
                      height: 200,
                      color: Colors.grey[300],
                      child: const Icon(
                        Icons.broken_image,
                        color: Colors.grey,
                        size: 64,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // Judul Berita
                Text(
                  news.title,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 8),

                // Kategori Berita
                Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 4,
                    horizontal: 12,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.blueAccent.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Text(
                    "Kategori: ${news.category}",
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.blueAccent,
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // Isi Berita
                Text(
                  news.content,
                  style: const TextStyle(
                    fontSize: 16,
                    height: 1.5,
                    color: Colors.black54,
                  ),
                  textAlign: TextAlign.justify,
                ),

                // Footer (Tanda Tangan atau Info Tambahan)
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: ElevatedButton.icon(
                        onPressed: () {
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const NewsListScreen()),
                            (route) => false, // Menghapus semua rute sebelumnya
                          );
                        },
                        icon: const Icon(Icons.home, color: Colors.white),
                        label: const Text('Kembali ke Home'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green.shade600,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          padding: const EdgeInsets.symmetric(
                              vertical: 15, horizontal: 5),
                        ),
                      ),
                    ),
                    const Padding(
                        padding: EdgeInsets.only(
                      top: 16,
                      left: 8,
                      right: 8,
                    )),
                    Align(
                      alignment: Alignment.center,
                      child: ElevatedButton.icon(
                        onPressed: () {
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const LoginView()),
                            (route) => false, // Menghapus semua rute sebelumnya
                          );
                        },
                        icon: const Icon(Icons.login, color: Colors.white),
                        label: const Text('Kembali ke Login'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green.shade600,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          padding: const EdgeInsets.symmetric(
                              vertical: 15, horizontal: 5),
                        ),
                      ),
                    ),
                  ],
                ),

                // Garis Pemisah
                const SizedBox(height: 16),
                const Divider(
                  color: Colors.grey,
                  thickness: 0.8,
                ),

                Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    "Dipublikasikan oleh Aplikasi Berita",
                    style: TextStyle(
                      fontSize: 12,
                      fontStyle: FontStyle.italic,
                      color: Colors.grey[600],
                    ),
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
