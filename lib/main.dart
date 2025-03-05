import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nyuumon/bloc/auth/auth_bloc.dart';
import 'package:nyuumon/bloc/belajarh/belajarh_bloc.dart';
import 'package:nyuumon/bloc/belajark/belajark_bloc.dart';
import 'package:nyuumon/bloc/visibility/visibility_cubit.dart';
import 'package:nyuumon/firebase_options.dart';
import 'package:nyuumon/routes/router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (context) => AuthBloc(),
        ),
        BlocProvider<VisibilityCubit>(
          create: (context) => VisibilityCubit(),
        ),
        BlocProvider<BelajarHBloc>(
          // Menambahkan BelajarHBloc
          create: (context) => BelajarHBloc(),
        ),
        BlocProvider<BelajarKBloc>(
          // Menambahkan BelajarKBloc
          create: (context) => BelajarKBloc(),
        ),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: 'Nyuumon Online',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
              seedColor: const Color.fromRGBO(245, 255, 254, 100)),
          useMaterial3: true,
        ),
        routerConfig: router,
      ),
    );
  }
}
