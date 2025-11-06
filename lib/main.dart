import 'package:flutter/material.dart';

// Fungsi utama yang menjalankan aplikasi Flutter
void main() {
  runApp(const MyApp());
}

// ====================================================================
// WIDGET UTAMA (MyApp)
// ====================================================================

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Aplikasi Kartu Nama & Login',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // Menggunakan skema warna yang lebih modern
        primarySwatch: Colors.blueGrey,
        hintColor: Colors.tealAccent,
        fontFamily: 'Montserrat', // Contoh font kustom
        textTheme: const TextTheme(
          displayLarge: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
          titleLarge: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
          bodyMedium: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
        ),
        // Properti input decoration untuk tampilan input yang seragam
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white.withOpacity(0.9),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide(color: Colors.teal.shade400, width: 2.0),
          ),
        ),
      ),
      // Aplikasi dimulai dari halaman Login
      home: const LoginScreen(),
    );
  }
}

// ====================================================================
// LAYAR LOGIN (LoginScreen) - Stateful Widget
// ====================================================================

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // Controller untuk mengambil nilai dari TextField
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // Kunci global untuk Form, digunakan untuk validasi
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // Fungsi untuk menangani proses login
  void _attemptLogin() {
    // Memvalidasi form menggunakan _formKey
    if (_formKey.currentState!.validate()) {
      // Jika validasi sukses (kedua kolom terisi), navigasi ke BusinessCardScreen
      // Menggunakan pushReplacement agar halaman login tidak bisa di-back
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const BusinessCardScreen(),
        ),
      );
    }
    // Jika validasi gagal, validator di TextFormField akan menampilkan pesan error
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF37474F), // Warna latar belakang yang gelap
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(30.0),
          child: Form(
            key: _formKey, // Mengaitkan GlobalKey<FormState> dengan Form
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                // Judul Login
                const Text(
                  'Selamat Datang!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                // Deskripsi
                const Text(
                  'Silahkan Login untuk melihat Kartu Nama',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white70,
                  ),
                ),
                // PERBAIKAN: Menggunakan SizedBox untuk mengatur jarak
                const SizedBox(height: 40.0), 

                // Input Username
                TextFormField(
                  controller: _usernameController,
                  decoration: const InputDecoration(
                    labelText: 'Username',
                    prefixIcon: Icon(Icons.person, color: Color(0xFF37474F)),
                  ),
                  keyboardType: TextInputType.text,
                  // Validator untuk mengecek apakah input kosong
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Username tidak boleh kosong!';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20.0),

                // Input Password
                TextFormField(
                  controller: _passwordController,
                  obscureText: true, // Menyembunyikan teks untuk password
                  decoration: const InputDecoration(
                    labelText: 'Password',
                    prefixIcon: Icon(Icons.lock, color: Color(0xFF37474F)),
                  ),
                  // Validator untuk mengecek apakah input kosong
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Password tidak boleh kosong!';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 30.0),

                // Tombol Login
                ElevatedButton(
                  onPressed: _attemptLogin,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 18),
                    backgroundColor: Colors.tealAccent.shade400,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    elevation: 5,
                  ),
                  child: const Text(
                    'Login',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF263238),
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

// ====================================================================
// LAYAR KARTU NAMA (BusinessCardScreen)
// ====================================================================

class BusinessCardScreen extends StatelessWidget {
  const BusinessCardScreen({super.key});

  // Widget untuk membuat baris detail kontak
  Widget _buildContactInfo(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20.0),
      child: Row(
        children: <Widget>[
          Icon(
            icon,
            color: Colors.white,
            size: 28.0,
          ),
          const SizedBox(width: 15.0),
          Text(
            text,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18.0,
              fontFamily: 'Source Sans Pro',
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF263238), // Warna latar belakang gelap (Blue Grey 900)
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              const SizedBox(height: 50.0),

              // Gambar Profil / Avatar
              const CircleAvatar(
                radius: 80.0,
                backgroundImage: AssetImage('assets/profile.jpg'), // Pastikan ada gambar di folder assets
                backgroundColor: Colors.white,
              ),
              const SizedBox(height: 20.0),

              // Nama
              const Text(
                'Kelvin Bintang',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Pacifico',
                  fontSize: 40.0,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10.0),

              // Jabatan
              const Text(
                'Pengembang Aplikasi Mobile',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 20.0,
                  letterSpacing: 2.5,
                  fontWeight: FontWeight.w300,
                  fontFamily: 'Source Sans Pro',
                ),
              ),
              const SizedBox(
                height: 30.0,
                width: 150.0,
                child: Divider(
                  color: Colors.white54,
                  thickness: 1.5,
                ),
              ),

              // Detail Kontak
              _buildContactInfo(Icons.phone, '+62 89699584899'),
              _buildContactInfo(Icons.email, 'kelvinbintang@gmail.com'),
              _buildContactInfo(Icons.location_on, 'Semarang, Indonesia'),

              const SizedBox(height: 50.0),

              // Tombol Navigasi ke Halaman Lain
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50.0),
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const DetailPage(),
                      ),
                    );
                  },
                  icon: const Icon(Icons.info_outline, color: Color(0xFF263238)),
                  label: const Text(
                    'Detail Lainnya',
                    style: TextStyle(fontSize: 16, color: Color(0xFF263238)),
                  ),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    backgroundColor: Colors.tealAccent.shade400,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    elevation: 5,
                  ),
                ),
              ),
              const SizedBox(height: 20.0), 
              // Tombol Logout
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50.0),
                child: OutlinedButton(
                  onPressed: () {
                    // Navigasi kembali ke halaman Login dan hapus semua rute
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => const LoginScreen()),
                      (Route<dynamic> route) => false,
                    );
                  },
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    foregroundColor: Colors.white,
                    side: const BorderSide(color: Colors.white54, width: 1.5),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),
                  child: const Text(
                    'Logout',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
              const SizedBox(height: 50.0),
            ],
          ),
        ),
      ),
    );
  }
}

// ====================================================================
// HALAMAN DETAIL (DetailPage)
// ====================================================================

class DetailPage extends StatelessWidget {
  const DetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Informasi Tambahan',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: Colors.teal.shade700,
        iconTheme: const IconThemeData(color: Colors.white), // Warna ikon back
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Ini adalah halaman detail untuk informasi lebih lanjut!',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Color(0xFF00897B),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back),
              label: const Text('Kembali'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                backgroundColor: Colors.teal.shade500,
                foregroundColor: Colors.white,
                elevation: 5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}