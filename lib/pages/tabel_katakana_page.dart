import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class TabelKatakanaPage extends StatelessWidget {
  const TabelKatakanaPage({super.key});

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
                        'Tabel Katakana',
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
                  // Lingkaran huruf Vocal berjejer ke samping dan jadi button
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: ['ア', 'イ', 'ウ', 'エ', 'オ'].map((vocal) {
                      return GestureDetector(
                        onTap: () {
                          context.push(
                              // Kirim parameter huruf yang ditekan ke halaman detail
                              '/belajar/detail_huruf_katakana?letter=$vocal');
                          print('Vocal $vocal Ditekan');
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
                          // Jika huruf tidak kosong, kirim parameter huruf ke halaman detail
                          if (konsonan.isNotEmpty) {
                            context.push(
                                '/belajar/detail_huruf_katakana?letter=$konsonan');
                            print('Konsonan $konsonan Ditekan');
                          }
                        },
                        child: CircleAvatar(
                          radius: 25,
                          backgroundColor: konsonan.isEmpty
                              ? Colors
                                  .transparent // Lingkaran kosong sama dengan warna background
                              : const Color.fromARGB(156, 239, 71, 107),
                          child: konsonan.isEmpty
                              ? null // Jika tidak ada huruf katakana, jangan tampilkan teks
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

  // Fungsi untuk mendapatkan huruf konsonan Katakana tanpa string kosong
  List<String> _konsonanList() {
    const konsonanList = [
      'カ', 'キ', 'ク', 'ケ', 'コ', // Baris 1
      'サ', 'シ', 'ス', 'セ', 'ソ', // Baris 2
      'タ', 'チ', 'ツ', 'テ', 'ト', // Baris 3
      'ナ', 'ニ', 'ヌ', 'ネ', 'ノ', // Baris 4
      'ハ', 'ヒ', 'フ', 'ヘ', 'ホ', // Baris 5
      'マ', 'ミ', 'ム', 'メ', 'モ', // Baris 6
      'ヤ', '', 'ユ', '', 'ヨ', // Baris 7
      'ラ', 'リ', 'ル', 'レ', 'ロ', // Baris 8
      'ワ', '', '', '', 'ヲ', // Baris 9
      'ン', '', '', '', '' // Baris 10
    ];
    return konsonanList;
  }
}
