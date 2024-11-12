import 'package:flutter/material.dart';

class DetailHurufPage extends StatelessWidget {
  const DetailHurufPage({super.key});

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
                      child: Text(
                        'Detail Huruf',
                        style: const TextStyle(
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
            // Menambahkan 3 persegi di bawah Divider, berjejer vertikal di tengah halaman
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Persegi pertama dengan background pink dan garis luar hitam
                    Container(
                      width: 145,
                      height: 145,
                      decoration: BoxDecoration(
                        color: Color.fromARGB(156, 239, 71, 107),
                        border: Border.all(color: Colors.black),
                      ),
                    ),
                    const SizedBox(height: 20), // Jarak antar persegi
                    // Persegi kedua dengan background putih dan garis luar hitam
                    Container(
                      width: 145,
                      height: 145,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.black),
                      ),
                    ),
                    const SizedBox(height: 20), // Jarak antar persegi
                    // Persegi ketiga dengan background putih dan garis luar hitam
                    Container(
                      width: 145,
                      height: 145,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.black),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
