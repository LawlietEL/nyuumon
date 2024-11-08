import 'package:flutter/material.dart';

class EditProfilePage extends StatelessWidget {
  const EditProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header dengan tombol back dan judul
            Padding(
              padding: const EdgeInsets.only(
                  top: 30,
                  left: 5,
                  bottom: 5,
                  right: 10), // Padding di sekitar teks
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () {
                      Navigator.pop(context); // Kembali ke halaman sebelumnya
                    },
                  ),
                  Expanded(
                    child: Align(
                      alignment: Alignment.center,
                      child: const Text(
                        'Edit Your Profile',
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
            // Garis horizontal tipis berwarna abu-abu
            const Divider(
              color: Colors.grey,
              thickness: 1,
            ),
            // Wadah untuk gambar
            Padding(
              padding: const EdgeInsets.only(top: 15),
              child: Image.asset(
                'assets/images/edit_profile.png', // Ganti path dengan path gambar yang sesuai
                width: MediaQuery.of(context).size.width * 0.25,
              ),
            ),
            // Tulisan Edit Profile
            const Padding(
              padding: EdgeInsets.only(top: 20, bottom: 5),
              child: Text(
                'Edit Profile',
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            ),
            // Kolom isian pertama (Nama)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
              child: TextField(
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.person),
                  labelText: 'Name',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
            // Kolom isian kedua (Email)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
              child: TextField(
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.email),
                  labelText: 'Email',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
            // Tombol Edit dan Cancel
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Tombol Edit
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        // Logika untuk edit
                        print("Button edit ditekan");
                      },
                      child: Container(
                        height: 45,
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius:
                              BorderRadius.circular(20), // Circular 10
                        ),
                        child: Center(
                          child: const Text(
                            'Edit',
                            style: TextStyle(color: Colors.white),
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
                        child: Center(
                          child: const Text(
                            'Cancel',
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                      ),
                    ),
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
