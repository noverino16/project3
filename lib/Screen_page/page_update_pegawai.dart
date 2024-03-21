import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:project2/model/model_pegawai.dart';

class PageUpdatePegawai extends StatefulWidget {
  final Datum pegawai;

  const PageUpdatePegawai({required this.pegawai});

  @override
  _PageUpdatePegawaiState createState() => _PageUpdatePegawaiState();
}

class _PageUpdatePegawaiState extends State<PageUpdatePegawai> {
  late TextEditingController _namaController;
  late TextEditingController _noBpController;
  late TextEditingController _noHpController;
  late TextEditingController _emailController;

  @override
  void initState() {
    super.initState();
    _namaController = TextEditingController(text: widget.pegawai.nama);
    _noBpController = TextEditingController(text: widget.pegawai.noBp);
    _noHpController = TextEditingController(text: widget.pegawai.noHp);
    _emailController = TextEditingController(text: widget.pegawai.email);
  }

  @override
  void dispose() {
    _namaController.dispose();
    _noBpController.dispose();
    _noHpController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  Future<void> _updatePegawai() async {
    try {
      if (_namaController.text.isEmpty ||
          _noBpController.text.isEmpty ||
          _noHpController.text.isEmpty ||
          _emailController.text.isEmpty) {
        throw Exception('Please fill in all fields');
      }

      Datum updatedPegawai = Datum(
        id: widget.pegawai.id,
        nama: _namaController.text,
        noBp: _noBpController.text,
        noHp: _noHpController.text,
        email: _emailController.text,
        tanggalInput: widget.pegawai.tanggalInput,
      );

      http.Response response = await http.post(
        Uri.parse("http://localhost/kesehatan/updatePegawai.php"),
        body: {
          'id': updatedPegawai.id,
          'nama': updatedPegawai.nama,
          'no_bp': updatedPegawai.noBp,
          'no_hp': updatedPegawai.noHp,
          'email': updatedPegawai.email,
        },
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> responseData = json.decode(response.body);
        if (responseData['isSuccess'] == true) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Data pegawai berhasil diperbarui'),
            ),
          );
          Navigator.pop(context,
              updatedPegawai); // Kembali ke halaman sebelumnya dengan membawa data pegawai yang telah diperbarui
        } else {
          throw Exception(
              'Failed to update pegawai: ${responseData['message']}');
        }
      } else {
        throw Exception('Failed to update pegawai');
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to update pegawai: $e'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Update Pegawai",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: _namaController,
                decoration: InputDecoration(labelText: 'Nama'),
              ),
              SizedBox(
                height: 10,
              ),
              TextField(
                controller: _noBpController,
                decoration: InputDecoration(labelText: 'NoBp'),
              ),
              SizedBox(
                height: 10,
              ),
              TextField(
                controller: _noHpController,
                decoration: InputDecoration(labelText: 'Nomor Telepon'),
              ),
              SizedBox(
                height: 10,
              ),
              TextField(
                controller: _emailController,
                decoration: InputDecoration(labelText: 'Email'),
              ),
              SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  onPressed: _updatePegawai,
                  child: Text('Update'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
