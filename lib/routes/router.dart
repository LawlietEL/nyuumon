import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nyuumon/pages/belajar_page.dart';
import 'package:nyuumon/pages/games_page.dart';
import 'package:nyuumon/pages/home_page.dart';
import 'package:nyuumon/pages/latihan_page.dart';
import 'package:nyuumon/pages/login_page.dart';
import 'package:nyuumon/pages/onboarding_page.dart';
import 'package:nyuumon/pages/tabel_hiragana_page.dart';
import 'package:nyuumon/pages/tabel_katakana_page.dart';

part 'route_name.dart';

final GoRouter router = GoRouter(
    // redirect: (context, state) {
    // FirebaseAuth.instance.authStateChanges().listen((User? user) {
    //   if (user == null) {
    //     return '/login';
    //   } else {
    //     return '/';
    //   }
    // });
    // },
    routes: [
      GoRoute(
        path: '/onboarding',
        name: Routes.onboarding,
        builder: (BuildContext context, GoRouterState state) {
          return const OnBoardingPage();
        },
      ),
      // GoRoute(
      //   path: '/login',
      //   name: Routes.login,
      //   builder: (BuildContext context, GoRouterState state) {
      //     return LoginPage();
      //   },
      // ),
      GoRoute(
          path: '/',
          name: Routes.login,
          builder: (BuildContext context, GoRouterState state) {
            return const LoginPage();
          },
          routes: [
            GoRoute(
                path: 'home',
                name: Routes.home,
                builder: (BuildContext context, GoRouterState state) {
                  return const HomePage();
                },
                routes: [
                  GoRoute(
                    path: 'belajar',
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
                    ],
                  ),
                  GoRoute(
                    path: 'games',
                    name: Routes.games,
                    builder: (BuildContext context, GoRouterState state) {
                      return const GamesPage();
                    },
                  ),
                  GoRoute(
                    path: 'latihan',
                    name: Routes.latihan,
                    builder: (BuildContext context, GoRouterState state) {
                      return const LatihanPage();
                    },
                  ),
                ]),
          ]),
    ]);
