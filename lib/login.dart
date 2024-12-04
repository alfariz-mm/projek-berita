import 'package:flutter/material.dart';
import 'package:flutter_prak_11/berita.dart';
import 'package:flutter_prak_11/koneksi.dart';
import 'package:flutter_prak_11/model.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final UsersService _usersService = UsersService();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;

  Future<void> _handleLogin() async {
    if (_usernameController.text.isEmpty || _passwordController.text.isEmpty) {
      _showErrorDialog("Harap isi username dan password.");
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final List<Users> users = await _usersService.fetchUsers();
      final username = _usernameController.text;
      final password = _passwordController.text;

      // Periksa username dan password
      final user = users.firstWhere(
        (u) => u.username == username && u.password == password,
        orElse: () => throw Exception("Username atau password salah"),
      );

      // Login berhasil
      setState(() {
        _isLoading = false;
      });
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const NewsListScreen()),
      );
    } catch (e) {
      // Tampilkan pesan error
      setState(() {
        _isLoading = false;
      });
      _showErrorDialog(e.toString());
    }
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Login Gagal"),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("OK"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Login',
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontSize: 26,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.amber.shade500, Colors.amber.shade700],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.lock_outline,
                  size: 100,
                  color: Colors.white,
                ),
                const SizedBox(height: 20),
                const Text(
                  'Selamat Datang',
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const Text(
                  'Di Aplikasi Berita',
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Silakan login untuk melanjutkan',
                  style: TextStyle(fontSize: 16, color: Colors.white70),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 30),

                // Input Username
                TextField(
                  controller: _usernameController,
                  decoration: InputDecoration(
                    labelText: "Username",
                    prefixIcon: const Icon(Icons.person, color: Colors.white),
                    labelStyle: const TextStyle(color: Colors.white),
                    filled: true,
                    fillColor: Colors.white.withOpacity(0.4),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  style: const TextStyle(color: Colors.white),
                ),
                const SizedBox(height: 20),

                // Input Password
                TextField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: "Password",
                    prefixIcon: const Icon(Icons.lock, color: Colors.white),
                    filled: true,
                    fillColor: Colors.white.withOpacity(0.4),
                    labelStyle: const TextStyle(color: Colors.white),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  style: const TextStyle(color: Colors.white),
                ),
                const SizedBox(height: 30),

                // Login Button
                ElevatedButton.icon(
                  onPressed: _isLoading ? null : _handleLogin,
                  icon: _isLoading
                      ? const CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2,
                        )
                      : const Icon(Icons.login, color: Colors.white),
                  label: Text(_isLoading ? "Loading..." : "Login"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue.shade600,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 15),
                    textStyle: const TextStyle(fontSize: 16),
                  ),
                ),
                const SizedBox(height: 8),
                // Lupa Password Button
                TextButton(
                  onPressed: () {
                    _showErrorDialog(
                        "Fitur ini belum tersedia. Silakan hubungi admin.");
                  },
                  child: const Text(
                    'Lupa Password?',
                    style: TextStyle(
                      color: Colors.white,
                      decoration: TextDecoration.underline,
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
