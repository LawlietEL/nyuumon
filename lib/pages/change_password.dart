import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nyuumon/bloc/auth/auth_bloc.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  _ChangePasswordState createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  final TextEditingController recentPasswordController =
      TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  bool isRecentPasswordVisible = false;
  bool isNewPasswordVisible = false;
  bool isConfirmPasswordVisible = false;

  void _handleChangePassword(BuildContext context) {
    final recentPassword = recentPasswordController.text.trim();
    final newPassword = newPasswordController.text.trim();
    final confirmPassword = confirmPasswordController.text.trim();

    if (recentPassword.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please fill in Recent Password")),
      );
      return;
    } else if (newPassword.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please fill in New Password")),
      );
      return;
    } else if (confirmPassword.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please fill in Confirm New Password")),
      );
      return;
    }

    if (newPassword == recentPassword) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content:
                Text("New password and recent password must not be the same")),
      );
      return;
    }

    if (newPassword != confirmPassword) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("New passwords do not match")),
      );
      return;
    }

    context.read<AuthBloc>().add(ChangePasswordEvent(
          recentPassword: recentPassword,
          newPassword: newPassword,
        ));
  }

  void _clearTextFields() {
    recentPasswordController.clear();
    newPasswordController.clear();
    confirmPasswordController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthPasswordChanged) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Password changed successfully")),
            );
            _clearTextFields();
          } else if (state is AuthChangePasswordError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.errorMessage)),
            );
          }
        },
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  top: 30,
                  left: 5,
                  bottom: 5,
                  right: 10,
                ),
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    const Expanded(
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          'Change Your Password',
                          style: TextStyle(
                            fontSize: 23,
                          ),
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
                padding: const EdgeInsets.only(top: 15),
                child: Center(
                  child: Image.asset(
                    "assets/images/change_password.png",
                    width: MediaQuery.of(context).size.width * 0.32,
                  ),
                ),
              ),
              // Tulisan Edit Profile
              const Padding(
                padding: EdgeInsets.only(top: 10, bottom: 10),
                child: Text(
                  'Change Password',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),

              // Kolom isian Recent Password
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                child: TextField(
                  controller: recentPasswordController,
                  obscureText: !isRecentPasswordVisible,
                  decoration: InputDecoration(
                    hintText: 'Recent Password',
                    hintStyle: const TextStyle(color: Color(0xFF8A8888)),
                    prefixIcon: const Icon(Icons.lock_outline,
                        color: Color(0xFF8A8888)),
                    suffixIcon: IconButton(
                      icon: Icon(
                        isRecentPasswordVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: const Color(0xFF8A8888),
                      ),
                      onPressed: () {
                        setState(() {
                          isRecentPasswordVisible = !isRecentPasswordVisible;
                        });
                      },
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10), // Circular 10
                    ),
                  ),
                ),
              ),

              // Kolom isian New Password
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                child: TextField(
                  controller: newPasswordController,
                  obscureText: !isNewPasswordVisible,
                  decoration: InputDecoration(
                    hintText: 'New Password',
                    hintStyle: const TextStyle(color: Color(0xFF8A8888)),
                    prefixIcon:
                        const Icon(Icons.lock, color: Color(0xFF8A8888)),
                    suffixIcon: IconButton(
                      icon: Icon(
                        isNewPasswordVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: const Color(0xFF8A8888),
                      ),
                      onPressed: () {
                        setState(() {
                          isNewPasswordVisible = !isNewPasswordVisible;
                        });
                      },
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10), // Circular 10
                    ),
                  ),
                ),
              ),

              // Kolom isian Confirm New Password
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                child: TextField(
                  controller: confirmPasswordController,
                  obscureText: !isConfirmPasswordVisible,
                  decoration: InputDecoration(
                    hintText: 'Confirm New Password',
                    hintStyle: const TextStyle(color: Color(0xFF8A8888)),
                    prefixIcon:
                        const Icon(Icons.lock, color: Color(0xFF8A8888)),
                    suffixIcon: IconButton(
                      icon: Icon(
                        isConfirmPasswordVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: const Color(0xFF8A8888),
                      ),
                      onPressed: () {
                        setState(() {
                          isConfirmPasswordVisible = !isConfirmPasswordVisible;
                        });
                      },
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10), // Circular 10
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 35),

              // Tombol Change dan Cancel
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    // Tombol Change
                    Expanded(
                      child: GestureDetector(
                        onTap: () => _handleChangePassword(context),
                        child: Container(
                          height: 45,
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius:
                                BorderRadius.circular(20), // Circular 10
                          ),
                          child: const Center(
                            child: Text(
                              'Change',
                              style:
                                  TextStyle(fontSize: 18, color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    // Tombol Cancel
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pop(context); // Kembali ke halaman profil
                        },
                        child: Container(
                          height: 45,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: Colors.grey),
                            borderRadius:
                                BorderRadius.circular(20), // Circular 10
                          ),
                          child: const Center(
                            child: Text(
                              'Cancel',
                              style:
                                  TextStyle(fontSize: 18, color: Colors.black),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
