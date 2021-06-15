import 'package:flutter/material.dart';

// ignore: must_be_immutable
class DetailKeluhan extends StatelessWidget {
  Map performaAlat;
  DetailKeluhan(this.performaAlat);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Container(
        child: performaAlat.containsValue('tidakpinjam')
            ? Center(
                child: Text('Tidak Melakukan Pinjaman'),
              )
            : ListTile(
                leading: Text('ID : ${performaAlat['NAMA ALAT']}'),
                title: Text('Performa :  ${performaAlat['PERFORMA ALAT']}'),
                subtitle: Text('Lokasi Alat : ${performaAlat['LOKASI ALAT']}'),
              ),
      ),
    );
  }
}
