import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:login_register/database/detail-item-card.dart';
import 'package:login_register/database/detail-keluhan.dart';
import 'package:login_register/database/item-card-database.dart';

class Database extends StatefulWidget {
  @override
  _DatabaseState createState() => _DatabaseState();
}

class _DatabaseState extends State<Database> {
  final CollectionReference _firestore =
      FirebaseFirestore.instance.collection('Pemakaian');
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // ListView(
        //   children: [
        StreamBuilder<QuerySnapshot>(
          stream: _firestore.orderBy('TANGGAL').snapshots(),
          // ignore: missing_return
          builder: (bsc, snapshot) {
            if (snapshot.hasData) {
              return SingleChildScrollView(
                child: Column(
                  children: snapshot.data.docs.map(
                    (e) {
                      return ItemList(
                        e.data()['NAMA'],
                        e.data()['NIM'],
                        e.data()['LAB'],
                        e.data()['TANGGAL'],
                        gantiLayar: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DetailItem(
                              e.data()['PINJAMAN'],
                              keluhan: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => DetailKeluhan(
                                    e.data()['PERFORMA ALAT'],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ).toList(),
                ),
              );
            } else {
              return Center(
                child: Container(
                  child: CircularProgressIndicator(),
                ),
              );
            }
          },
        )
      ],
    );
    //   ],
    // );
  }
}
