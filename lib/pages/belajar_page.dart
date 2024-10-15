import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nyuumon/pages/home_page.dart';

class BelajarPage extends StatelessWidget {
  const BelajarPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Menempatkan tombol back dan user info di bagian atas
          Padding(
            padding: const EdgeInsets.only(
                top: 30,
                left: 5,
                bottom: 5,
                right: 10), // Padding di sekitar teks
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Tombol back dengan ikon panah kiri
                IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () {
                    Navigator.pop(context); // Kembali ke halaman sebelumnya
                  },
                ),
                // Menempatkan nama pengguna dan gambar di pojok kanan
                Row(
                  children: [
                    const Text(
                      'Nama User',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(width: 8), // Jarak antara nama dan gambar
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.grey[300], // Warna lingkaran
                      ),
                      child: ClipOval(
                        child: Image.asset(
                          'assets/icons/logo.png', // Ganti dengan path gambar Anda
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          // Garis horizontal tipis berwarna abu-abu
          Container(
            height: 2, // Tinggi garis
            color: Colors.grey[300], // Warna abu-abu
          ),
          Padding(
            padding: const EdgeInsets.only(top: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Center(
                  child: Image.asset(
                    "assets/icons/logo.png",
                    width: MediaQuery.of(context).size.width * 0.50,
                  ),
                ),
                const SizedBox(height: 40),
                const Text(
                  "Belajar",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 25,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 30), // Jarak antara logo dan kotak
                // Membuat dua kotak berjejer ke samping (horizontal)
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment
                        .spaceEvenly, // Agar kotak merata di horizontal
                    children: [
                      // Kotak pertama sebagai button
                      GestureDetector(
                        onTap: () {
                          context.push('/home/belajar/tabel_hiragana');
                          // Aksi ketika kotak "ひらがな" ditekan
                          print('Kotak ひらがな Ditekan');
                          // Navigator.push() atau aksi lainnya bisa ditambahkan di sini
                        },
                        child: Container(
                          width: 110,
                          height: 100,
                          margin: const EdgeInsets.only(
                              bottom: 25), // Jarak antar kotak
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(
                                156, 239, 71, 107), // Warna background kotak
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.grey),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                'assets/images/hiragana.png', // Gambar untuk kotak pertama
                                width: 60,
                                height: 60,
                              ),
                              const SizedBox(
                                  height: 5), // Spasi antara gambar dan teks
                              const Text(
                                'ひらがな', // Teks untuk kotak pertama
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      // Kotak kedua sebagai button
                      GestureDetector(
                        onTap: () {
                          context.push('/home/belajar/tabel_katakana');
                          // Aksi ketika kotak "カタカナ" ditekan
                          print('Kotak カタカナ Ditekan');
                          // Navigator.push() atau aksi lainnya bisa ditambahkan di sini
                        },
                        child: Container(
                          width: 110,
                          height: 100,
                          margin: const EdgeInsets.only(
                              bottom: 25), // Jarak antar kotak
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(
                                156, 239, 71, 107), // Warna background kotak
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.grey),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                'assets/images/katakana.png', // Gambar untuk kotak kedua
                                width: 60,
                                height: 60,
                              ),
                              const SizedBox(
                                  height: 5), // Spasi antara gambar dan teks
                              const Text(
                                'カタカナ', // Teks untuk kotak kedua
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
