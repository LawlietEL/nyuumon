import 'package:flutter/material.dart';

class GameMemoryPage extends StatefulWidget {
  const GameMemoryPage({super.key});

  @override
  State<GameMemoryPage> createState() => _GameMemoryPageState();
}

class _GameMemoryPageState extends State<GameMemoryPage> {
  int counter =
      0; // Variabel untuk menghitung jumlah gerakan (tekanan pada kotak)

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
                        'HiraKata Memory',
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
                'Soal 2/6',
                style: TextStyle(
                  fontSize: 25,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
            // Menambahkan SizedBox untuk memberikan jarak agar kotak agak turun
            const SizedBox(),

            // Grid 3x4 kotak yang dapat ditekan
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3, // 3 kolom
                  crossAxisSpacing: 10, // Spasi antar kolom
                  mainAxisSpacing: 10, // Spasi antar baris
                  childAspectRatio: 1, // Proporsi kotak (lebar/tinggi)
                ),
                itemCount: 12, // 12 kotak (3 kolom x 4 baris)
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        counter++; // Menambah counter setiap kotak ditekan
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Color.fromARGB(156, 239, 71, 107),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.black, width: 2),
                      ),
                      child: Center(
                        child: Image.asset(
                          'assets/images/memory.png', // Gambar yang dimasukkan ke kotak
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(
              height: 5,
            ),

            // Teks Gerakan ke 1
            Text(
              'Gerakan ke $counter',
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
