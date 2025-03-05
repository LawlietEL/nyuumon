import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:nyuumon/bloc/belajark/belajark_bloc.dart';
import 'package:nyuumon/bloc/belajark/belajark_event.dart';
import 'package:nyuumon/bloc/belajark/belajark_state.dart';

class DetailHurufKatakanaPage extends StatelessWidget {
  const DetailHurufKatakanaPage({super.key});

  @override
  Widget build(BuildContext context) {
    final letter =
        GoRouterState.of(context).uri.queryParameters['letter'] ?? 'ア';

    return BlocProvider(
      create: (context) => BelajarKBloc()..add(LoadDetailHuruf(letter)),
      child: BlocBuilder<BelajarKBloc, BelajarKState>(
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
                    const Divider(color: Colors.grey, thickness: 1),
                    Padding(
                      padding: const EdgeInsets.all(10),
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
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Container(
                        width: 180,
                        height: 180,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black, width: 2),
                        ),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Text(
                                'Latihan Menulis',
                                style: TextStyle(
                                    fontSize: 20, fontStyle: FontStyle.italic),
                              ),
                              SizedBox(height: 10),
                              Center(
                                child: Text(
                                  'Tempat untuk\nmenulis tangan',
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.grey),
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
