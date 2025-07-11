import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:nyuumon/bloc/auth/auth_bloc.dart';

class ProfilPage extends StatelessWidget {
  const ProfilPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthStateLogout) {
            // Tampilkan notifikasi logout berhasil
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("Berhasil logout!"),
                duration: Duration(seconds: 2),
              ),
            );
            // Navigasi kembali ke halaman login
            context.go('/login');
          }
        },
        child: SingleChildScrollView(
          child: BlocBuilder<AuthBloc, AuthState>(builder: (context, state) {
            if (state is AuthStateProfilUser) {
              return Column(
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
                            showDialog(
                              context: context,
                              barrierDismissible: false,
                              builder: (_) => const Center(
                                  child: CircularProgressIndicator()),
                            );
                            Future.delayed(const Duration(milliseconds: 250),
                                () {
                              Navigator.pop(context); // tutup loading
                              Navigator.pop(context); // kembali
                            });
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
                        const SizedBox(
                            width: 8), // Spacer untuk gambar (opsional)
                      ],
                    ),
                  ),
                  // Garis horizontal tipis berwarna abu-abu
                  const Divider(
                    color: Colors.grey,
                    thickness: 1,
                  ),
                  const SizedBox(
                      height: 10), // Jarak antara divider dan CircleAvatar
                  // Menambahkan lingkaran untuk gambar (CircleAvatar)
                  CircleAvatar(
                    radius: 50, // Ukuran lingkaran (radius)
                    backgroundColor:
                        Colors.grey[300], // Warna latar belakang lingkaran
                    child: ClipOval(
                      child: Image.asset(
                        'assets/icons/logo.png', // Ganti dengan path gambar Anda
                        width:
                            120, // Ukuran gambar sesuai dengan radius lingkaran
                        height: 120,
                        fit: BoxFit
                            .cover, // Menyesuaikan gambar agar pas di lingkaran
                      ),
                    ),
                  ),
                  const SizedBox(
                      height: 35), // Kotak informasi user (Nama dan Email)
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
                          children: [
                            Icon(Icons.person,
                                color: Colors.grey), // Ikon person
                            SizedBox(width: 10), // Jarak antara ikon dan teks
                            Text(
                              state.name, // Nama user
                              style: TextStyle(
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 5), // Jarak antar teks
                        Row(
                          children: [
                            Icon(Icons.email, color: Colors.grey), // Ikon email
                            SizedBox(width: 10), // Jarak antara ikon dan teks
                            Text(
                              state.email, // Email user
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
                      showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (_) =>
                            const Center(child: CircularProgressIndicator()),
                      );

                      Future.delayed(const Duration(milliseconds: 250), () {
                        Navigator.pop(context); // tutup loading
                        context.push('/profil/change_password');
                        // Aksi ketika tombol ditekan
                        print('Change Password ditekan');
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      width: 300,
                      decoration: BoxDecoration(
                        color: Colors.blue, // Warna kotak
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(color: Colors.grey),
                      ),
                      child: Row(
                        children: const [
                          Icon(Icons.lock, color: Colors.white), // Ikon gembok
                          SizedBox(width: 10), // Jarak antara ikon dan teks
                          Text(
                            'Change Password',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                      height:
                          40), // Jarak antara button "Change Password" dan button "Logout"

                  // Button "Logout"
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
                        context.read<AuthBloc>().add(AuthEventLogout());
                        // Aksi ketika tombol ditekan
                        print('Logout ditekan');
                      });
                    },
                    child: Container(
                      width: 100,
                      height: 45,
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
              );
            } else if (state is AuthStateLoading) {
              return CircularProgressIndicator();
            } else {
              return SizedBox();
            }
          }),
        ),
      ),
    );
  }
}
