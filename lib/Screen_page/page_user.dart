import 'package:flutter/material.dart';
import 'package:project2/Screen_page/login_screen.dart';
import 'package:project2/Screen_page/page_edit_user.dart';
import 'package:project2/utils/cek_session.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilScreen extends StatefulWidget {
  const ProfilScreen({Key? key}) : super(key: key);

  @override
  State<ProfilScreen> createState() => _ProfilScreenState();
}

class _ProfilScreenState extends State<ProfilScreen> {
  String? id, username, email;

  @override
  void initState() {
    super.initState();
    getSession();
  }

  @override
  void didUpdateWidget(ProfilScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    getSession();
  }

  Future<void> getSession() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      id = pref.getString("id");
      username = pref.getString("username");
      email = pref.getString("email");
      print(id);
      print(username);
      print(email);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        centerTitle: true,
        title: Text(
          "User Profile",
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
              ),
              CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage(
                    'images/book.png'), // Ganti dengan gambar avatar pengguna
              ),
              SizedBox(height: 20),
              Text(
                '$username', //$username
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              Text(
                '$email',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  final newUsername = await Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PageEditProfile()));
                  if (newUsername != null) {
                    // Data berhasil diupdate, perbarui data profil
                    session.updateUsername(newUsername);
                    getSession(); // Perbarui data profil di halaman ProfilScreen
                  }
                },
                style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                child: Text(
                  'Edit Profile',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    session.clearSession();
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => LoginScreen()),
                        (route) => false);
                  });
                },
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                child: Text(
                  'Logout',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
