import 'package:flutter/material.dart';
import 'package:flutter_prak_11/addNews.dart';
import 'package:flutter_prak_11/berita.dart';
import 'package:flutter_prak_11/deleteNews.dart';
import 'package:flutter_prak_11/login.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HomeView'),
        centerTitle: true,
        backgroundColor: Colors.teal,
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.teal.shade200, Colors.teal.shade400],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Ini adalah List Pages',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginView()),
                );
              },
              icon: const Icon(Icons.login, color: Colors.white),
              label: const Text('Halaman Login'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal.shade600,
                padding: const EdgeInsets.symmetric(vertical: 15),
              ),
            ),
            const SizedBox(height: 15),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const NewsListScreen()),
                );
              },
              icon: const Icon(Icons.newspaper, color: Colors.white),
              label: const Text('Halaman Berita'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal.shade600,
                padding: const EdgeInsets.symmetric(vertical: 15),
              ),
            ),
            const SizedBox(height: 15),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const AddNewsScreen()),
                );
              },
              icon: const Icon(Icons.add, color: Colors.white),
              label: const Text('Halaman Tambah Berita'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal.shade600,
                padding: const EdgeInsets.symmetric(vertical: 15),
              ),
            ),
            const SizedBox(height: 15),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const DeleteNewsScreen()),
                );
              },
              icon: const Icon(Icons.delete, color: Colors.white),
              label: const Text('Halaman Hapus Berita'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal.shade600,
                padding: const EdgeInsets.symmetric(vertical: 15),
              ),
            ),
            // const SizedBox(height: 15),
            // ElevatedButton.icon(
            //   onPressed: () {
            //     Navigator.push(
            //       context,
            //       MaterialPageRoute(
            //           builder: (context) => const DeleteNewsScreen()),
            //     );
            //   },
            //   icon: const Icon(Icons.details, color: Colors.white),
            //   label: const Text('Halaman Detail Berita'),
            //   style: ElevatedButton.styleFrom(
            //     backgroundColor: Colors.teal.shade600,
            //     padding: const EdgeInsets.symmetric(vertical: 15),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
