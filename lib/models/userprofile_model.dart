import 'dart:convert';

class UserprofileModel {
  final int? id;
  final int userId;
  final String namaLengkap;
  final String jenisKelamin;
  final String tanggalLahir;
  final int usia;
  final String tempatlahir;
  final String domisili;
  final String suku;
  final String kewarganegaraan;
  final String pendidikan;
  final String? pekerjaan;
  final String? bidangPekerjaan;
  final String? penghasilan;
  final String targetNikah;
  final int waliTahu;
  final int bersediaPindah;
  final String tentangSaya;
  final String statusNikah;
  final int punyaAnak;
  final int? jumlahAnak;
  final String mauPoligami;
  final String sholat;
  final String? kajianRutin;
  final String hafalanQuran;
  final int bercadar;
  final String panjangHijab;
  final String? fotoKtp;
  final String? akteCerai;
  final String? buktiSedekah;
  final int setujuTidakKomunikasiDiluarSistem;
  final int setujuSatuTaarufSatuWaktu;
  final int setujuKebijakanPrivasi;
  final int isProfileComplete;
  final String createdAt;
  final String? updatedAt;

  UserprofileModel({
    this.id,
    required this.userId,
    required this.namaLengkap,
    required this.jenisKelamin,
    required this.tanggalLahir,
    required this.usia,
    required this.tempatlahir,
    required this.domisili,
    required this.suku,
    required this.kewarganegaraan,
    required this.pendidikan,
    this.pekerjaan,
    this.bidangPekerjaan,
    this.penghasilan,
    required this.targetNikah,
    required this.waliTahu,
    required this.bersediaPindah,
    required this.tentangSaya,
    required this.statusNikah,
    required this.punyaAnak,
    this.jumlahAnak,
    required this.mauPoligami,
    required this.sholat,
    this.kajianRutin,
    required this.hafalanQuran,
    required this.bercadar,
    required this.panjangHijab,
    this.fotoKtp,
    this.akteCerai,
    this.buktiSedekah,
    required this.setujuTidakKomunikasiDiluarSistem,
    required this.setujuSatuTaarufSatuWaktu,
    required this.setujuKebijakanPrivasi,
    required this.isProfileComplete,
    required this.createdAt,
    this.updatedAt,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      if (id != null) 'id': id,
      'user_id': userId,
      'nama_lengkap': namaLengkap,
      'jenis_kelamin': jenisKelamin,
      'tanggal_lahir': tanggalLahir,
      'usia': usia,
      'tempat_lahir': tempatlahir,
      'domisili': domisili,
      'suku': suku,
      'kewarganegaraan': kewarganegaraan,
      'pendidikan': pendidikan,
      'pekerjaan': pekerjaan,
      'bidang_pekerjaan': bidangPekerjaan,
      'penghasilan': penghasilan,
      'target_nikah': targetNikah,
      'wali_tahu': waliTahu,
      'bersedia_pindah': bersediaPindah,
      'tentang_saya': tentangSaya,
      'status_nikah': statusNikah,
      'punya_anak': punyaAnak,
      'jumlah_anak': jumlahAnak,
      'mau_poligami': mauPoligami,
      'sholat': sholat,
      'kajian_rutin': kajianRutin,
      'hafalan_quran': hafalanQuran,
      'bercadar': bercadar,
      'panjang_hijab': panjangHijab,
      'foto_ktp': fotoKtp,
      'akte_cerai': akteCerai,
      'bukti_sedekah': buktiSedekah,
      'setuju_tidak_komunikasi_diluar_sistem':
          setujuTidakKomunikasiDiluarSistem,
      'setuju_satu_taaruf_satu_waktu': setujuSatuTaarufSatuWaktu,
      'setuju_kebijakan_privasi': setujuKebijakanPrivasi,
      'is_profile_complete': isProfileComplete,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }

  factory UserprofileModel.fromMap(Map<String, dynamic> map) {
    return UserprofileModel(
      id: map['id'] as int?,
      userId: map['user_id'] as int,
      namaLengkap: map['nama_lengkap'] as String? ?? '',
      jenisKelamin: map['jenis_kelamin'] as String? ?? '',
      tanggalLahir: map['tanggal_lahir'] as String? ?? '',
      usia: map['usia'] as int? ?? 0,
      tempatlahir: map['tempat_lahir'] as String? ?? '',
      domisili: map['domisili'] as String? ?? '',
      suku: map['suku'] as String? ?? '',
      kewarganegaraan: map['kewarganegaraan'] as String? ?? '',
      pendidikan: map['pendidikan'] as String? ?? '',
      pekerjaan: map['pekerjaan'] as String?,
      bidangPekerjaan: map['bidang_pekerjaan'] as String?,
      penghasilan: map['penghasilan'] as String?,
      targetNikah: map['target_nikah'] as String? ?? '',
      waliTahu: map['wali_tahu'] as int? ?? 0,
      bersediaPindah: map['bersedia_pindah'] as int? ?? 0,
      tentangSaya: map['tentang_saya'] as String? ?? '',
      statusNikah: map['status_nikah'] as String? ?? '',
      punyaAnak: map['punya_anak'] as int? ?? 0,
      jumlahAnak: map['jumlah_anak'] as int?,
      mauPoligami: map['mau_poligami'] as String? ?? '',
      sholat: map['sholat'] as String? ?? '',
      kajianRutin: map['kajian_rutin'] as String?,
      hafalanQuran: map['hafalan_quran'] as String? ?? '',
      bercadar: map['bercadar'] as int? ?? 0,
      panjangHijab: map['panjang_hijab'] as String? ?? '',
      fotoKtp: map['foto_ktp'] as String?,
      akteCerai: map['akte_cerai'] as String?,
      buktiSedekah: map['bukti_sedekah'] as String?,
      setujuTidakKomunikasiDiluarSistem:
          map['setuju_tidak_komunikasi_diluar_sistem'] as int? ?? 0,
      setujuSatuTaarufSatuWaktu:
          map['setuju_satu_taaruf_satu_waktu'] as int? ?? 0,
      setujuKebijakanPrivasi: map['setuju_kebijakan_privasi'] as int? ?? 0,
      isProfileComplete: map['is_profile_complete'] as int? ?? 0,
      createdAt: map['created_at'] as String? ?? '',
      updatedAt: map['updated_at'] as String?,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserprofileModel.fromJson(String source) =>
      UserprofileModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
