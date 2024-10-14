import 'package:flutter/material.dart';

class LatihanMenulisHirakataPage extends StatelessWidget {
  const LatihanMenulisHirakataPage({super.key});

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
                        'Menulis HiraKata',
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

            // Kotak persegi panjang "Waktu 15"
            Padding(
              padding: const EdgeInsets.all(10),
              child: Container(
                width: 200, // Lebar mengikuti lebar layar
                height: 50, // Tinggi kotak
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                    color: Colors.black,
                    width: 2, // Border hitam dengan ketebalan 2
                  ),
                ),
                child: const Center(
                  child: Text(
                    'Waktu 15',
                    style: TextStyle(
                      fontSize: 24,
                      fontStyle: FontStyle.italic,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ),

            // Tulisan Soal 1/15
            const Padding(
              padding: EdgeInsets.only(top: 10),
              child: Text(
                'Soal 1/15',
                style: TextStyle(
                  fontSize: 25,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),

            const SizedBox(height: 10),

            // Row dengan panah kiri, kotak huruf, dan panah kanan
            Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // Panah ke kiri (back button)
                  IconButton(
                    icon: const Icon(
                      Icons.arrow_left,
                      size: 40,
                    ),
                    onPressed: () {
                      // Aksi tombol back
                    },
                  ),

                  // Kotak pertama: Huruf Hiragana
                  Container(
                    width: 160, // Lebar tetap
                    height: 160, // Tinggi tetap (sama dengan lebar)
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(156, 239, 71, 107),
                      border: Border.all(
                        color: Colors.black,
                        width: 2, // Border hitam dengan ketebalan 2
                      ),
                    ),
                    child: const Center(
                      child: Text(
                        'あ', // Huruf Hiragana
                        style: TextStyle(
                          fontSize: 100,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),

                  // Panah ke kanan (next button)
                  IconButton(
                    icon: const Icon(
                      Icons.arrow_right,
                      size: 40,
                    ),
                    onPressed: () {
                      // Aksi tombol next
                    },
                  ),
                ],
              ),
            ),

            const SizedBox(height: 5),

            // Kotak ketiga: Latihan menulis Hiragana
            Padding(
              padding: const EdgeInsets.all(10),
              child: Container(
                width: 160, // Lebar tetap
                height: 160, // Tinggi tetap (sama dengan lebar)
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
