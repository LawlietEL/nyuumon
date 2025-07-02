import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nyuumon/bloc/auth/auth_bloc.dart';
import 'package:nyuumon/routes/router.dart';

class BelajarPage extends StatelessWidget {
  const BelajarPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Menempatkan tombol back dan user info di bagian atas
          Padding(
            padding: const EdgeInsets.only(
                top: 30,
                left: 5,
                bottom: 5,
                right: 10), // Padding di sekitar teks
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Tombol back dengan ikon panah kiri
                IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () {
                    showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (_) =>
                          const Center(child: CircularProgressIndicator()),
                    );
                    Future.delayed(const Duration(milliseconds: 250), () {
                      Navigator.pop(context); // tutup loading
                      Navigator.pop(context); // kembali
                    });
                  },
                ),
                // Menempatkan nama pengguna dan gambar di pojok kanan
                Row(
                  children: [
                    BlocBuilder<AuthBloc, AuthState>(
                      builder: (context, state) {
                        if (state is AuthStateProfilUser) {
                          return Text(
                            state.name,
                            style: const TextStyle(fontSize: 16),
                          );
                        } else {
                          return const Text(
                            'Nama User',
                            style: TextStyle(fontSize: 16),
                          );
                        }
                      },
                    ),
                    const SizedBox(width: 8), // Jarak antara nama dan gambar
                    // Mengubah lingkaran profile menjadi button
                    GestureDetector(
                      onTap: () {
                        showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (_) =>
                              const Center(child: CircularProgressIndicator()),
                        );
                        Future.delayed(const Duration(milliseconds: 250), () {
                          Navigator.pop(context);
                          context.pushNamed(Routes.profil);
                          // Aksi yang ingin dijalankan ketika profile button ditekan
                          print('Profile Button Ditekan');
                        });
                      },
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.grey[300], // Warna lingkaran
                        ),
                        child: ClipOval(
                          child: Image.asset(
                            'assets/icons/logo.png', // Ganti dengan path gambar Anda
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          // Garis horizontal tipis berwarna abu-abu
          Container(
            height: 2, // Tinggi garis
            color: Colors.grey[300], // Warna abu-abu
          ),
          Padding(
            padding: const EdgeInsets.only(top: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Center(
                  child: Image.asset(
                    "assets/icons/logo.png",
                    width: MediaQuery.of(context).size.width * 0.50,
                  ),
                ),
                const SizedBox(height: 40),
                const Text(
                  "Belajar",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 25,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 30), // Jarak antara logo dan kotak
                // Membuat dua kotak berjejer ke samping (horizontal)
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      // Kotak pertama sebagai button
                      GestureDetector(
                        onTap: () {
                          showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (_) => const Center(
                                child: CircularProgressIndicator()),
                          );

                          Future.delayed(const Duration(milliseconds: 250), () {
                            Navigator.pop(context); // tutup loading
                            context.push('/belajar/tabel_hiragana');
                          });
                        },
                        child: Container(
                          width: 110,
                          height: 100,
                          margin: const EdgeInsets.only(bottom: 25),
                          decoration: BoxDecoration(
                            color: Colors.lightBlueAccent,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.grey),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                'assets/images/hiragana.png',
                                width: 60,
                                height: 60,
                              ),
                              const SizedBox(height: 5),
                              const Text(
                                'ひらがな',
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      ),
                      // Kotak kedua sebagai button
                      GestureDetector(
                        onTap: () {
                          showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (_) => const Center(
                                child: CircularProgressIndicator()),
                          );
                          Future.delayed(const Duration(milliseconds: 250), () {
                            Navigator.pop(context); // tutup loading
                            context.push('/belajar/tabel_katakana');
                          });
                        },
                        child: Container(
                          width: 110,
                          height: 100,
                          margin: const EdgeInsets.only(bottom: 25),
                          decoration: BoxDecoration(
                            color: Colors.lightBlueAccent,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.grey),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                'assets/images/katakana.png',
                                width: 60,
                                height: 60,
                              ),
                              const SizedBox(height: 5),
                              const Text(
                                'カタカナ',
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
