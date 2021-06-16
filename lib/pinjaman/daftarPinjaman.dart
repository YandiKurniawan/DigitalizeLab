import 'package:flutter/material.dart';
// import 'alat.dart';

// ignore: must_be_immutable
class DaftarPinjaman extends StatelessWidget {
  final daftarAlat;
  Map dbAlat;
  final id;
  DaftarPinjaman({this.daftarAlat, this.dbAlat, this.id});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.8,
      child: daftarAlat.isEmpty
          ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Text(
                    'Belum Melakukan Pinjaman',
                    // dbAlat.toString(),
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                )
              ],
            )
          : ListView.builder(
              itemBuilder: (dtx, index) {
                return Card(
                  margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  elevation: 10,
                  child: ListTile(
                    leading: Container(
                      margin: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.black,
                          width: 2,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 20),
                        child: Text('ID : ${daftarAlat[index].id.toString()}'),
                      ),
                    ),
                    title: Text(daftarAlat[index].namaAlat),
                    subtitle: Text(daftarAlat[index].lokasi),
                  ),
                );
              },
              itemCount: daftarAlat.length,
            ),
    );
  }
}
