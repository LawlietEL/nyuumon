import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:nyuumon/bloc/belajarh/belajarh_bloc.dart';
import 'package:nyuumon/bloc/belajarh/belajarh_event.dart';
import 'package:nyuumon/bloc/belajarh/belajarh_state.dart';

class DetailHurufHiraganaPage extends StatelessWidget {
  const DetailHurufHiraganaPage({super.key});

  @override
  Widget build(BuildContext context) {
    final letter =
        GoRouterState.of(context).uri.queryParameters['letter'] ?? 'あ';

    return BlocProvider(
      create: (context) => BelajarHBloc()..add(LoadDetailHuruf(letter)),
      child: BlocBuilder<BelajarHBloc, BelajarHState>(
        builder: (context, state) {
          if (state is DetailHurufLoaded) {
            return Scaffold(
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 30, left: 5, bottom: 5, right: 10),
                      child: Row(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.arrow_back),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                          Expanded(
                            child: Align(
                              alignment: Alignment.center,
                              child: const Text(
                                'Detail Huruf',
                                style: TextStyle(fontSize: 23),
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                        ],
                      ),
                    ),
                    Container(
                      height: 2, // Tinggi garis
                      color: Colors.grey[300], // Warna abu-abu
                    ),
                    Padding(
                      padding: const EdgeInsets.all(30),
                      child: Container(
                        width: 180,
                        height: 180,
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(156, 239, 71, 107),
                          border: Border.all(color: Colors.black, width: 2),
                        ),
                        child: Center(
                          child: FittedBox(
                            fit: BoxFit.contain,
                            child: Text(
                              state.letter,
                              style: const TextStyle(
                                fontSize: 140,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Container(
                        width: 180,
                        height: 180,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.black, width: 2),
                        ),
                        child: Center(
                          child: state.imagePath.isNotEmpty
                              ? Image.asset(
                                  state.imagePath,
                                  height: 170,
                                  fit: BoxFit.contain,
                                )
                              : const Text(
                                  'Gambar tidak tersedia',
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.grey),
                                ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 50),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Container(
                        width: 360,
                        height: 80,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black, width: 1),
                        ),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Text(
                                'Latihan Menulis',
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Color.fromARGB(255, 57, 56, 56),
                                ),
                              ),
                              SizedBox(height: 10),
                              Center(
                                child: Text(
                                  'Cobalah tulis pada buku anda',
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.grey,
                                      fontStyle: FontStyle.italic),
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
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
