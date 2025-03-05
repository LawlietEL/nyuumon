import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:nyuumon/bloc/belajarh/belajarh_bloc.dart';
import 'package:nyuumon/bloc/belajarh/belajarh_event.dart';
import 'package:nyuumon/bloc/belajarh/belajarh_state.dart';

class TabelHiraganaPage extends StatelessWidget {
  const TabelHiraganaPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Memanggil LoadHiraganaData event ketika halaman dibuka
    context.read<BelajarHBloc>().add(LoadHiraganaData());

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding:
                  const EdgeInsets.only(top: 30, left: 5, bottom: 5, right: 10),
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
                      child: Text(
                        'Tabel Hiragana',
                        style: const TextStyle(fontSize: 23),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                ],
              ),
            ),
            const Divider(color: Colors.grey, thickness: 1),
            Padding(
              padding: const EdgeInsets.only(left: 15, top: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Vocal",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  const SizedBox(height: 15),
                  BlocBuilder<BelajarHBloc, BelajarHState>(
                    builder: (context, state) {
                      if (state is BelajarHLoaded) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: state.vocalList.map((vocal) {
                            return GestureDetector(
                              onTap: () {
                                context.push(
                                    '/belajar/detail_huruf_hiragana?letter=$vocal');
                              },
                              child: CircleAvatar(
                                radius: 30,
                                backgroundColor:
                                    const Color.fromARGB(156, 239, 71, 107),
                                child: Text(
                                  vocal,
                                  style: const TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                        );
                      } else if (state is BelajarHInitial) {
                        return const CircularProgressIndicator();
                      } else {
                        return const Text("Data tidak dapat dimuat.");
                      }
                    },
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    "Konsonan",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  const SizedBox(),
                  BlocBuilder<BelajarHBloc, BelajarHState>(
                    builder: (context, state) {
                      if (state is BelajarHLoaded) {
                        return GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 5,
                            mainAxisSpacing: 10,
                            crossAxisSpacing: 10,
                          ),
                          itemCount: state.konsonanList.length,
                          itemBuilder: (context, index) {
                            final konsonan = state.konsonanList[index];
                            return GestureDetector(
                              onTap: () {
                                if (konsonan.isNotEmpty) {
                                  context.push(
                                      '/belajar/detail_huruf_hiragana?letter=$konsonan');
                                }
                              },
                              child: CircleAvatar(
                                radius: 25,
                                backgroundColor: konsonan.isEmpty
                                    ? Colors.transparent
                                    : const Color.fromARGB(156, 239, 71, 107),
                                child: konsonan.isEmpty
                                    ? null
                                    : Text(
                                        konsonan,
                                        style: const TextStyle(
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                              ),
                            );
                          },
                        );
                      } else if (state is BelajarHInitial) {
                        return const CircularProgressIndicator();
                      } else {
                        return const Text("Data tidak dapat dimuat.");
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
