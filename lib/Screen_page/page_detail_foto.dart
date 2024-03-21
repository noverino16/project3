import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:project2/model/model_Galery.dart';

class PageDetailGalery extends StatelessWidget {
  //konstruktor penampung data
  final Datum? data;
  const PageDetailGalery(this.data, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(
          data!.nama,
        ),
      ),
      body: ListView(
        children: [
          Padding(
            padding: EdgeInsets.all(10),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                'http://localhost/kesehatan/gambar/${data?.gambar}',
                fit: BoxFit.fill,
              ),
            ),
          ),
          ListTile(
            title: Text(
              data?.nama ?? "",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
            ),
          ),
        ],
      ),
    );
  }
}
