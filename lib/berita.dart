import 'package:flutter/material.dart';
import 'package:flutter_prak_11/addNews.dart';
import 'package:flutter_prak_11/deleteNews.dart';
import 'package:flutter_prak_11/detail_berita.dart';
import 'package:flutter_prak_11/login.dart';
import 'package:flutter_prak_11/model.dart';
import 'package:flutter_prak_11/koneksi.dart';

class NewsListScreen extends StatefulWidget {
  const NewsListScreen({super.key});

  @override
  _NewsListScreenState createState() => _NewsListScreenState();
}

final NewsService newsService = NewsService();

class _NewsListScreenState extends State<NewsListScreen> {
  late Future<List<News>> newsList;

  @override
  void initState() {
    super.initState();
    newsList = newsService.fetchNews();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Aplikasi Berita",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
        backgroundColor: Colors.blueAccent,
        centerTitle: true,
      ),
      body: Container(
        color: Colors.amberAccent,
        child: Column(
          children: [
            Expanded(
              child: FutureBuilder<List<News>>(
                future: newsList,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: Colors.blueAccent,
                        strokeWidth: 4,
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.error_outline,
                            color: Colors.red,
                            size: 64,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            "Error: ${snapshot.error}",
                            style: const TextStyle(
                              fontSize: 18,
                              color: Colors.black54,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    );
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(
                      child: Text(
                        "Tidak ada berita tersedia.",
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.black54,
                        ),
                      ),
                    );
                  } else {
                    final news = snapshot.data!;
                    return ListView.builder(
                      itemCount: news.length,
                      itemBuilder: (context, index) {
                        return Card(
                          margin: const EdgeInsets.symmetric(
                            vertical: 8,
                            horizontal: 16,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 4,
                          child: ListTile(
                            contentPadding: const EdgeInsets.all(12),
                            leading: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.network(
                                news[index].imageUrl,
                                fit: BoxFit.cover,
                                width: 80,
                                height: 80,
                                errorBuilder: (context, error, stackTrace) =>
                                    const Icon(
                                  Icons.broken_image,
                                  size: 64,
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                            title: Text(
                              news[index].title,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                            ),
                            subtitle: Text(
                              news[index].category,
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.black54,
                              ),
                            ),
                            trailing: const Icon(
                              Icons.arrow_forward_ios,
                              color: Colors.blueAccent,
                            ),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      NewsDetailScreen(news: news[index]),
                                ),
                              );
                            },
                          ),
                        );
                      },
                    );
                  }
                },
              ),
            ),

            // Footer Section
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
                            builder: (context) => const AddNewsScreen()),
                        (route) => false, // Menghapus semua rute sebelumnya
                      );
                    },
                    icon: const Icon(Icons.add, color: Colors.white),
                    label: const Text('Tambah Berita'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green.shade600,
                      padding: const EdgeInsets.symmetric(
                          vertical: 15, horizontal: 5),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Align(
                  alignment: Alignment.center,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const DeleteNewsScreen()),
                        (route) => false, // Menghapus semua rute sebelumnya
                      );
                    },
                    icon: const Icon(Icons.delete, color: Colors.white),
                    label: const Text('Hapus Berita'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green.shade600,
                      padding: const EdgeInsets.symmetric(
                          vertical: 15, horizontal: 5),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
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
                    label: const Text('Keluar'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red.shade600,
                      padding: const EdgeInsets.symmetric(
                          vertical: 15, horizontal: 5),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
