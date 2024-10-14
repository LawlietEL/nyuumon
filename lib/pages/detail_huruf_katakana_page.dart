import 'package:flutter/material.dart';

class DetailHurufKatakanaPage extends StatelessWidget {
  const DetailHurufKatakanaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Menempatkan tombol back dan user info di bagian atas
            Padding(
              padding: const EdgeInsets.only(
                  top: 30,
                  left: 5,
                  bottom: 5,
                  right: 10), // Padding di sekitar teks
              child: Row(
                children: [
                  // Tombol back dengan ikon panah kiri
                  IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () {
                      Navigator.pop(context); // Kembali ke halaman sebelumnya
                    },
                  ),
                  // Expanded untuk membuat judul berada di tengah
                  Expanded(
                    child: Align(
                      alignment: Alignment.center,
                      child: const Text(
                        'Detail Huruf',
                        style: TextStyle(
                          fontSize: 23,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8), // Spacer untuk gambar (opsional)
                ],
              ),
            ),
            // Garis horizontal tipis berwarna abu-abu
            const Divider(
              color: Colors.grey,
              thickness: 1,
            ),
            // Kotak pertama: Huruf Hiragana
            Padding(
              padding: const EdgeInsets.all(10),
              child: Container(
                width: 180, // Lebar tetap
                height: 180, // Tinggi tetap (sama dengan lebar)
                decoration: BoxDecoration(
                  color: Color.fromARGB(156, 239, 71, 107),
                  border: Border.all(
                    color: Colors.black,
                    width: 2, // Border hitam dengan ketebalan 2
                  ),
                ),
                child: Center(
                  child: Text(
                    'ア', // Huruf Hiragana
                    style: const TextStyle(
                      fontSize: 100,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            // Kotak kedua: Ilustrasi tulisan Hiragana
            Padding(
              padding: const EdgeInsets.all(10),
              child: Container(
                width: 180, // Lebar tetap
                height: 180, // Tinggi tetap (sama dengan lebar)
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black,
                    width: 2, // Border hitam dengan ketebalan 2
                  ),
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Ilustrasi Tulisan',
                        style: TextStyle(
                          fontSize: 20,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Image.asset(
                        'assets/images/huruf_a_k.png', // Ilustrasi tulisan hiragana
                        height: 80,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            // Kotak ketiga: Latihan menulis Hiragana
            Padding(
              padding: const EdgeInsets.all(10),
              child: Container(
                width: 180, // Lebar tetap
                height: 180, // Tinggi tetap (sama dengan lebar)
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black,
                    width: 2, // Border hitam dengan ketebalan 2
                  ),
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text(
                        'Latihan Menulis',
                        style: TextStyle(
                          fontSize: 20,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                      SizedBox(height: 10),
                      Center(
                        child: Text(
                          'Tempat untuk\nmenulis tangan',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
