import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class DetailHurufHiraganaPage extends StatelessWidget {
  const DetailHurufHiraganaPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Mengambil parameter letter dari query parameter, default 'あ' jika tidak ada
    final letter =
        GoRouterState.of(context).uri.queryParameters['letter'] ?? 'あ';

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
            // Kotak kedua: Ilustrasi tulisan Hiragana
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
            // Kotak ketiga: Latihan menulis Hiragana
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
  'あ': 'assets/hiragana/a.png',
  'い': 'assets/hiragana/i.png',
  'う': 'assets/hiragana/u.png',
  'え': 'assets/hiragana/e.png',
  'お': 'assets/hiragana/o.png',
  'か': 'assets/hiragana/ka.png',
  'き': 'assets/hiragana/ki.png',
  'く': 'assets/hiragana/ku.png',
  'け': 'assets/hiragana/ke.png',
  'こ': 'assets/hiragana/ko.png',
  'さ': 'assets/hiragana/sa.png',
  'し': 'assets/hiragana/shi.png',
  'す': 'assets/hiragana/su.png',
  'せ': 'assets/hiragana/se.png',
  'そ': 'assets/hiragana/so.png',
  'た': 'assets/hiragana/ta.png',
  'ち': 'assets/hiragana/chi.png',
  'つ': 'assets/hiragana/tsu.png',
  'て': 'assets/hiragana/te.png',
  'と': 'assets/hiragana/to.png',
  'な': 'assets/hiragana/na.png',
  'に': 'assets/hiragana/ni.png',
  'ぬ': 'assets/hiragana/nu.png',
  'ね': 'assets/hiragana/ne.png',
  'の': 'assets/hiragana/no.png',
  'は': 'assets/hiragana/ha.png',
  'ひ': 'assets/hiragana/hi.png',
  'ふ': 'assets/hiragana/fu.png',
  'へ': 'assets/hiragana/he.png',
  'ほ': 'assets/hiragana/ho.png',
  'ま': 'assets/hiragana/ma.png',
  'み': 'assets/hiragana/mi.png',
  'む': 'assets/hiragana/mu.png',
  'め': 'assets/hiragana/me.png',
  'も': 'assets/hiragana/mo.png',
  'や': 'assets/hiragana/ya.png',
  'ゆ': 'assets/hiragana/yu.png',
  'よ': 'assets/hiragana/yo.png',
  'ら': 'assets/hiragana/ra.png',
  'り': 'assets/hiragana/ri.png',
  'る': 'assets/hiragana/ru.png',
  'れ': 'assets/hiragana/re.png',
  'ろ': 'assets/hiragana/ro.png',
  'わ': 'assets/hiragana/wa.png',
  'を': 'assets/hiragana/wo.png',
  'ん': 'assets/hiragana/n.png',
};
