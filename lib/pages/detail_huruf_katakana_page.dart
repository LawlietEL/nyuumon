import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class DetailHurufKatakanaPage extends StatelessWidget {
  const DetailHurufKatakanaPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Mengambil parameter letter dari query parameter, default 'ア' jika tidak ada
    final letter =
        GoRouterState.of(context).uri.queryParameters['letter'] ?? 'ア';

    // Mengambil gambar berdasarkan huruf
    final imagePath = _imageMap[letter] ?? 'assets/hiragana/a.png';

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
                  color: Colors.white,
                  border: Border.all(
                    color: Colors.black,
                    width: 2,
                  ),
                ),
                child: Center(
                  child: imagePath.isNotEmpty
                      ? Image.asset(
                          imagePath,
                          height: 170,
                          fit: BoxFit.contain,
                        )
                      : const Text(
                          'Gambar tidak tersedia',
                          style: TextStyle(fontSize: 16, color: Colors.grey),
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

// Map yang menghubungkan huruf dengan gambar
final Map<String, String> _imageMap = {
  'ア': 'assets/katakana/a.png',
  'イ': 'assets/katakana/i.png',
  'ウ': 'assets/katakana/u.png',
  'エ': 'assets/katakana/e.png',
  'オ': 'assets/katakana/o.png',
  'カ': 'assets/katakana/ka.png',
  'キ': 'assets/katakana/ki.png',
  'ク': 'assets/katakana/ku.png',
  'ケ': 'assets/katakana/ke.png',
  'コ': 'assets/katakana/ko.png',
  'サ': 'assets/katakana/sa.png',
  'シ': 'assets/katakana/shi.png',
  'ス': 'assets/katakana/su.png',
  'セ': 'assets/katakana/se.png',
  'ソ': 'assets/katakana/so.png',
  'タ': 'assets/katakana/ta.png',
  'チ': 'assets/katakana/chi.png',
  'ツ': 'assets/katakana/tsu.png',
  'テ': 'assets/katakana/te.png',
  'ト': 'assets/katakana/to.png',
  'ナ': 'assets/katakana/na.png',
  'ニ': 'assets/katakana/ni.png',
  'ヌ': 'assets/katakana/nu.png',
  'ネ': 'assets/katakana/ne.png',
  'ノ': 'assets/katakana/no.png',
  'ハ': 'assets/katakana/ha.png',
  'ヒ': 'assets/katakana/hi.png',
  'フ': 'assets/katakana/fu.png',
  'ヘ': 'assets/katakana/he.png',
  'ホ': 'assets/katakana/ho.png',
  'マ': 'assets/katakana/ma.png',
  'ミ': 'assets/katakana/mi.png',
  'ム': 'assets/katakana/mu.png',
  'メ': 'assets/katakana/me.png',
  'モ': 'assets/katakana/mo.png',
  'ヤ': 'assets/katakana/ya.png',
  'ユ': 'assets/katakana/yu.png',
  'ヨ': 'assets/katakana/yo.png',
  'ラ': 'assets/katakana/ra.png',
  'リ': 'assets/katakana/ri.png',
  'ル': 'assets/katakana/ru.png',
  'レ': 'assets/katakana/re.png',
  'ロ': 'assets/katakana/ro.png',
  'ワ': 'assets/katakana/wa.png',
  'ヲ': 'assets/katakana/wo.png',
  'ン': 'assets/katakana/n.png',
};
