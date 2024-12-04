import 'package:flutter/material.dart';
import 'package:flutter_prak_11/listPages.dart';
// import 'package:flutter_prak_11/login.dart';
// import 'package:flutter_prak_11/berita.dart';
// import 'package:flutter_prak_11/model.dart';
// import 'package:flutter_prak_11/koneksi.dart';

void main() {
  runApp(const NewsApp());
}

class NewsApp extends StatelessWidget {
  const NewsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomeView(),
      debugShowCheckedModeBanner: false,
    );
  }
}
