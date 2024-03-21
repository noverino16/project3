import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:project2/model/model_galery.dart';

class PageMovieGallery extends StatefulWidget {
  const PageMovieGallery({Key? key}) : super(key: key);

  @override
  State<PageMovieGallery> createState() => _PageMovieGalleryState();
}

class _PageMovieGalleryState extends State<PageMovieGallery> {
  List<Datum>? _galeryList;

  @override
  void initState() {
    super.initState();
    getGalery(); // Panggil fungsi getGalery di initState
  }

  // Fungsi untuk mengambil data gallery dari API
  Future<void> getGalery() async {
    try {
      final response = await http
          .get(Uri.parse('http://localhost/kesehatan/getGalery.php'));
      if (response.statusCode == 200) {
        setState(() {
          _galeryList = modelGaleryFromJson(response.body).data;
        });
      } else {
        throw Exception('Failed to load gallery');
      }
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.blue,
        title: Text(
          'Gallery',
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: _buildGaleryList(),
    );
  }

  // Widget untuk menampilkan daftar galeri
  Widget _buildGaleryList() {
    if (_galeryList == null) {
      return Center(
        child: CircularProgressIndicator(),
      );
    } else if (_galeryList!.isEmpty) {
      return Center(
        child: Text('No data available'),
      );
    } else {
      return GridView.builder(
        gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemCount: _galeryList!.length,
        itemBuilder: (context, index) {
          Datum data = _galeryList![index];
          return GestureDetector(
            onTap: () {
              // Navigasi ke halaman detail ketika salah satu gambar diklik
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PageDetailMovie(data.nama, data.gambar),
                ),
              );
            },
            child: Padding(
              padding: EdgeInsets.all(8),
              child: GridTile(
                footer: Container(
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(width: 1, color: Colors.black54),
                  ),
                  child: Center(
                    child: Text(
                      '${data.nama}',
                      style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                ),
                child: Image.network(
                  'http://localhost/kesehatan/gambar/${data.gambar}',
                  fit: BoxFit.cover,
                  height: 185,
                  width: 185,
                ),
              ),
            ),
          );
        },
      );
    }
  }
}

class PageDetailMovie extends StatelessWidget {
  final String itemNama, itemGambar;

  const PageDetailMovie(this.itemNama, this.itemGambar, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('${itemNama}'),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: EdgeInsets.all(8),
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                Image.network(
                  'http://localhost/kesehatan/gambar/$itemGambar',
                  fit: BoxFit.cover,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
