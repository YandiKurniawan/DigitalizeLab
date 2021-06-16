import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ItemList extends StatelessWidget {
  String name;
  String nim;
  String tanggal;
  String lab;
  Function gantiLayar;

  ItemList(this.name, this.nim, this.lab, this.tanggal, {this.gantiLayar});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: gantiLayar,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        color: Colors.black,
        elevation: 5,
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: ListTile(
          leading: Container(
            margin: EdgeInsets.all(8),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Colors.blue[900]),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
              child: Text(
                tanggal,
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          title: Text(
            '$name\n$nim',
            style: TextStyle(color: Colors.white),
          ),
          subtitle: Text(
            'Laboratorium : $lab',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
// Border.all(
//                 color: Colors.black,
//                 width: 2,
//               ),
