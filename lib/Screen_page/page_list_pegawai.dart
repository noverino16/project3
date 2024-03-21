import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:project2/Screen_page/page_detail_pegawai.dart';
import 'package:project2/Screen_page/page_insert_pegawai.dart';
import 'package:project2/Screen_page/page_update_pegawai.dart';
import 'package:project2/Screen_page/page_user.dart';
import 'package:project2/main.dart';
import 'package:project2/model/model_pegawai.dart';

class PageListPegawai extends StatefulWidget {
  const PageListPegawai({super.key});

  @override
  State<PageListPegawai> createState() => _PageListPegawaiState();
}

class _PageListPegawaiState extends State<PageListPegawai> {
  String? id, username;
  late Future<List<Datum>?> _futurePegawai;
  late List<Datum> _pegawaiData = [];
  late List<Datum> _searchResult = [];
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _futurePegawai = getPegawai();
    _futurePegawai.then((value) {
      if (value != null) {
        setState(() {
          _pegawaiData = value;
        });
      }
    });
  }

  Future<List<Datum>?> getPegawai() async {
    try {
      http.Response res = await http
          .get(Uri.parse("http://localhost/kesehatan/getPegawai.php"));
      return modelPegawaiFromJson(res.body).data;
    } catch (e) {
      setState(() {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(e.toString())));
      });
    }
    return null;
  }

  void _filterSearchResults(String query) {
    List<Datum> searchResults = [];
    if (query.isNotEmpty) {
      _pegawaiData.forEach((datum) {
        if (datum.nama.toLowerCase().contains(query.toLowerCase())) {
          searchResults.add(datum);
        }
      });
    }
    setState(() {
      _searchResult = searchResults;
    });
  }

  void _navigateToDetail(Datum data) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PageDetailPegawai(data),
      ),
    );
  }

  void _navigateToInsertPegawai() async {
    Datum? newPegawai = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => InsertPegawai()),
    );

    if (newPegawai != null) {
      setState(() {
        _pegawaiData.add(newPegawai);
      });

      // Setelah menyelesaikan operasi insertPegawai, navigasi ke PageListPegawai
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => MyHomePage()),
      );
    }
  }

  void _confirmDeletePegawai(String id) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Konfirmasi'),
        content: Text('Apakah Anda yakin ingin menghapus pegawai ini?'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Tutup dialog konfirmasi
            },
            child: Text('Batal'),
          ),
          TextButton(
            onPressed: () {
              // Panggil fungsi untuk menghapus pegawai berdasarkan id
              _deletePegawai(id);
              Navigator.of(context).pop(); // Tutup dialog konfirmasi
            },
            child: Text('Hapus'),
          ),
        ],
      ),
    );
  }

  Future<void> _deletePegawai(String id) async {
    try {
      // Kirim permintaan HTTP untuk menghapus pegawai berdasarkan id
      http.Response response = await http.post(
        Uri.parse("http://localhost/kesehatan/deletePegawai.php"),
        body: {
          'id': id,
        },
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> responseData = json.decode(response.body);
        if (responseData['isSuccess'] == true) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Data pegawai berhasil dihapus'),
            ),
          );

          // Perbarui tampilan dengan menghapus pegawai dari daftar
          setState(() {
            _pegawaiData.removeWhere((pegawai) => pegawai.id == id);
          });
        } else {
          throw Exception(
              'Gagal menghapus pegawai: ${responseData['message']}');
        }
      } else {
        throw Exception('Gagal menghapus pegawai');
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Gagal menghapus pegawai: $e'),
        ),
      );
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        centerTitle: true,
        title: Text(
          "List Pegawai",
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 10),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: 500,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(0.10),
                  child: TextField(
                    controller: _searchController,
                    onChanged: (value) {
                      _filterSearchResults(value);
                    },
                    decoration: InputDecoration(
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 10),
          Expanded(
            child: FutureBuilder(
              future: _futurePegawai,
              builder:
                  (BuildContext context, AsyncSnapshot<List<Datum>?> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(color: Colors.white),
                  );
                } else if (snapshot.hasData) {
                  return ListView.builder(
                    itemCount: _searchResult.isNotEmpty
                        ? _searchResult.length
                        : _pegawaiData.length,
                    itemBuilder: (context, index) {
                      Datum data = _searchResult.isNotEmpty
                          ? _searchResult[index]
                          : _pegawaiData[index];
                      return Padding(
                        padding: EdgeInsets.all(10),
                        child: GestureDetector(
                          onTap: () {
                            _navigateToDetail(data);
                          },
                          child: Card(
                            color: Colors.white,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ListTile(
                                  title: Text(
                                    "${data.nama}",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.blue,
                                    ),
                                  ),
                                  subtitle: Text(
                                    '${data.noBp}',
                                    maxLines: 2,
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey.shade900,
                                    ),
                                  ),
                                  trailing: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      IconButton(
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  PageUpdatePegawai(
                                                      pegawai: data),
                                            ),
                                          ).then((updatedPegawai) {
                                            if (updatedPegawai != null) {
                                              // Jika data pegawai berhasil diperbarui, Anda dapat melakukan pembaruan di sini
                                              setState(() {
                                                // Misalnya, perbarui daftar pegawai dengan data yang diperbarui
                                                _pegawaiData[_pegawaiData
                                                        .indexOf(data)] =
                                                    updatedPegawai;
                                              });
                                            }
                                          });
                                        },
                                        icon: Icon(
                                          Icons.edit,
                                          color: Colors.blue,
                                        ),
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          _confirmDeletePegawai(data.id);
                                        },
                                        icon: Icon(
                                          Icons.delete,
                                          color: Colors.red,
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
                    },
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text(snapshot.error.toString()),
                  );
                } else {
                  return const Center(
                    child: CircularProgressIndicator(color: Colors.green),
                  );
                }
              },
            ),
          ),
        ],
      ),
      floatingActionButton: Container(
        width: 40, // Atur lebar container sesuai kebutuhan
        height: 40, // Atur tinggi container sesuai kebutuhan
        decoration: BoxDecoration(
          shape: BoxShape.circle, // Mengatur bentuk container menjadi lingkaran
          color: Colors.green.shade200, // Warna latar belakang container
        ),
        child: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => InsertPegawai()),
            );
          },
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}
