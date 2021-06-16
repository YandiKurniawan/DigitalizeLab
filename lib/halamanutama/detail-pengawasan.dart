import 'package:flutter/material.dart';

// ignore: must_be_immutable
class DetailPengawasan extends StatefulWidget {
  Map statusLab;
  DetailPengawasan(this.statusLab);

  @override
  _DetailPengawasanState createState() => _DetailPengawasanState();
}

class _DetailPengawasanState extends State<DetailPengawasan> {
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        itemCount: widget.statusLab.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 1, childAspectRatio: 1.18),
        itemBuilder: (context, index) {
          String key = widget.statusLab.keys.elementAt(index);
          return Container(
            height: 124.0,
            margin: EdgeInsets.all(10),
            decoration: new BoxDecoration(
              color: new Color(0xFF333366),
              shape: BoxShape.rectangle,
              borderRadius: new BorderRadius.circular(8.0),
              boxShadow: <BoxShadow>[
                new BoxShadow(
                  color: Colors.black12,
                  blurRadius: 10.0,
                  offset: new Offset(0.0, 10.0),
                ),
              ],
            ),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(
                        top: 10, bottom: 50, left: 10, right: 10),
                    child: Text(
                      'Laboratorium $key',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 50, bottom: 50),
                    child: Text(
                      'Kegiatan : ${widget.statusLab[key]['Kegiatan']}',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 50, bottom: 50),
                    child: Text(
                      'Peminjam : ${widget.statusLab[key]['Peminjam']}',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
