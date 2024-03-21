import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Import package untuk format tanggal
import 'package:project2/model/model_pegawai.dart';

class PageDetailPegawai extends StatelessWidget {
  final Datum? data;

  const PageDetailPegawai(this.data);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            "Detail Pegawai",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Container( // Lebar container 80% dari lebar layar
          padding: EdgeInsets.all(20.0),
          decoration: BoxDecoration(
            color: Colors.white, // Warna latar belakang container
            borderRadius:
                BorderRadius.circular(15.0), // Sudut container dibulatkan
          ),
          child: ListView(
            children: [
              ListTile(
                title: Text(
                  "Nama: ${data?.nama ?? ""}",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                subtitle: Text(
                  "NoBp: ${data?.noBp ?? ""}",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ),
              ListTile(
                title: Text(
                  "Nomor Telepon: ${data?.noHp ?? ""}",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                subtitle: Text(
                  "Email: ${data?.email ?? ""}",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ),
              ListTile(
                title: Text(
                  "Tanggal Input: ${DateFormat('dd/MM/yyyy').format(data?.tanggalInput ?? DateTime.now())}",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}