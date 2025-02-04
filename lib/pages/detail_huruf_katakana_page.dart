import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class DetailHurufKatakanaPage extends StatelessWidget {
  const DetailHurufKatakanaPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Mengambil parameter letter dari query parameter, default 'ア' jika tidak ada
    final letter =
        GoRouterState.of(context).uri.queryParameters['letter'] ?? 'ア';
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Menempatkan tombol back dan user info di bagian atas
            Padding(
              padding:
                  const EdgeInsets.only(top: 30, left: 5, bottom: 5, right: 10),
              child: Row(
                children: [
                  // Tombol back dengan ikon panah kiri
                  IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  // Judul halaman
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
                  const SizedBox(width: 8),
                ],
              ),
            ),
            // Garis horizontal tipis
            const Divider(
              color: Colors.grey,
              thickness: 1,
            ),
            // Kotak untuk menampilkan huruf dengan background pink
            Padding(
              padding: const EdgeInsets.all(10),
              child: Container(
                width: 180, // Lebar tetap
                height: 180, // Tinggi tetap
                decoration: BoxDecoration(
                  color: const Color.fromARGB(156, 239, 71, 107),
                  border: Border.all(
                    color: Colors.black,
                    width: 2,
                  ),
                ),
                child: Center(
                  child: FittedBox(
                    fit: BoxFit.contain,
                    child: Text(
                      letter, // Menampilkan huruf yang dikirim
                      style: const TextStyle(
                        fontSize: 140,
                        fontWeight: FontWeight.bold,
                        color: Colors.white, // Warna putih
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            // Kotak kedua: Ilustrasi tulisan Katakana
            Padding(
              padding: const EdgeInsets.all(10),
              child: Container(
                width: 180,
                height: 180,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black,
                    width: 2,
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
                        'assets/images/huruf_a_k.png',
                        height: 80,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            // Kotak ketiga: Latihan menulis Katakana
            Padding(
              padding: const EdgeInsets.all(10),
              child: Container(
                width: 180,
                height: 180,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black,
                    width: 2,
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
