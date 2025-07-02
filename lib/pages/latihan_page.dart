import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nyuumon/bloc/auth/auth_bloc.dart';
import 'package:nyuumon/routes/router.dart';

class LatihanPage extends StatelessWidget {
  const LatihanPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding:
                const EdgeInsets.only(top: 30, left: 5, bottom: 5, right: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
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
                    const SizedBox(width: 8),
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
                          print('Profile Button Ditekan');
                        });
                      },
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.grey[300],
                        ),
                        child: ClipOval(
                          child: Image.asset(
                            'assets/icons/logo.png',
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
          Container(
            height: 2,
            color: Colors.grey[300],
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
                  "Latihan",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 25,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 30),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
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
                            context.push('/latihan/latihan_menulis_hirakata');
                            print('Menulis Hirakata Ditekan');
                          });
                        },
                        child: Container(
                          width: 120,
                          height: 115,
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
                                'assets/images/menulishirakata.png',
                                width: 70,
                                height: 65,
                              ),
                              const SizedBox(height: 5),
                              const Text(
                                'Menulis\nHirakata',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      ),
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
                            context.push('/latihan/latihan_membaca_hirakata');
                            print('Membaca Hirakata Ditekan');
                          });
                        },
                        child: Container(
                          width: 120,
                          height: 115,
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
                                'assets/images/membacahirakata.png',
                                width: 70,
                                height: 65,
                              ),
                              const SizedBox(height: 5),
                              const Text(
                                'Membaca\nHirakata',
                                textAlign: TextAlign.center,
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
