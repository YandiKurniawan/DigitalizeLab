import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';

class Pengembalian extends StatefulWidget {
  final Function evaluasi;
  Pengembalian(this.evaluasi);

  @override
  _PengembalianState createState() => _PengembalianState();
}

class _PengembalianState extends State<Pengembalian> {
  final keluhanInput = TextEditingController();
  final identitasAlatInput = TextEditingController();
  final lokasiAlatInput = TextEditingController();

  void submitEvaluasi() {
    if (keluhanInput.text == '' ||
        identitasAlatInput.text == '' ||
        lokasiAlatInput.text == '') {
      widget.evaluasi(
        'tidakpinjam',
        'tidakpinjam',
        'tidakpinjam',
      );
    } else {
      widget.evaluasi(
        keluhanInput
            .text, //harus pertama karna dalam void add user yg pertama deklarasi adalah string title
        identitasAlatInput.text,
        lokasiAlatInput.text,
      );
    }
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
            padding: EdgeInsets.all(5),
            child: TextField(
              decoration: InputDecoration(
                labelText: 'Evaluasi Performa Alat',
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.blue[600],
                  ),
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
              ),
              controller: keluhanInput,
            ),
          ),
          Container(
            padding: EdgeInsets.all(5),
            child: TextField(
              decoration: InputDecoration(
                labelText: 'Identitas Alat',
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.blue[600],
                  ),
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
              ),
              controller: identitasAlatInput,
            ),
          ),
          Container(
            padding: EdgeInsets.all(5),
            child: TextField(
              decoration: InputDecoration(
                labelText: 'Letak Laboratorium',
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.blue[600],
                  ),
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
              ),
              controller: lokasiAlatInput,
            ),
          ),
          ElevatedButton(
            onPressed: submitEvaluasi,
            child: Text('Konfirmasi Evaluasi'),
          )
        ],
      ),
    );
  }
}
