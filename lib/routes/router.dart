import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nyuumon/pages/belajar_page.dart';
import 'package:nyuumon/pages/change_password.dart';
import 'package:nyuumon/pages/create_account_page.dart';
import 'package:nyuumon/pages/detail_huruf_hiragana_page.dart';
import 'package:nyuumon/pages/detail_huruf_katakana_page.dart';
import 'package:nyuumon/pages/edit_profile_page.dart';
import 'package:nyuumon/pages/forget_password_page.dart';
import 'package:nyuumon/pages/game_matching_page.dart';
import 'package:nyuumon/pages/game_memory_page.dart';
import 'package:nyuumon/pages/games_page.dart';
import 'package:nyuumon/pages/home_page.dart';
import 'package:nyuumon/pages/latihan_membaca_hirakata_page.dart';
import 'package:nyuumon/pages/latihan_menulis_hirakata_page.dart';
import 'package:nyuumon/pages/latihan_page.dart';
import 'package:nyuumon/pages/login_page.dart';
import 'package:nyuumon/pages/profil_page.dart';
import 'package:nyuumon/pages/tabel_hiragana_page.dart';
import 'package:nyuumon/pages/tabel_katakana_page.dart';

part 'route_name.dart';

final GoRouter router = GoRouter(
  //VERSI BARU
  // redirect: (context, state) async {
  // final user = FirebaseAuth.instance.authStateChanges().first;
  // if (await user == null) {
  //   return "/login";
  // } else {
  //   return null;
  // }
  // },

  //VERSI LAMA
  redirect: (context, state) {
    FirebaseAuth auth = FirebaseAuth.instance;
    // cek kondisi saat ini -> sedang terautentikasi
    if (auth.currentUser == null) {
      // tidak sedang login / tidak ada user yg aktif saat ini
      return "/login";
    } else {
      return null;
    }
  },
  // initialLocation: '/login',
  routes: [
    GoRoute(
      path: '/login',
      name: Routes.login,
      builder: (BuildContext context, GoRouterState state) {
        return LoginPage();
      },
      routes: [
        GoRoute(
            path: 'create_account',
            name: Routes.create_account,
            builder: (BuildContext context, GoRouterState state) {
              return CreateAccountPage();
            },
            routes: [
              GoRoute(
                path: 'back_to_login',
                name: Routes.back_to_login,
                builder: (BuildContext context, GoRouterState state) {
                  return LoginPage();
                },
              ),
            ]),
        GoRoute(
          path: 'forget_password',
          name: Routes.forget_password,
          builder: (BuildContext context, GoRouterState state) {
            return ForgetPasswordPage();
          },
        ),
      ],
    ),
    GoRoute(
      path: '/',
      name: Routes.home,
      builder: (BuildContext context, GoRouterState state) {
        return HomePage();
      },
    ),
    GoRoute(
      path: '/belajar',
      name: Routes.belajar,
      builder: (BuildContext context, GoRouterState state) {
        return const BelajarPage();
      },
      routes: [
        GoRoute(
          path: 'tabel_hiragana',
          name: Routes.tabel_hiragana,
          builder: (BuildContext context, GoRouterState state) {
            return const TabelHiraganaPage();
          },
        ),
        GoRoute(
          path: 'tabel_katakana',
          name: Routes.tabel_katakana,
          builder: (BuildContext context, GoRouterState state) {
            return const TabelKatakanaPage();
          },
        ),
        GoRoute(
          path: "detail_huruf_katakana",
          name: Routes.detail_huruf_katakana,
          builder: (BuildContext context, GoRouterState state) {
            return const DetailHurufKatakanaPage();
          },
        ),
        GoRoute(
          path: "detail_huruf_hiragana",
          name: Routes.detail_huruf_hiragana,
          builder: (BuildContext context, GoRouterState state) {
            return const DetailHurufHiraganaPage();
          },
        ),
      ],
    ),
    GoRoute(
      path: '/games',
      name: Routes.games,
      builder: (BuildContext context, GoRouterState state) {
        return const GamesPage();
      },
      routes: [
        GoRoute(
          path: 'game_matching',
          name: Routes.game_matching,
          builder: (BuildContext context, GoRouterState state) {
            return GameMatchingPage();
          },
        ),
        GoRoute(
          path: 'game_memory',
          name: Routes.game_memory,
          builder: (BuildContext context, GoRouterState state) {
            return const GameMemoryPage();
          },
        ),
      ],
    ),
    GoRoute(
      path: '/latihan',
      name: Routes.latihan,
      builder: (BuildContext context, GoRouterState state) {
        return const LatihanPage();
      },
      routes: [
        GoRoute(
          path: 'latihan_menulis_hirakata',
          name: Routes.latihan_menulis_hirakata,
          builder: (BuildContext context, GoRouterState state) {
            return const LatihanMenulisHirakataPage();
          },
        ),
        GoRoute(
          path: 'latihan_membaca_hirakata',
          name: Routes.latihan_membaca_hirakata,
          builder: (BuildContext context, GoRouterState state) {
            return const LatihanMembacaHirakataPage();
          },
        ),
      ],
    ),
    GoRoute(
      path: '/profil',
      name: Routes.profil,
      builder: (BuildContext context, GoRouterState state) {
        return const ProfilPage();
      },
      routes: [
        GoRoute(
          path: '/logout',
          name: Routes.logout,
          builder: (BuildContext context, GoRouterState state) {
            return LoginPage();
          },
        ),
        GoRoute(
          path: '/edit_profile',
          name: Routes.edit_profile,
          builder: (BuildContext context, GoRouterState state) {
            return EditProfilePage();
          },
        ),
        GoRoute(
          path: '/change_password',
          name: Routes.change_password,
          builder: (BuildContext context, GoRouterState state) {
            return ChangePassword();
          },
        ),
      ],
    ),
  ],
);
