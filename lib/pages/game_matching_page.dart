import 'package:flutter/material.dart';

class GameMatchingPage extends StatelessWidget {
  const GameMatchingPage({super.key});

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
                        'Matching HiraKata',
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
            // Teks soal 1/10
            const Padding(
              padding: EdgeInsets.only(top: 10),
              child: Text(
                'Soal 1/10',
                style: TextStyle(
                  fontSize: 25,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
            // Menambahkan SizedBox untuk memberikan jarak agar kotak agak turun
            const SizedBox(height: 30),
            // Row dengan panah kiri, kotak huruf, dan panah kanan
            Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // Panah ke kiri
                  IconButton(
                    icon: const Icon(
                      Icons.arrow_left,
                      size: 40,
                    ),
                    onPressed: () {
                      // Aksi tombol back
                    },
                  ),
                  // Kotak huruf
                  Container(
                    width: 180, // Lebar tetap
                    height: 180, // Tinggi tetap (sama dengan lebar)
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(156, 239, 71, 107),
                      border: Border.all(
                        color: Colors.black,
                        width: 2, // Border hitam dengan ketebalan 2
                      ),
                    ),
                    child: const Center(
                      child: Text(
                        'ア', // Huruf Hiragana
                        style: TextStyle(
                          fontSize: 100,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  // Panah ke kanan
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
            // Tiga lingkaran button di bawah kotak huruf
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // Lingkaran pertama
                  CircleAvatar(
                    radius: 45,
                    backgroundColor: Color.fromRGBO(81, 79, 80, 100),
                    child: IconButton(
                      icon: const Text(
                        'あ',
                        style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      onPressed: () {
                        // Aksi tombol lingkaran 1
                      },
                    ),
                  ),
                  // Lingkaran kedua
                  CircleAvatar(
                    radius: 45,
                    backgroundColor: Color.fromRGBO(81, 79, 80, 100),
                    child: IconButton(
                      icon: const Text(
                        'い',
                        style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      onPressed: () {
                        // Aksi tombol lingkaran 2
                      },
                    ),
                  ),
                  // Lingkaran ketiga
                  CircleAvatar(
                    radius: 45,
                    backgroundColor: Color.fromRGBO(81, 79, 80, 100),
                    child: IconButton(
                      icon: const Text(
                        'う',
                        style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      onPressed: () {
                        // Aksi tombol lingkaran 3
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
