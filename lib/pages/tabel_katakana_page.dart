import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:nyuumon/bloc/belajark/belajark_bloc.dart';
import 'package:nyuumon/bloc/belajark/belajark_event.dart';
import 'package:nyuumon/bloc/belajark/belajark_state.dart';

class TabelKatakanaPage extends StatelessWidget {
  const TabelKatakanaPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Memanggil LoadKatakanaData event ketika halaman dibuka
    context.read<BelajarKBloc>().add(LoadKatakanaData());

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
                        'Tabel Katakana',
                        style: const TextStyle(fontSize: 23),
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
                  BlocBuilder<BelajarKBloc, BelajarKState>(
                    builder: (context, state) {
                      if (state is BelajarKLoaded) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: state.vocalList.map((vocal) {
                            final romaji = state.romajiMap[vocal] ?? '';
                            return GestureDetector(
                              onTap: () {
                                context.push(
                                    '/belajar/detail_huruf_katakana?letter=$vocal');
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
                                    backgroundColor: Colors.lightBlueAccent,
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
                      } else if (state is BelajarKInitial) {
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
                  BlocBuilder<BelajarKBloc, BelajarKState>(
                    builder: (context, state) {
                      if (state is BelajarKLoaded) {
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
                                      '/belajar/detail_huruf_katakana?letter=$konsonan');
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
                                          backgroundColor:
                                              Colors.lightBlueAccent,
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
                      } else if (state is BelajarKInitial) {
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
