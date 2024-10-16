import 'package:flutter/material.dart';

class ChangePassword extends StatelessWidget {
  const ChangePassword({super.key});

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
                        'Change Password',
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
            const SizedBox(height: 20), // Jarak antara divider dan logo

            // Menambahkan logo menggantikan CircleAvatar
            Padding(
              padding: const EdgeInsets.only(top: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Center(
                    child: Image.asset(
                      "assets/icons/logo.png", // Ganti dengan path gambar Anda
                      width: MediaQuery.of(context).size.width *
                          0.50, // Lebar gambar 50% dari lebar layar
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30), // Jarak setelah logo

            // Kolom isian pertama (Recent Password)
            Container(
              padding: const EdgeInsets.symmetric(
                  horizontal: 20, vertical: 5), // Mengurangi jarak antar kolom
              child: TextField(
                obscureText: true, // Untuk menyembunyikan teks
                decoration: const InputDecoration(
                  hintText: 'Recent Password',
                  hintStyle: TextStyle(
                      color: Color(0xFF8A8888)), // Mengubah warna hint text
                  prefixIcon: Icon(Icons.lock_outline,
                      color: Color(0xFF8A8888)), // Mengubah warna ikon gembok
                  border: OutlineInputBorder(),
                ),
              ),
            ),

            // Kolom isian kedua (New Password)
            Container(
              padding: const EdgeInsets.symmetric(
                  horizontal: 20, vertical: 5), // Mengurangi jarak antar kolom
              child: TextField(
                obscureText: true, // Untuk menyembunyikan teks
                decoration: const InputDecoration(
                  hintText: 'New Password',
                  hintStyle: TextStyle(
                      color: Color(0xFF8A8888)), // Mengubah warna hint text
                  prefixIcon: Icon(Icons.lock,
                      color: Color(0xFF8A8888)), // Mengubah warna ikon gembok
                  border: OutlineInputBorder(),
                ),
              ),
            ),

            // Kolom isian ketiga (Confirm New Password)
            Container(
              padding: const EdgeInsets.symmetric(
                  horizontal: 20, vertical: 5), // Mengurangi jarak antar kolom
              child: TextField(
                obscureText: true, // Untuk menyembunyikan teks
                decoration: const InputDecoration(
                  hintText: 'Confirm New Password',
                  hintStyle: TextStyle(
                      color: Color(0xFF8A8888)), // Mengubah warna hint text
                  prefixIcon: Icon(Icons.lock,
                      color: Color(0xFF8A8888)), // Mengubah warna ikon gembok
                  border: OutlineInputBorder(),
                ),
              ),
            ),

            const SizedBox(height: 35), // Jarak setelah kolom isian ketiga

            // Button "Change"
            GestureDetector(
              onTap: () {
                // Aksi ketika tombol ditekan
                print('Change button clicked');
              },
              child: Container(
                width: 150,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.blue, // Warna kotak button
                  borderRadius:
                      BorderRadius.circular(5), // Membuat sudut membulat
                ),
                child: const Center(
                  child: Text(
                    'Change',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white, // Warna teks
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20), // Jarak di akhir halaman
          ],
        ),
      ),
    );
  }
}
