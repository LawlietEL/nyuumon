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
            SnackBar(content: Text("Account created successfully!")),
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
              SizedBox(height: 15), // Padding between image and input fields
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
                    SizedBox(height: 15), // Space between fields and button
                    // Create Button
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.4,
                      child: ElevatedButton(
                        onPressed: () {
                          if (passwordController.text ==
                              confirmPasswordController.text) {
                            // Kirim event AuthEventRegister ke AuthBloc
                            context.read<AuthBloc>().add(
                                  AuthEventRegister(
                                    username: usernameController.text,
                                    email: emailController.text,
                                    password: passwordController.text,
                                  ),
                                );
                          } else {
                            // Tampilkan error jika password tidak cocok
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text("Passwords do not match")),
                            );
                          }
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
                        context.push('/create_account/back_to_login');
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
