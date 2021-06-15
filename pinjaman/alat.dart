import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

class DaftarAlat {
  String id;
  String namaAlat;
  String lokasi;
  //DateTime date;

  DaftarAlat({
    @required this.id,
    @required this.namaAlat,
    //@required this.date,
    @required this.lokasi,
  });
}

List<DaftarAlat> alat = [];

class Peminjam {
  String nim;
  String namaSiswa;
  String lokasi;
  DateTime date;

  Peminjam({
    @required this.nim,
    @required this.namaSiswa,
    @required this.date,
    @required this.lokasi,
  });
}

List<Peminjam> idPeminjam = [];

class EvaluasiAlat {
  String keluhanAlat;
  String identitasAlat;
  String lokasiAlat;

  EvaluasiAlat({
    @required this.keluhanAlat,
    @required this.identitasAlat,
    @required this.lokasiAlat,
  });
}

List<EvaluasiAlat> evaluasiAlat = [];

class Baser {
  String namefirestore;
  String labfirestore;
  String idfirestore;
  String tanggalfirestore;

  Baser(this.namefirestore, this.labfirestore, this.idfirestore,
      this.tanggalfirestore);

  String toString() {
    return '''${this.namefirestore}, ${this.labfirestore}, ${this.idfirestore},
      ${this.tanggalfirestore}''';
  }
}

var userList = [];
