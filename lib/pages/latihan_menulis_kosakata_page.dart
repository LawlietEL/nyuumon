import 'package:flutter/material.dart';

class LatihanMenulisKosakataPage extends StatelessWidget {
  const LatihanMenulisKosakataPage({super.key});

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
                        'Menulis Kosakata',
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
                width: 200, // Lebar tetap
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
              padding: EdgeInsets.only(top: 5),
              child: Text(
                'Soal 1/15',
                style: TextStyle(
                  fontSize: 25,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),

            const SizedBox(height: 10),

            // Kotak pertama: Huruf Hiragana
            Padding(
              padding: const EdgeInsets.all(10),
              child: Container(
                width: 250, // Lebar tetap
                height: 60, // Tinggi tetap (sama dengan lebar)
                decoration: BoxDecoration(
                  color: const Color.fromARGB(156, 239, 71, 107),
                  border: Border.all(
                    color: Colors.black,
                    width: 2, // Border hitam dengan ketebalan 2
                  ),
                ),
                child: const Center(
                  child: Text(
                    'わたし', // Huruf Hiragana
                    style: TextStyle(
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),

            // Row dengan tombol panah back dan next di bawah kotak huragana
            Padding(
              padding: const EdgeInsets.only(left: 37, right: 37),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Panah ke kiri (back button), sejajar dengan kiri kotak hiragana
                  IconButton(
                    padding: EdgeInsets.zero, // Menghapus padding default
                    icon: const Icon(
                      Icons.arrow_left,
                      size: 40,
                    ),
                    onPressed: () {
                      // Aksi tombol back
                    },
                  ),

                  // Panah ke kanan (next button), sejajar dengan kanan kotak hiragana
                  IconButton(
                    padding: EdgeInsets.zero, // Menghapus padding default
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

            // Kotak ketiga: Latihan menulis Hiragana
            Padding(
              padding: const EdgeInsets.all(10),
              child: Container(
                width: 250, // Lebar tetap
                height: 60, // Tinggi tetap (sama dengan lebar)
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
                        'Menulis Kosakata',
                        style: TextStyle(
                          fontSize: 20,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // Kotak keempat: Tempat menulis kosakata
            Padding(
              padding: const EdgeInsets.all(10),
              child: Container(
                width: 150, // Lebar tetap
                height: 150, // Tinggi lebih besar untuk menulis
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black,
                    width: 2, // Border hitam dengan ketebalan 2
                  ),
                ),
                child: const Center(
                  child: Text(
                    'Tempat Menulis Kosakata', // Contoh teks dalam kotak
                    style: TextStyle(
                      fontSize: 15,
                      fontStyle: FontStyle.italic,
                      color: Colors.grey, // Teks berwarna abu-abu
                    ),
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
