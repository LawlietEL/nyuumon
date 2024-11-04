import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:nyuumon/bloc/auth/auth_bloc.dart';

class ProfilPage extends StatelessWidget {
  const ProfilPage({super.key});

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
                        'Profil Saya',
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
            const SizedBox(height: 10), // Jarak antara divider dan CircleAvatar
            // Menambahkan lingkaran untuk gambar (CircleAvatar)
            CircleAvatar(
              radius: 50, // Ukuran lingkaran (radius)
              backgroundColor:
                  Colors.grey[300], // Warna latar belakang lingkaran
              child: ClipOval(
                child: Image.asset(
                  'assets/icons/logo.png', // Ganti dengan path gambar Anda
                  width: 120, // Ukuran gambar sesuai dengan radius lingkaran
                  height: 120,
                  fit:
                      BoxFit.cover, // Menyesuaikan gambar agar pas di lingkaran
                ),
              ),
            ),
            const SizedBox(height: 20), // Jarak setelah CircleAvatar

            // Button "Ubah Profil"
            GestureDetector(
              onTap: () {
                // Aksi ketika tombol ditekan
                print('Ubah Profil ditekan');
              },
              child: Container(
                width: 130,
                height: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.blue, // Warna kotak
                ),
                child: const Center(
                  child: Text(
                    'Ubah Profil',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
                height: 35), // Jarak antara button dan container informasi

            // Kotak informasi user (Nama dan Email)
            Container(
              padding: const EdgeInsets.all(10),
              width: 300,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Colors.white, // Warna latar belakang kotak
                border: Border.all(color: Colors.grey),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: const [
                      Icon(Icons.person, color: Colors.grey), // Ikon person
                      SizedBox(width: 10), // Jarak antara ikon dan teks
                      Text(
                        'Nama User', // Nama user
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5), // Jarak antar teks
                  Row(
                    children: const [
                      Icon(Icons.email, color: Colors.grey), // Ikon email
                      SizedBox(width: 10), // Jarak antara ikon dan teks
                      Text(
                        'namauser@gmail.com', // Email user
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 2,
            ), // Jarak setelah kotak informasi

            // Button "Change Password"
            GestureDetector(
              onTap: () {
                context.push('/home/profil/change_password');
                // Aksi ketika tombol ditekan
                print('Change Password ditekan');
              },
              child: Container(
                padding: const EdgeInsets.all(10),
                width: 300,
                decoration: BoxDecoration(
                  color: Colors.white, // Warna kotak
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(color: Colors.grey),
                ),
                child: Row(
                  children: const [
                    Icon(Icons.lock, color: Colors.grey), // Ikon gembok
                    SizedBox(width: 10), // Jarak antara ikon dan teks
                    Text(
                      'Change Password',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
                height:
                    50), // Jarak antara button "Change Password" dan button "Logout"

            // Button "Logout"
            GestureDetector(
              onTap: () {
                context.read<AuthBloc>().add(AuthEventLogout());
                // Aksi ketika tombol ditekan
                print('Logout ditekan');
              },
              child: Container(
                width: 100,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.red, // Warna kotak
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Center(
                  child: Text(
                    'Logout',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
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
