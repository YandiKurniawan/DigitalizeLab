// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
//import 'package:login_register/pinjaman/pinjaman.dart';
// import 'package:login_register/pinjaman/alat.dart';

// ignore: must_be_immutable
class DetailItem extends StatelessWidget {
  Map pinjaman;
  Function keluhan;

  DetailItem(this.pinjaman, {this.keluhan});
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
      body: Column(
        children: [
          Container(
              width: double.infinity,
              height: 600,
              child: pinjaman.isEmpty
                  ? Center(
                      child: Text('tidak melakukan pinjaman'),
                    )
                  : ListView.builder(
                      itemCount: pinjaman.length,
                      itemBuilder: (btx, index) {
                        String key = pinjaman.keys.elementAt(index);
                        return Column(
                          children: [
                            ListTile(
                              leading: Text('ID : $key'),
                              title: Text(
                                '${pinjaman[key]['NAMA ALAT']}',
                              ),
                              subtitle: Text(
                                '${pinjaman[key]['LAB']} / ${pinjaman[key]['TANGGAL']}',
                              ),
                            ),
                          ],
                        );
                      },
                    )),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: keluhan,
        label: Text('Keluhan'),
        icon: Icon(Icons.feedback),
        backgroundColor: Colors.blue[900],
      ),
    );
  }
}
