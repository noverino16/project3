import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:project2/Screen_page/page_detail_berita.dart';
import 'package:project2/model/model_berita.dart';
import 'package:project2/Screen_page/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PageListBerita extends StatefulWidget {
  const PageListBerita({Key? key}) : super(key: key);

  @override
  State<PageListBerita> createState() => _PageListBeritaState();
}

class _PageListBeritaState extends State<PageListBerita> {
  String? id, username;
  List<Datum>? _beritaList;
  List<Datum>? _searchResult;

  @override
  void initState() {
    super.initState();
    getBerita(); 
  }

  // Fungsi untuk mengambil data berita dari API
  Future<void> getBerita() async {
    try {
      final response = await http
          .get(Uri.parse('http://localhost/kesehatan/getBerita.php'));
      if (response.statusCode == 200) {
        setState(() {
          _beritaList = modelBeritaFromJson(response.body).data;
        });
      } else {
        throw Exception('Failed to load kamus');
      }
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  // Fungsi untuk mencari berita berdasarkan judul
  void _searchBerita(String query) {
    if (query.isEmpty) {
      setState(() {
        _searchResult = null;
      });
      return;
    }

    setState(() {
      _searchResult = _beritaList
          ?.where((berita) =>
              berita.judul.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'List Berita',
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.blue,
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(0.10),
            child: TextField(
              onChanged: _searchBerita,
              decoration: InputDecoration(
                labelText: 'Search Keyword',
                border: OutlineInputBorder(),
                fillColor: Colors.white,
                filled: true,
              ),
            ),
          ),
          Expanded(
            child:
                _buildBeritaList(), // Memanggil fungsi untuk membangun daftar berita
          ),
        ],
      ),
    );
  }

  // Widget untuk membangun daftar berita
  Widget _buildBeritaList() {
    List<Datum>? beritaList = _searchResult ??
        _beritaList; // Gunakan _searchResult jika tidak null, jika tidak gunakan _beritaList

    // Jika daftar berita kosong, tampilkan pesan
    if (beritaList == null || beritaList.isEmpty) {
      return Center(
        child: Text('No data available'),
      );
    }

    // Jika ada data, tampilkan daftar berita
    return ListView.builder(
      itemCount: beritaList.length,
      itemBuilder: (context, index) {
        Datum data = beritaList[index];
        return Padding(
          padding: EdgeInsets.all(10),
          child: GestureDetector(
            onTap: () {
              // Ketika item diklik, pindah ke halaman detail
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => PageDetailBerita(data)));
            },
            child: Card(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                        'http://localhost/kesehatan/gambar_berita/${data.gambarBerita}',
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  ListTile(
                    title: Text(
                      '${data.judul}',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.orange,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      '${data.isiBerita}',
                      maxLines: 2,
                      style: TextStyle(color: Colors.black54, fontSize: 12),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
