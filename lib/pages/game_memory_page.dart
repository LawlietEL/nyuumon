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
                              'HiraKata Memory',
                              style: TextStyle(fontSize: 23),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Divider(color: Colors.grey, thickness: 1),
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
                  if (state.gameStarted) ...[
                    const SizedBox(height: 10),
                    Text(
                      "Waktu: ${state.timer.elapsed.inSeconds} detik",
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "Gerakan: ${state.moves}",
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "Cocokan: ${state.pairsFound} / ${state.numberOfPairs}",
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ],
                  const SizedBox(height: 10),
                  if (state.gameStarted)
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 4,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                          childAspectRatio: 1,
                        ),
                        itemCount: state.cards.length,
                        itemBuilder: (context, index) {
                          bool isRevealed = state.cardVisibility.isNotEmpty &&
                              state.cardVisibility[index];
                          return GestureDetector(
                            onTap: () {
                              if (!isRevealed) {
                                context
                                    .read<GameMemoryBloc>()
                                    .add(CardTappedEvent(cardIndex: index));
                              }
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: isRevealed
                                    ? Colors.white
                                    : Colors.pinkAccent,
                                borderRadius: BorderRadius.circular(10),
                                border:
                                    Border.all(color: Colors.black, width: 2),
                              ),
                              child: Center(
                                child: isRevealed
                                    ? Text(
                                        state.cards[index],
                                        style: const TextStyle(
                                            fontSize: 24,
                                            fontWeight: FontWeight.bold),
                                      )
                                    : Image.asset(
                                        'assets/images/memory.png',
                                        fit: BoxFit.cover,
                                      ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  if (state.pairsFound == state.numberOfPairs &&
                      state.gameStarted)
                    Column(
                      children: [
                        const SizedBox(height: 20),
                        const Text(
                          "Game Selesai!",
                          style: TextStyle(
                              fontSize: 26,
                              fontWeight: FontWeight.bold,
                              color: Colors.green),
                        ),
                        Text(
                            "Total Waktu: ${state.timer.elapsed.inSeconds} detik",
                            style: const TextStyle(fontSize: 20)),
                        Text("Total Gerakan: ${state.moves}",
                            style: const TextStyle(fontSize: 20)),
                        const SizedBox(height: 15),
                        ElevatedButton(
                          onPressed: () {
                            context.read<GameMemoryBloc>().add(StartGameEvent(
                                numberOfPairs: state.numberOfPairs));
                          },
                          child: const Text("Reset Game"),
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
