import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:nyuumon/bloc/auth/auth_bloc.dart';

class CreateAccountPage extends StatelessWidget {
  CreateAccountPage({super.key});

  // Tambahkan controller untuk setiap input field
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  // Notifiers untuk mengontrol visibilitas password
  final ValueNotifier<bool> passwordVisible = ValueNotifier<bool>(false);
  final ValueNotifier<bool> confirmPasswordVisible = ValueNotifier<bool>(false);

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthStateRegisterSuccess) {
          // Tampilkan pesan sukses
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Akun Berhasil Dibuat, Silahkan Login.")),
          );
          // Kosongkan semua TextField setelah akun berhasil dibuat
          usernameController.clear();
          emailController.clear();
          passwordController.clear();
          confirmPasswordController.clear();
        } else if (state is AuthStateError) {
          // Tampilkan pesan error
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.errorMessage)),
          );
        }
      },
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.only(top: 60),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Center(
                child: Image.asset(
                  "assets/icons/logo.png",
                  width: MediaQuery.of(context).size.width * 0.60,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 25),
                child: Image.asset(
                  "assets/images/youkoso.png",
                  width: MediaQuery.of(context).size.width * 0.25,
                ),
              ),
              SizedBox(height: 15),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Column(
                  children: [
                    // Username TextField
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.07,
                      child: TextField(
                        controller: usernameController,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          hintText: 'Username',
                          hintStyle: const TextStyle(color: Color(0xFF8A8888)),
                          prefixIcon: Icon(
                            Icons.person,
                            color: Color(0xFF8A8888),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 13),
                    // Email TextField
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.07,
                      child: TextField(
                        controller: emailController,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          hintText: 'Email',
                          hintStyle: const TextStyle(color: Color(0xFF8A8888)),
                          prefixIcon: Icon(
                            Icons.email,
                            color: Color(0xFF8A8888),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 13),
                    // Password TextField
                    ValueListenableBuilder<bool>(
                      valueListenable: passwordVisible,
                      builder: (context, isVisible, child) {
                        return SizedBox(
                          height: MediaQuery.of(context).size.height * 0.07,
                          child: TextField(
                            controller: passwordController,
                            obscureText: !isVisible,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              hintText: 'Password',
                              hintStyle:
                                  const TextStyle(color: Color(0xFF8A8888)),
                              prefixIcon: Icon(
                                Icons.lock,
                                color: Color(0xFF8A8888),
                              ),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  isVisible
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: Color(0xFF8A8888),
                                ),
                                onPressed: () {
                                  passwordVisible.value =
                                      !passwordVisible.value;
                                },
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(color: Colors.grey),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 13),
                    // Confirm Password TextField
                    ValueListenableBuilder<bool>(
                      valueListenable: confirmPasswordVisible,
                      builder: (context, isVisible, child) {
                        return SizedBox(
                          height: MediaQuery.of(context).size.height * 0.07,
                          child: TextField(
                            controller: confirmPasswordController,
                            obscureText: !isVisible,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              hintText: 'Confirm Password',
                              hintStyle:
                                  const TextStyle(color: Color(0xFF8A8888)),
                              prefixIcon: Icon(
                                Icons.lock,
                                color: Color(0xFF8A8888),
                              ),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  isVisible
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: Color(0xFF8A8888),
                                ),
                                onPressed: () {
                                  confirmPasswordVisible.value =
                                      !confirmPasswordVisible.value;
                                },
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(color: Colors.grey),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                    SizedBox(height: 15),
                    // Create Button
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.4,
                      child: ElevatedButton(
                        onPressed: () {
                          if (usernameController.text.isEmpty ||
                              emailController.text.isEmpty ||
                              passwordController.text.isEmpty ||
                              confirmPasswordController.text.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text("Silahkan Lengkapi Data Anda")),
                            );
                            return;
                          }

                          showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (_) => const Center(
                                child: CircularProgressIndicator()),
                          );

                          Future.delayed(const Duration(milliseconds: 250), () {
                            Navigator.pop(context);
                            if (passwordController.text ==
                                confirmPasswordController.text) {
                              context.read<AuthBloc>().add(
                                    AuthEventRegister(
                                      username: usernameController.text,
                                      email: emailController.text,
                                      password: passwordController.text,
                                    ),
                                  );
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text("Passwords Tidak Sesuai")),
                              );
                            }
                          });
                        },
                        child: Text(
                          'Create',
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color.fromARGB(255, 108, 230, 113),
                          padding: EdgeInsets.symmetric(vertical: 7),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(23),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    // Back to Login Page text
                    GestureDetector(
                      onTap: () {
                        showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (_) =>
                              const Center(child: CircularProgressIndicator()),
                        );

                        Future.delayed(const Duration(milliseconds: 250), () {
                          Navigator.pop(context);
                          context.push('/login');
                        });
                      },
                      child: Text(
                        'Back to Login Page',
                        style: TextStyle(
                          color: Colors.blue,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
