import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class TabelHiraganaPage extends StatelessWidget {
  const TabelHiraganaPage({super.key});

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
                        'Tabel Hiragana',
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
            // Bagian Vocal
            Padding(
              padding: const EdgeInsets.only(left: 15, top: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Vocal",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  const SizedBox(height: 15),
                  // Lingkaran huruf Vocal berjejer ke samping
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: ['あ', 'い', 'う', 'え', 'お'].map((vocal) {
                      return GestureDetector(
                        onTap: () {
                          context.push(
                              '/home/belajar/tabel_hiragana/detail_huruf');
                          print('Vocal $vocal Ditekan');
                          // Bisa melakukan aksi lain sesuai kebutuhan
                        },
                        child: CircleAvatar(
                          radius: 30,
                          backgroundColor:
                              const Color.fromARGB(156, 239, 71, 107),
                          child: Text(
                            vocal,
                            style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    "Konsonan",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  const SizedBox(),
                  // Grid lingkaran konsonan tanpa lingkaran kosong
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 5,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                    ),
                    itemCount: _konsonanList().length,
                    itemBuilder: (context, index) {
                      final konsonan = _konsonanList()[index];
                      return GestureDetector(
                        onTap: () {
                          context.push(
                              '/home/belajar/tabel_hiragana/detail_huruf');
                          if (konsonan.isNotEmpty) {
                            print('Konsonan $konsonan Ditekan');
                          }
                        },
                        child: CircleAvatar(
                          radius: 25,
                          backgroundColor: konsonan.isEmpty
                              ? Colors.transparent
                              : const Color.fromARGB(156, 239, 71, 107),
                          child: konsonan.isEmpty
                              ? null
                              : Text(
                                  konsonan,
                                  style: const TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Fungsi untuk mendapatkan huruf konsonan tanpa string kosong
  List<String> _konsonanList() {
    const konsonanList = [
      'か', 'き', 'く', 'け', 'こ', // Baris 1
      'さ', 'し', 'す', 'せ', 'そ', // Baris 2
      'た', 'ち', 'つ', 'て', 'と', // Baris 3
      'な', 'に', 'ぬ', 'ね', 'の', // Baris 4
      'は', 'ひ', 'ふ', 'へ', 'ほ', // Baris 5
      'ま', 'み', 'む', 'め', 'も', // Baris 6
      'や', '', 'ゆ', '', 'よ', // Baris 7
      'ら', 'り', 'る', 'れ', 'ろ', // Baris 8
      'わ', '', '', '', 'を', // Baris 9
      'ん', '', '', '', '' // Baris 10
    ];
    return konsonanList;
  }
}
