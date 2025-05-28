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
                      child: const Text(
                        'Tabel Hiragana',
                        style: TextStyle(fontSize: 23),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                ],
              ),
            ),
            Container(
              height: 2,
              color: Colors.grey[300],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15, top: 10, right: 15),
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
                            final romaji = state.romajiMap[vocal] ?? '';
                            return GestureDetector(
                              onTap: () {
                                context.push(
                                    '/belajar/detail_huruf_hiragana?letter=$vocal');
                              },
                              child: Column(
                                children: [
                                  Text(
                                    romaji,
                                    style: const TextStyle(fontSize: 14),
                                  ),
                                  const SizedBox(height: 2),
                                  CircleAvatar(
                                    radius: 30,
                                    backgroundColor:
                                        const Color.fromARGB(156, 239, 71, 107),
                                    child: Text(
                                      vocal,
                                      style: const TextStyle(
                                        fontSize: 30,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ],
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
                  const SizedBox(height: 10),
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
                            childAspectRatio: 0.8,
                          ),
                          itemCount: state.konsonanList.length,
                          itemBuilder: (context, index) {
                            final konsonan = state.konsonanList[index];
                            final romaji = state.romajiMap[konsonan] ?? '';

                            return GestureDetector(
                              onTap: () {
                                if (konsonan.isNotEmpty) {
                                  context.push(
                                      '/belajar/detail_huruf_hiragana?letter=$konsonan');
                                }
                              },
                              child: konsonan.isEmpty
                                  ? const SizedBox()
                                  : Column(
                                      children: [
                                        Text(
                                          romaji,
                                          style: const TextStyle(fontSize: 14),
                                        ),
                                        const SizedBox(height: 2),
                                        CircleAvatar(
                                          radius: 30,
                                          backgroundColor: const Color.fromARGB(
                                              156, 239, 71, 107),
                                          child: Text(
                                            konsonan,
                                            style: const TextStyle(
                                              fontSize: 30,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ],
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
