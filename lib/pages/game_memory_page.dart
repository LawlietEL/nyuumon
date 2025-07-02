import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nyuumon/bloc/gamememory/gamememory_bloc.dart';
import 'package:nyuumon/bloc/gamememory/gamememory_event.dart';
import 'package:nyuumon/bloc/gamememory/gamememory_state.dart';

class GameMemoryPage extends StatelessWidget {
  const GameMemoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => GameMemoryBloc(),
      child: Scaffold(
        body: SingleChildScrollView(
          child: BlocBuilder<GameMemoryBloc, GameMemoryState>(
            builder: (context, state) {
              return Column(
                children: [
                  // **Header (Tombol Back dan Judul)**
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 30, left: 5, bottom: 5, right: 10),
                    child: Row(
                      children: [
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
                        Expanded(
                          child: Align(
                            alignment: Alignment.center,
                            child: const Text(
                              'HiraKata Memory',
                              style: TextStyle(fontSize: 23),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 2, // Tinggi garis
                    color: Colors.grey[300], // Warna abu-abu
                  ),

                  // **Dropdown untuk memilih jumlah soal sebelum game dimulai**
                  if (!state.gameStarted)
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: DropdownButton<int>(
                        hint: const Text("Pilih jumlah soal"),
                        value:
                            state.numberOfPairs > 0 ? state.numberOfPairs : 5,
                        items: List.generate(6, (index) {
                          int pairs = (index + 5);
                          return DropdownMenuItem(
                            value: pairs,
                            child: Text("$pairs Pasang"),
                          );
                        }),
                        onChanged: (value) {
                          if (value != null) {
                            context
                                .read<GameMemoryBloc>()
                                .add(StartGameEvent(numberOfPairs: value));
                          }
                        },
                      ),
                    ),

                  // **Menampilkan waktu, jumlah gerakan, dan jumlah pasangan yang cocok**
                  if (state.gameStarted) ...[
                    const SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // **Timer di sebelah kiri atas**
                          Text(
                            "Waktu: ${state.elapsedTime} detik",
                            style: const TextStyle(
                              fontSize: 20,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                          // **Hitungan gerakan di sebelah kanan atas**
                          Text(
                            "Gerakan: ${state.moves}",
                            style: const TextStyle(
                              fontSize: 20,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 25),
                    // **Jumlah Cocokan Tetap di Tengah**
                    Text(
                      "Cocokan: ${state.pairsFound} / ${state.numberOfPairs}",
                      style: const TextStyle(
                          fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                  ],

                  // **Grid untuk kartu permainan**
                  if (state.gameStarted)
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Align(
                        alignment: Alignment.center,
                        child: Wrap(
                          alignment: WrapAlignment.center,
                          spacing: 10,
                          runSpacing: 10,
                          children: List.generate(
                            state.cards.length,
                            (index) {
                              if (state.cards[index] == '') {
                                return const SizedBox(
                                    width: 87,
                                    height:
                                        87); // Hilangkan kartu yang sudah cocok
                              }

                              return GestureDetector(
                                onTap: () {
                                  context
                                      .read<GameMemoryBloc>()
                                      .add(CardTappedEvent(cardIndex: index));
                                },
                                child: Container(
                                  width: 87,
                                  height: 87,
                                  decoration: BoxDecoration(
                                    color: Colors.lightBlueAccent,
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                        color: Colors.black, width: 2),
                                  ),
                                  child: Center(
                                    child: Text(
                                      state.cards[
                                          index], // Huruf hiragana/katakana
                                      style: const TextStyle(
                                        fontSize: 60,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ),

                  // **Menampilkan hasil akhir saat semua kartu cocok**
                  if (state.pairsFound == state.numberOfPairs &&
                      state.gameStarted)
                    Column(
                      children: [
                        const Text(
                          "Game Selesai!",
                          style: TextStyle(
                              fontSize: 38,
                              fontWeight: FontWeight.bold,
                              color: Colors.pinkAccent),
                        ),
                        const SizedBox(height: 30),
                        ElevatedButton(
                          onPressed: () {
                            showDialog(
                              context: context,
                              barrierDismissible: false,
                              builder: (_) => const Center(
                                  child: CircularProgressIndicator()),
                            );
                            Future.delayed(const Duration(milliseconds: 250),
                                () {
                              Navigator.pop(context);
                              context
                                  .read<GameMemoryBloc>()
                                  .add(ResetGameEvent());
                            });
                          },
                          child: const Text(
                            "Reset Game",
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                      ],
                    ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
