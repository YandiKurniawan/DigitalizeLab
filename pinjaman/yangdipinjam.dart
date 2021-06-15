import 'package:flutter/material.dart';
//import 'package:login_register/pinjaman/alat.dart';
import 'package:intl/intl.dart';

class YangDipinjam extends StatefulWidget {
  final daftarAlat;
  //final Function addAlat;
  final Function addPeminjam;
  YangDipinjam(this.daftarAlat, this.addPeminjam);

  @override
  _YangDipinjamState createState() => _YangDipinjamState();
}

class _YangDipinjamState extends State<YangDipinjam> {
  final nimInput = TextEditingController();
  final namaInput = TextEditingController();
  final lokasiInput = TextEditingController();
  DateTime selectedDate;
  // String valueChoose;

  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2021),
      lastDate: DateTime(2022),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        selectedDate = pickedDate;
      });
    });
  }

  void submitData() {
    if (nimInput.text == null ||
        namaInput.text == null ||
        selectedDate == null ||
        lokasiInput.text == null) {
      return;
    } else {
      widget.addPeminjam(
        nimInput
            .text, //harus pertama karna dalam void add user yg pertama deklarasi adalah string title
        namaInput.text,
        lokasiInput.text,
        selectedDate,
        DateTime.now(),
      );
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.5,
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              padding: EdgeInsets.all(5),
              child: TextField(
                decoration: InputDecoration(
                  labelText: 'NIM',
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.blue[600],
                    ),
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                ),
                keyboardType: TextInputType.number,
                controller: nimInput,
              ),
            ),
            Container(
              padding: EdgeInsets.all(5),
              child: TextField(
                decoration: InputDecoration(
                  labelText: 'Nama',
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.blue[600],
                    ),
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                ),
                controller: namaInput,
              ),
            ),
            Container(
              padding: EdgeInsets.all(5),
              child: TextField(
                decoration: InputDecoration(
                  labelText: 'Laboratorium',
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.blue[600],
                    ),
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                ),
                controller: lokasiInput,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      selectedDate == null
                          ? 'Tanggal Belum Ditentukan'
                          : DateFormat.yMMMd().format(selectedDate),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                  ),
                  TextButton(
                      onPressed: _presentDatePicker,
                      style: TextButton.styleFrom(
                          side: BorderSide(color: Colors.lightBlue)),
                      child: Text(
                        'Tentukan Tanggal',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                            color: Colors.lightBlue),
                      ))
                ],
              ),
            ),
            ElevatedButton(
              onPressed: submitData,
              child: Text('Konfirmasi Informasi Peminjam'),
            )
          ],
        ),
      ),
    );
  }
}
// ListView.builder(
//               itemBuilder: (dtx, index) {
//                 return GestureDetector(
//                   onTap: () {
//                     widget.addAlat(
//                       idAlat[index].id,
//                       idAlat[index].namaAlat,
//                       idAlat[index].lokasi,
//                       idAlat[index].date,
//                     );
//                     Navigator.of(context).pop();
//                   },
//                   child: Card(
//                     elevation: 0,
//                     margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
//                     child: ListTile(
//                       leading: Container(
//                         margin: EdgeInsets.all(8),
//                         decoration: BoxDecoration(
//                           border: Border.all(
//                             color: Colors.black,
//                             width: 2,
//                           ),
//                         ),
//                         child: Padding(
//                           padding: const EdgeInsets.symmetric(
//                               vertical: 8, horizontal: 20),
//                           child: Text('ID : ${idAlat[index].id.toString()}'),
//                         ),
//                       ),
//                       title: Text(idAlat[index].namaAlat),
//                       subtitle: Text(idAlat[index].lokasi),
//                     ),
//                   ),
//                 );
//               },
//               itemCount: idAlat.length,
//             ),