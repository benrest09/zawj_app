// File: lib/models/serasi_model.dart
class SerasiModel {
  final String id;
  final String nama;
  final int usia;
  final String domisili;
  final String pendidikan;
  final String pekerjaan;
  final String tentangSaya;
  final String jenisKelamin;
  final String fotoUrl;
  final bool isOnline;

  SerasiModel({
    required this.id,
    required this.nama,
    required this.usia,
    required this.domisili,
    required this.pendidikan,
    required this.pekerjaan,
    required this.tentangSaya,
    required this.jenisKelamin,
    required this.fotoUrl,
    required this.isOnline,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nama': nama,
      'usia': usia,
      'domisili': domisili,
      'pendidikan': pendidikan,
      'pekerjaan': pekerjaan,
      'tentangSaya': tentangSaya,
      'jenisKelamin': jenisKelamin,
      'fotoUrl': fotoUrl,
      'isOnline': isOnline,
    };
  }

  factory SerasiModel.fromMap(Map<String, dynamic> map) {
    return SerasiModel(
      id: map['id'] ?? '',
      nama: map['nama'] ?? '',
      usia: map['usia'] ?? 0,
      domisili: map['domisili'] ?? '',
      pendidikan: map['pendidikan'] ?? '',
      pekerjaan: map['pekerjaan'] ?? '',
      tentangSaya: map['tentangSaya'] ?? '',
      jenisKelamin: map['jenisKelamin'] ?? '',
      fotoUrl: map['fotoUrl'] ?? '',
      isOnline: map['isOnline'] ?? false,
    );
  }
}
