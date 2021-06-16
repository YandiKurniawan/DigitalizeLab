import 'package:permission_handler/permission_handler.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:login_register/pinjaman/daftarPinjaman.dart';
import 'package:login_register/pinjaman/pengembalian.dart';
import 'package:login_register/pinjaman/yangdipinjam.dart';
import 'alat.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:qrscan/qrscan.dart' as scanner;
import 'package:firebase_database/firebase_database.dart';

// ignore: must_be_immutable
class Pinjaman extends StatefulWidget {
  String passdb;
  Pinjaman({this.passdb});
  @override
  _PinjamanState createState() => _PinjamanState();
}

class _PinjamanState extends State<Pinjaman> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String nama;
  String dute;
  String qr;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  String tes;
  final dbRef = FirebaseDatabase.instance.reference();

  void initState() {
    getNama();
    super.initState();
  }

////future get nama untuk memasukan variabel nama ke database lokal
  ///void alat untuk menambahkan alat ke database
  ///void add peminjam untuk memasukan data peminjam ke database
  ///void sheet pinjaman untuk membuka sheet ke page yang dipinjam (data diri)
  ///void scan QR alat untuk melakukan scanning pada QR
  ///void show password dialog untuk membuka dialog ketika berhasil melakukan scan password
  ///void pass benar untuk mendireksi pintu atau lemari mana yang akan dibuka
  ///void show dialog salah untuk membuka dialog ketika qr tidak sesuai
  ///void pengembalian alat untuk memasukan data evaluasi ke database
  ///void sheet pengembalian untuk membuat sheet data evaluasi

  Future<String> getNama() async {
    final prefs = await SharedPreferences.getInstance();
    nama = prefs.getString('nama') ?? ('tidak ada nama');
    return nama;
  }

  void addAlat(
      String txId, String txAlat, String txLokasi, DateTime txDate) async {
    final newTx = DaftarAlat(
      id: txId,
      namaAlat: txAlat,
      lokasi: txLokasi,
    );
    dbRef
        .child('Status')
        .child('Analog')
        .update({'Kegiatan': 'Menggunakan Alat'});
    DocumentReference docPemakaian =
        firestore.collection("Pemakaian").doc('$nama');
    docPemakaian.update(
      {
        'PINJAMAN.$txId': {
          'ID': txId,
          'NAMA ALAT': txAlat,
          'LAB': txLokasi,
          'TANGGAL': DateFormat.yMMMd().format(txDate),
        }
      },
    );
    setState(() {
      alat.add(newTx);
    });
  }

  void addPeminjam(String dxNim, String dxNama, String dxLokasi,
      DateTime dxDate, DateTime idDate) async {
    final newDx = Peminjam(
      nim: dxNim,
      namaSiswa: dxNama,
      date: dxDate,
      lokasi: dxLokasi,
    );
    nama = dxNama;
    dute = idDate.toString();
    DocumentReference docPemakaian =
        firestore.collection("Pemakaian").doc('$nama $dute');
    docPemakaian.set(
      {
        //'PEMINJAM': {
        'NIM': dxNim,
        'NAMA': dxNama,
        'LAB': dxLokasi,
        'TANGGAL': DateFormat.yMMMd().format(dxDate),
        // },
        'PERFORMA ALAT': {},
        'PINJAMAN': {},
      },
    );
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('nama', '$nama $dute');
    nama = prefs.getString('nama') ?? ('tidak ada nama');
    setState(() {
      idPeminjam.add(newDx);
    });
  }

  void sheetPinjaman(BuildContext bsc) {
    showModalBottomSheet(
      context: bsc,
      builder: (btsc) {
        return FractionallySizedBox(
          child: ListView(
            children: [YangDipinjam(alat, addPeminjam)],
          ),
        );
      },
    );
  }

  void scanQRAlat() async {
    await Permission.camera.request();
    qr = await scanner.scan();
    if (idPeminjam.isEmpty) {
      if (qr == 'ppa' ||
          qr == 'pla' ||
          qr == 'ppd' ||
          qr == 'pld' ||
          qr == 'selesai') {
        await showPasswordDialog(context, qr);
      } else {
        return await showDialogSalah(context);
      }
    } else {
      if (qr == 'ppa' || qr == 'pla' || qr == 'ppd' || qr == 'pld') {
        await showPasswordDialog(context, qr);
      } else {
        firestore.collection('DbAlat').doc(qr).get().then(
          (DocumentSnapshot doc) {
            if (doc.exists == true) {
              addAlat(
                doc.id,
                doc.data()['Nama Alat'],
                doc.data()['Lokasi'],
                DateTime.now(),
              );
            } else {
              return showDialogSalah(context);
            }
            print(
              doc.data(),
            );
          },
        );
      }
    }
    setState(() {});
  }

  Future<void> showPasswordDialog(BuildContext context, String qr) async {
    DocumentSnapshot passdb =
        await firestore.collection('Password').doc('Password').get();
    return await showDialog(
      context: context,
      builder: (context) {
        final TextEditingController pass = TextEditingController();
        return AlertDialog(
          content: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: pass,
                  validator: (value) {
                    if (value != passdb['Password']) {
                      return 'Password Salah';
                    } else {
                      return null;
                    }
                  },
                  decoration: InputDecoration(hintText: 'Masukan Password'),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                if (_formKey.currentState.validate()) {
                  passBenar(qr);
                  Navigator.of(context).pop();
                }
              },
              child: Text('Konfirmasi'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Kembali'),
            )
          ],
        );
      },
    );
  }

  Future<void> passBenar(String qr) async {
    switch (qr) {
      case 'ppa':
        dbRef
            .child('Status')
            .child('Analog')
            .update({'Kegiatan': 'Mengakses Pintu'});
        dbRef.child('Status').child('Analog').update({'Peminjam': nama});
        return dbRef
            .child('Status')
            .child('Analog')
            .update({'logicPintu': '1'});
      case 'pla':
        dbRef
            .child('Status')
            .child('Analog')
            .update({'Kegiatan': 'Mengakses Lemari Alat'});
        return dbRef
            .child('Status')
            .child('Analog')
            .update({'logicLemari': '1'});
      case 'ppd':
        dbRef
            .child('Status')
            .child('Digital')
            .update({'Kegiatan': 'Mengakses Pintu'});
        dbRef.child('Status').child('Digital').update({'Peminjam': nama});
        return dbRef
            .child('Status')
            .child('Digital')
            .update({'logicPintu': '1'});
      case 'pld':
        dbRef
            .child('Status')
            .child('Analog')
            .update({'Kegiatan': 'Mengakses Lemari Alat'});
        return dbRef
            .child('Status')
            .child('Digital')
            .update({'logicLemari': '1'});
      case 'selesai':
        dbRef.child('Status').child('Analog').update({'Kegiatan': 'Tidak Ada'});
        dbRef.child('Status').child('Analog').update({'Peminjam': 'Tidak Ada'});
        dbRef
            .child('Status')
            .child('Digital')
            .update({'Kegiatan': 'Tidak Ada'});
        dbRef
            .child('Status')
            .child('Digital')
            .update({'Peminjam': 'Tidak Ada'});
    }
  }

  Future<void> showDialogSalah(BuildContext context) async {
    return await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Text('Terjadi Kesalahan Dalam Pemindaian'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Kembali'),
            )
          ],
        );
      },
    );
  }

  void pengembalianAlat(
      String keluhanAlat, String identitasAlat, String lokasiAlat) async {
    final newTx = EvaluasiAlat(
      keluhanAlat: keluhanAlat,
      identitasAlat: identitasAlat,
      lokasiAlat: lokasiAlat,
    );
    dbRef
        .child('Status')
        .child('Analog')
        .update({'Kegiatan': 'Sudah Mengembalikan Alat'});
    DocumentReference docPemakaian =
        firestore.collection("Pemakaian").doc('$nama');
    docPemakaian.update(
      {
        'PERFORMA ALAT': {
          'PERFORMA ALAT': keluhanAlat,
          'NAMA ALAT': identitasAlat,
          'LOKASI ALAT': lokasiAlat,
        }
      },
    );
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('nama');
    setState(() {
      evaluasiAlat.add(newTx);
      idPeminjam.clear();
      alat.clear();
    });
  }

  void sheetPengembalian(BuildContext bsc) {
    showModalBottomSheet(
      context: bsc,
      builder: (btsc) {
        return FractionallySizedBox(
          child: ListView(
            children: [Pengembalian(pengembalianAlat)],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DaftarPinjaman(daftarAlat: alat),
      floatingActionButton: idPeminjam.isEmpty
          ? SpeedDial(
              animatedIcon: AnimatedIcons.menu_close,
              animatedIconTheme: IconThemeData.fallback(),
              shape: CircleBorder(),
              children: [
                SpeedDialChild(
                  child: Icon(Icons.bookmark_border),
                  backgroundColor: Colors.blue[600],
                  onTap: () => idPeminjam.isEmpty
                      ? sheetPinjaman(context)
                      : scanQRAlat(),
                  label: idPeminjam.isEmpty ? 'Meminjam' : 'Pindai QR',
                ),
                SpeedDialChild(
                  child: Icon(Icons.qr_code),
                  backgroundColor: Colors.blue[600],
                  onTap: () => scanQRAlat(),
                  label: 'Pindai QR', //'Pindai QR',
                ),
              ],
            )
          : SpeedDial(
              animatedIcon: AnimatedIcons.menu_close,
              animatedIconTheme: IconThemeData.fallback(),
              shape: CircleBorder(),
              children: [
                SpeedDialChild(
                  child: Icon(Icons.qr_code),
                  backgroundColor: Colors.blue[600],
                  onTap: () => idPeminjam.isEmpty
                      ? sheetPinjaman(context)
                      : scanQRAlat(),
                  label: idPeminjam.isEmpty ? 'Meminjam' : 'Pindai QR Alat',
                ),
                SpeedDialChild(
                  child: Icon(Icons.archive),
                  backgroundColor: Colors.blue[600],
                  onTap: () => sheetPengembalian(context),
                  label: 'Kembalikan Pinjaman',
                ),
              ],
            ),
    );
  }
}
