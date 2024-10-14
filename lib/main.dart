import 'package:flutter/material.dart';
import 'package:nyuumon/pages/belajar_page.dart';
import 'package:nyuumon/pages/detail_huruf_hiragana_page.dart';
import 'package:nyuumon/pages/detail_huruf_katakana_page.dart';
import 'package:nyuumon/pages/game_matching_page.dart';
import 'package:nyuumon/pages/game_memory_page.dart';
import 'package:nyuumon/pages/games_page.dart';
import 'package:nyuumon/pages/home_page.dart';
import 'package:nyuumon/pages/latihan_membaca_hirakata_page.dart';
import 'package:nyuumon/pages/latihan_menulis_hirakata_page.dart';
import 'package:nyuumon/pages/latihan_menulis_kosakata_page.dart';
import 'package:nyuumon/pages/latihan_page.dart';
import 'package:nyuumon/pages/login_page.dart';
import 'package:nyuumon/pages/splash_screen.dart';
import 'package:nyuumon/pages/tabel_hiragana_page.dart';
import 'package:nyuumon/pages/tabel_katakana_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Nyuumon Online',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromRGBO(245, 255, 254, 100)),
        useMaterial3: true,
      ),
      home: const LatihanMenulisKosakataPage(),
    );
  }
}
