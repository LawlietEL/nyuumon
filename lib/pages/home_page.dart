import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:nyuumon/bloc/auth/auth_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Menempatkan tulisan "Home" dan user info di bagian atas
          Padding(
            padding: const EdgeInsets.only(
                top: 30,
                left: 10,
                bottom: 10,
                right: 10), // Padding di sekitar teks
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Home',
                  style: TextStyle(
                    fontSize: 24,
                  ),
                ),
                // Menempatkan nama pengguna dan gambar di pojok kanan
                Row(
                  children: [
                    BlocBuilder<AuthBloc, AuthState>(
                      builder: (context, state) {
                        if (state is AuthStateProfilUser) {
                          return Text(
                            state.name,
                            style: const TextStyle(
                              fontSize: 16,
                            ),
                          );
                        } else {
                          return const Text(
                            'Nama User',
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          );
                        }
                      },
                    ),
                    const SizedBox(width: 8), // Jarak antara nama dan gambar
                    GestureDetector(
                      onTap: () {
                        context.read<AuthBloc>().add(AuthEventProfilUser());

                        showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (_) =>
                              const Center(child: CircularProgressIndicator()),
                        );
                        Future.delayed(const Duration(milliseconds: 250), () {
                          Navigator.pop(context); // Tutup dialog loading
                          context.push('/profil');
                          print('Profil button ditekan');
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
            padding: const EdgeInsets.only(top: 30),
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
                const SizedBox(height: 50), // Jarak antara logo dan kotak
                // Membuat tiga kotak berjejer ke bawah
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 5),
                  child: Column(
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
                            Navigator.pop(context);
                            context.push('/belajar');
                            // Aksi ketika kotak "Belajar" ditekan
                            print('Kotak Belajar Ditekan');
                          });
                          // Navigator.push() atau aksi lainnya bisa ditambahkan di sini
                        },
                        child: Container(
                          width: 110,
                          height: 100,
                          margin: const EdgeInsets.only(
                              bottom: 35), // Jarak antar kotak
                          decoration: BoxDecoration(
                            color: Colors.lightBlueAccent,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.black),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                'assets/images/belajar.png',
                                width: 60,
                                height: 60,
                              ),
                              const SizedBox(
                                  height: 5), // Spasi antara gambar dan teks
                              const Text(
                                'Belajar',
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
                            Navigator.pop(context);
                            context.push('/games');
                            // Aksi ketika kotak "Games" ditekan
                            print('Kotak Games Ditekan');
                            // Navigator.push() atau aksi lainnya bisa ditambahkan di sini
                          });
                        },
                        child: Container(
                          width: 110,
                          height: 100,
                          margin: const EdgeInsets.only(
                              bottom: 35), // Jarak antar kotak
                          decoration: BoxDecoration(
                            color: Colors.lightBlueAccent,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.black),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                'assets/images/games.png',
                                width: 60,
                                height: 60,
                              ),
                              const SizedBox(
                                  height: 5), // Spasi antara gambar dan teks
                              const Text(
                                'Games',
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      ),
                      // Kotak ketiga sebagai button
                      GestureDetector(
                        onTap: () {
                          showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (_) => const Center(
                                child: CircularProgressIndicator()),
                          );
                          Future.delayed(const Duration(milliseconds: 250), () {
                            Navigator.pop(context);
                            context.push('/latihan');
                            // Aksi ketika kotak "Latihan" ditekan
                            print('Kotak Latihan Ditekan');
                            // Navigator.push() atau aksi lainnya bisa ditambahkan di sini
                          });
                        },
                        child: Container(
                          width: 110,
                          height: 100,
                          margin: const EdgeInsets.only(
                              bottom: 35), // Jarak antar kotak
                          decoration: BoxDecoration(
                            color: Colors.lightBlueAccent,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.black),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                'assets/images/latihan.png',
                                width: 60,
                                height: 60,
                              ),
                              const SizedBox(
                                  height: 5), // Spasi antara gambar dan teks
                              const Text(
                                'Latihan',
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
