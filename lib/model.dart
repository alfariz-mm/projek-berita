class News {
  final String id;
  final String title;
  final String category;
  final String content;
  final String imageUrl;

  News({
    required this.id,
    required this.title,
    required this.category,
    required this.content,
    required this.imageUrl,
  });

  factory News.fromJson(Map<String, dynamic> json) {
    return News(
      id: json['id'] ?? 0, // Beri nilai default jika null
      title: json['title'] ?? "Judul Tidak Tersedia",
      category: json['category'] ?? "Kategori Tidak Diketahui",
      content: json['content'] ?? "Konten Kosong",
      imageUrl: json['imageUrl'] ?? "Gambar Tidak Tersedia",
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'category': category,
      'content': content,
      'imageUrl': imageUrl,
    };
  }
}

class Users {
  final String idpengguna;
  final String nama;
  final String username;
  final String password;

  Users({
    required this.idpengguna,
    required this.nama,
    required this.username,
    required this.password,
  });

  factory Users.fromJson(Map<String, dynamic> json) {
    return Users(
      idpengguna: json['idpengguna'] ?? 0,
      nama: json['nama'] ?? "Nama Tidak Tersedia",
      username: json['username'] ?? "Username Tidak Diketahui",
      password: json['password'] ?? "Password Tidak Diketahui",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'idpengguna': idpengguna,
      'nama': nama,
      'username': username,
      'password': password,
    };
  }
}
