import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zawj_app/constant/app_color.dart';
import 'package:zawj_app/constant/button_style.dart';
import 'package:zawj_app/constant/decoration_form.dart';
import 'package:zawj_app/controller/profile_controller.dart';
import 'package:zawj_app/extention/navigator.dart';
import 'package:zawj_app/models/userprofile_model.dart';

class Daftarpage extends StatefulWidget {
  final bool isEdit;
  final UserprofileModel? profile;

  const Daftarpage({super.key, this.isEdit = false, this.profile});

  @override
  State<Daftarpage> createState() => _DaftarpageState();
}

class _DaftarpageState extends State<Daftarpage> {
  int PilihanAvatarIndex = 0;
  DateTime? _selectedDate;
  final List<String> PilihanAvatar = [
    'assets/images/ikhwan.jpg',
    'assets/images/akhwat.jpg',
  ];
  String? jenisKelamin = 'Ikhwan';
  String? statusPernikahan = 'Belum menikah';
  String? rajinSholatValue = 'Selalu tepat waktu';
  String? hafalanQuran = 'Juz 30';
  String? mauPoligami = 'Ya, saya bersedia';
  String? panjangHijab = 'Tidak Berhijab';
  String? pendidikan = 'SD';
  String? pekerjaan = '';
  String? bidangPekerjaan = '';
  String? kisaranPenghasilan = '';
  String? targetMenikah = '< 6 bulan';
  bool punyaAnak = false;
  bool apaBercadar = false;
  bool waliMengetahui = false;
  bool bersediaPindahKota = false;
  bool setujuTidakKomunikasiDiluarSistem = false;
  bool setujuSatuTaarufSatuWaktu = false;
  bool setujuKebijakanPrivasi = false;
  String? fotoKTPPath;
  String? akteCeraiPath;
  String? buktiSedekahPath;

  final namaLengkapController = TextEditingController();
  final tempatLahirController = TextEditingController();
  final domisiliController = TextEditingController();
  final sukuController = TextEditingController();
  final kewarganegaraanController = TextEditingController();
  final pekerjaanController = TextEditingController();
  final bidangPekerjaanController = TextEditingController();
  final penghasilanController = TextEditingController();
  final tentangSayaController = TextEditingController();
  final kajianRutinController = TextEditingController();
  final jumlahAnakController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.isEdit && widget.profile != null) {
      _loadProfileData();
    }
  }

  void _loadProfileData() {
    final profile = widget.profile!;
    setState(() {
      namaLengkapController.text = profile.namaLengkap;
      tempatLahirController.text = profile.tempatlahir;
      domisiliController.text = profile.domisili;
      sukuController.text = profile.suku;
      kewarganegaraanController.text = profile.kewarganegaraan;
      pekerjaanController.text = profile.pekerjaan ?? '';
      bidangPekerjaanController.text = profile.bidangPekerjaan ?? '';
      penghasilanController.text = profile.penghasilan ?? '';
      tentangSayaController.text = profile.tentangSaya;
      kajianRutinController.text = profile.kajianRutin ?? '';
      jumlahAnakController.text = profile.jumlahAnak?.toString() ?? '0';
      jenisKelamin = profile.jenisKelamin;

      // ✅ AUTO SET AVATAR BERDASARKAN JENIS KELAMIN
      if (profile.jenisKelamin == 'Ikhwan') {
        PilihanAvatarIndex = 0;
      } else {
        PilihanAvatarIndex = 1;
      }

      statusPernikahan = profile.statusNikah;
      rajinSholatValue = profile.sholat;
      hafalanQuran = profile.hafalanQuran;
      mauPoligami = profile.mauPoligami;
      panjangHijab = profile.panjangHijab;
      pendidikan = profile.pendidikan;
      targetMenikah = profile.targetNikah;
      punyaAnak = profile.punyaAnak == 1;
      apaBercadar = profile.bercadar == 1;
      waliMengetahui = profile.waliTahu == 1;
      bersediaPindahKota = profile.bersediaPindah == 1;
      setujuTidakKomunikasiDiluarSistem =
          profile.setujuTidakKomunikasiDiluarSistem == 1;
      setujuSatuTaarufSatuWaktu = profile.setujuSatuTaarufSatuWaktu == 1;
      setujuKebijakanPrivasi = profile.setujuKebijakanPrivasi == 1;
      if (profile.tanggalLahir.isNotEmpty) {
        _selectedDate = DateTime.parse(profile.tanggalLahir);
      }
      fotoKTPPath = profile.fotoKtp;
      akteCeraiPath = profile.akteCerai;
      buktiSedekahPath = profile.buktiSedekah;
    });
  }

  @override
  void dispose() {
    namaLengkapController.dispose();
    tempatLahirController.dispose();
    domisiliController.dispose();
    sukuController.dispose();
    kewarganegaraanController.dispose();
    pekerjaanController.dispose();
    bidangPekerjaanController.dispose();
    penghasilanController.dispose();
    tentangSayaController.dispose();
    kajianRutinController.dispose();
    jumlahAnakController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(1950),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  void showPilihanAvatar() {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusGeometry.circular(20),
      ),
      builder: (context) {
        return Container(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Pilih Avatar",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(PilihanAvatar.length, (index) {
                  final dipilih = PilihanAvatarIndex == index;
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        PilihanAvatarIndex = index;
                      });
                      Navigator.pop(context);
                    },
                    child: Container(
                      width: 120,
                      height: 120,
                      margin: EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                        color: dipilih ? Colors.blue[50] : Colors.grey[100],
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(
                          color: dipilih
                              ? AppColor.pinktua
                              : Colors.transparent,
                          width: 3,
                        ),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Image.asset(
                          PilihanAvatar[index],
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  );
                }),
              ),
              SizedBox(height: 20),
            ],
          ),
        );
      },
    );
  }

  Future<void> _uploadDocument(String documentType) async {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Container(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Upload $documentType",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              ListTile(
                leading: Icon(Icons.camera_alt, color: Colors.pink),
                title: Text("Ambil Foto"),
                onTap: () {
                  setState(() {
                    if (documentType == "KTP") {
                      fotoKTPPath = "camera_ktp.jpg";
                    } else if (documentType == "Akta Cerai") {
                      akteCeraiPath = "camera_cerai.jpg";
                    } else {
                      buktiSedekahPath = "camera_sedekah.jpg";
                    }
                  });
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.photo_library, color: Colors.pink),
                title: Text("Pilih dari Galeri"),
                onTap: () {
                  setState(() {
                    if (documentType == "KTP") {
                      fotoKTPPath = "gallery_ktp.jpg";
                    } else if (documentType == "Akta Cerai") {
                      akteCeraiPath = "gallery_cerai.jpg";
                    } else {
                      buktiSedekahPath = "gallery_sedekah.jpg";
                    }
                  });
                  Navigator.pop(context);
                },
              ),
              SizedBox(height: 20),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  'Find My Zawj',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 255, 119, 164),
                    fontSize: 30,
                  ),
                ),
                SizedBox(width: 8),
                Icon(
                  Icons.favorite,
                  color: Color.fromARGB(255, 239, 97, 144),
                  size: 24,
                ),
              ],
            ),
            Text(
              'Lengkapi Profil',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: AppColor.abutua,
                fontSize: 17,
              ),
            ),
          ],
        ),
        backgroundColor: Color.fromARGB(255, 250, 238, 246),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            children: [
              Card(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.person, color: Colors.pink[300], size: 30),
                          SizedBox(width: 6),
                          Text(
                            "Foto Profil",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 23,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      Center(
                        child: GestureDetector(
                          onTap: showPilihanAvatar,
                          child: Stack(
                            children: [
                              CircleAvatar(
                                radius: 50,
                                backgroundColor: Colors.grey[200],
                                child: ClipOval(
                                  child: Image.asset(
                                    PilihanAvatar[PilihanAvatarIndex],
                                    fit: BoxFit.cover,
                                    width: 300,
                                    height: 300,
                                  ),
                                ),
                              ),
                              Positioned(
                                bottom: 0,
                                right: 0,
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: AppColor.pinktua,
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: Colors.white,
                                      width: 2,
                                    ),
                                  ),
                                  child: const Icon(
                                    Icons.edit,
                                    size: 20,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 15),
                      const Center(
                        child: Text(
                          "Klik foto untuk memilih avatar",
                          style: TextStyle(color: Colors.grey, fontSize: 12),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Card(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.info_outline,
                            color: Colors.pink[300],
                            size: 25,
                          ),
                          SizedBox(width: 6),
                          Text(
                            "Informasi Dasar",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 23,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Text(
                        "Nama Lengkap",
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                        ),
                      ),
                      SizedBox(height: 10),
                      TextFormField(
                        controller: namaLengkapController,
                        decoration: decorationConstant(
                          hintText: "Nama Lengkap",
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        "Jenis Kelamin",
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                        ),
                      ),
                      SizedBox(height: 10),
                      DropdownButtonFormField<String>(
                        initialValue: jenisKelamin,
                        items: ['Ikhwan', 'Akhwat'].map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (newValue) {
                          setState(() {
                            jenisKelamin = newValue;
                            if (newValue == 'Ikhwan') {
                              PilihanAvatarIndex = 0;
                            } else {
                              PilihanAvatarIndex = 1;
                            }
                          });
                        },
                      ),
                      SizedBox(height: 10),
                      Text(
                        "Tanggal Lahir",
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                        ),
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: InkWell(
                              onTap: () => _selectDate(context),
                              child: IgnorePointer(
                                child: TextFormField(
                                  decoration: decorationConstant(
                                    hintText: _selectedDate == null
                                        ? "dd/mm/yyyy"
                                        : "${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}",
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child: TextFormField(
                              decoration: decorationConstant(hintText: "Usia"),
                              keyboardType: TextInputType.number,
                              readOnly: true,
                              controller: TextEditingController(
                                text: _selectedDate != null
                                    ? (DateTime.now().year -
                                              _selectedDate!.year)
                                          .toString()
                                    : '',
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Text(
                        "Tempat Lahir",
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                        ),
                      ),
                      SizedBox(height: 10),
                      TextFormField(
                        controller: tempatLahirController,
                        decoration: decorationConstant(
                          hintText: "Tempat Lahir",
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        "Domisili",
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                        ),
                      ),
                      SizedBox(height: 10),
                      TextFormField(
                        controller: domisiliController,
                        decoration: decorationConstant(hintText: "Domisili"),
                      ),
                      SizedBox(height: 10),
                      Text(
                        "Asal Suku",
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                        ),
                      ),
                      SizedBox(height: 10),
                      TextFormField(
                        controller: sukuController,
                        decoration: decorationConstant(
                          hintText: "Suku atau Etnis",
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        "Kewarganegaraan",
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                        ),
                      ),
                      SizedBox(height: 10),
                      TextFormField(
                        controller: kewarganegaraanController,
                        decoration: decorationConstant(
                          hintText: "Kewarganegaraan",
                        ),
                      ),
                      SizedBox(height: 10),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),
              Card(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.school, color: Colors.pink[300]),
                          SizedBox(width: 8),
                          Text(
                            "Pendidikan & Karir",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 23,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 16),
                      Text(
                        "Pendidikan Terakhir",
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                        ),
                      ),
                      SizedBox(height: 10),
                      DropdownButtonFormField<String>(
                        initialValue: pendidikan,
                        items: ['SD', 'SMP', 'SMA', 'S1', 'S2', 'S3'].map((
                          String value,
                        ) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (newValue) {
                          setState(() {
                            pendidikan = newValue;
                          });
                        },
                      ),
                      SizedBox(height: 10),
                      Text(
                        "Pekerjaan",
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                        ),
                      ),
                      SizedBox(height: 10),
                      TextFormField(
                        controller: pekerjaanController,
                        decoration: decorationConstant(hintText: "Pekerjaan"),
                      ),
                      SizedBox(height: 10),
                      Text(
                        "Bidang Pekerjaan",
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                        ),
                      ),
                      SizedBox(height: 10),
                      TextFormField(
                        controller: bidangPekerjaanController,
                        decoration: decorationConstant(
                          hintText: "Bidang Pekerjaan",
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        "Kisaran Penghasilan (Optional)",
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                        ),
                      ),
                      SizedBox(height: 10),
                      TextFormField(
                        controller: penghasilanController,
                        decoration: decorationConstant(
                          hintText: "Kisaran Penghasilan",
                        ),
                      ),
                      SizedBox(height: 10),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),
              Card(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.favorite_outline, color: Colors.pink[300]),
                          SizedBox(width: 8),
                          Text(
                            "Kesiapan Menikah",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 23,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 16),
                      Text(
                        "Target menikah dalam",
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                        ),
                      ),
                      SizedBox(height: 10),
                      DropdownButtonFormField<String>(
                        initialValue: targetMenikah,
                        items:
                            [
                              '< 6 bulan',
                              '6 bulan - 1 tahun',
                              '1 - 2 tahun',
                              '> 2 tahun',
                              'Belum ditentukan',
                            ].map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                        onChanged: (newValue) {
                          setState(() {
                            targetMenikah = newValue;
                          });
                        },
                      ),
                      SizedBox(height: 10),
                      Text(
                        "Apakah wali sudah mengetahui?",
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                        ),
                      ),
                      SizedBox(height: 5),
                      Row(
                        children: [
                          Expanded(
                            child: RadioListTile<bool>(
                              title: const Text("Ya"),
                              value: true,
                              groupValue: waliMengetahui,
                              onChanged: (value) {
                                setState(() {
                                  waliMengetahui = value!;
                                });
                              },
                              activeColor: Color.fromARGB(255, 255, 119, 164),
                              contentPadding: EdgeInsets.zero,
                            ),
                          ),
                          Expanded(
                            child: RadioListTile<bool>(
                              title: const Text("Tidak"),
                              value: false,
                              groupValue: waliMengetahui,
                              onChanged: (value) {
                                setState(() {
                                  waliMengetahui = value!;
                                });
                              },
                              activeColor: Color.fromARGB(255, 255, 119, 164),
                              contentPadding: EdgeInsets.zero,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Text(
                        "Bersedia pindah kota setelah menikah?",
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                        ),
                      ),
                      SizedBox(height: 5),
                      Row(
                        children: [
                          Expanded(
                            child: RadioListTile<bool>(
                              title: const Text("Ya"),
                              value: true,
                              groupValue: bersediaPindahKota,
                              onChanged: (value) {
                                setState(() {
                                  bersediaPindahKota = value!;
                                });
                              },
                              activeColor: Color.fromARGB(255, 255, 119, 164),
                              contentPadding: EdgeInsets.zero,
                            ),
                          ),
                          Expanded(
                            child: RadioListTile<bool>(
                              title: const Text("Tidak"),
                              value: false,
                              groupValue: bersediaPindahKota,
                              onChanged: (value) {
                                setState(() {
                                  bersediaPindahKota = value!;
                                });
                              },
                              activeColor: Color.fromARGB(255, 255, 119, 164),
                              contentPadding: EdgeInsets.zero,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),
              Card(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Tentang Saya",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 23,
                        ),
                      ),
                      SizedBox(height: 10),
                      TextFormField(
                        controller: tentangSayaController,
                        decoration: decorationConstant(
                          hintText: "Ceritakan tentang dirimu",
                        ),
                        maxLines: 6,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 30),
              Card(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.people, color: Colors.pink[300], size: 30),
                          SizedBox(width: 6),
                          Text(
                            "Status Pernikahan",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 23,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      DropdownButtonFormField<String>(
                        decoration: decorationConstant(
                          hintText: "Status Pernikahan",
                        ),
                        initialValue: statusPernikahan,
                        items:
                            [
                              'Belum menikah',
                              'Menikah',
                              'Cerai Hidup',
                              'Cerai Mati',
                            ].map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                        onChanged: (newValue) {
                          setState(() {
                            statusPernikahan = newValue;
                          });
                        },
                      ),
                      SizedBox(height: 10),
                      Text(
                        "Memiliki Anak",
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Row(
                        children: [
                          Expanded(
                            child: RadioListTile<bool>(
                              title: const Text("Ya"),
                              value: true,
                              groupValue: punyaAnak,
                              onChanged: (value) {
                                setState(() {
                                  punyaAnak = value!;
                                });
                              },
                              activeColor: Color.fromARGB(255, 255, 119, 164),
                              contentPadding: EdgeInsets.zero,
                            ),
                          ),
                          Expanded(
                            child: RadioListTile<bool>(
                              title: const Text("Tidak"),
                              value: false,
                              groupValue: punyaAnak,
                              onChanged: (value) {
                                setState(() {
                                  punyaAnak = value!;
                                });
                              },
                              activeColor: Color.fromARGB(255, 255, 119, 164),
                              contentPadding: EdgeInsets.zero,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      TextFormField(
                        controller: jumlahAnakController,
                        decoration: decorationConstant(hintText: "Jumlah Anak"),
                        keyboardType: TextInputType.number,
                      ),
                      SizedBox(height: 10),
                      SizedBox(height: 10),
                      Text(
                        "Apakah bersedia poligami?",
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                        ),
                      ),
                      SizedBox(height: 10),
                      DropdownButtonFormField<String>(
                        decoration: decorationConstant(
                          hintText: "Apakah bersedia poligami?",
                        ),
                        initialValue: mauPoligami,
                        items:
                            [
                              'Ya, saya bersedia',
                              'InsyaAllah, jika istrinya ridho',
                              'Saya harus meyakinkan keluarga',
                              'Kurang yakin, tolong yakinkan',
                              'Tidak mau',
                            ].map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                        onChanged: (newValue) {
                          setState(() {
                            mauPoligami = newValue;
                          });
                        },
                      ),
                      SizedBox(height: 10),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),
              Card(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.menu_book,
                            color: Colors.pink[300],
                            size: 30,
                          ),
                          SizedBox(width: 6),
                          Text(
                            "Pemahaman Agama",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 23,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Text(
                        "Bagaimana sholatnya?",
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                        ),
                      ),
                      SizedBox(height: 10),
                      DropdownButtonFormField<String>(
                        decoration: decorationConstant(
                          hintText: "Rutinitas Sholat",
                        ),
                        initialValue: rajinSholatValue,
                        items:
                            [
                              'Selalu tepat waktu',
                              'Sering tepat waktu',
                              'Kadang-kadang',
                              'Jarang',
                            ].map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                        onChanged: (newValue) {
                          setState(() {
                            rajinSholatValue = newValue;
                          });
                        },
                      ),
                      SizedBox(height: 10),
                      Text(
                        " Apakah mengikuti kajian rutin?",
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                        ),
                      ),
                      SizedBox(height: 10),
                      TextFormField(
                        controller: kajianRutinController,
                        decoration: decorationConstant(
                          hintText: "Jika iya, kajian apa dan dimana",
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        "Hafalan Al-Quran",
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                        ),
                      ),
                      SizedBox(height: 10),
                      DropdownButtonFormField<String>(
                        decoration: decorationConstant(
                          hintText: "Hafalan Al-Qur'an",
                        ),
                        initialValue: hafalanQuran,
                        items:
                            [
                              'Juz 30',
                              '1-5 Juz',
                              '6-10 Juz',
                              '11-20 Juz',
                              '21-30 Juz',
                              '30 Juz',
                            ].map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                        onChanged: (newValue) {
                          setState(() {
                            hafalanQuran = newValue;
                          });
                        },
                      ),
                      SizedBox(height: 10),
                      Text(
                        "Apakah Bercadar",
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Row(
                        children: [
                          Expanded(
                            child: RadioListTile<bool>(
                              title: const Text("Ya"),
                              value: true,
                              groupValue: apaBercadar,
                              onChanged: (value) {
                                setState(() {
                                  apaBercadar = value!;
                                });
                              },
                              activeColor: Color.fromARGB(255, 255, 119, 164),
                              contentPadding: EdgeInsets.zero,
                            ),
                          ),
                          Expanded(
                            child: RadioListTile<bool>(
                              title: const Text("Tidak"),
                              value: false,
                              groupValue: apaBercadar,
                              onChanged: (value) {
                                setState(() {
                                  apaBercadar = value!;
                                });
                              },
                              activeColor: Color.fromARGB(255, 255, 119, 164),
                              contentPadding: EdgeInsets.zero,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Text(
                        "Panjang Hijab",
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                        ),
                      ),
                      SizedBox(height: 10),
                      DropdownButtonFormField<String>(
                        decoration: decorationConstant(
                          hintText: "panjang hijab",
                        ),
                        initialValue: panjangHijab,
                        items:
                            [
                              'Tidak Berhijab',
                              'Lilit leher',
                              'Menutupi dada',
                              'Menutupi perut',
                              'Menutupi lutut',
                            ].map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                        onChanged: (newValue) {
                          setState(() {
                            panjangHijab = newValue;
                          });
                        },
                      ),
                      SizedBox(height: 10),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),
              Card(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.description,
                            color: Colors.pink[300],
                            size: 30,
                          ),
                          SizedBox(width: 6),
                          Text(
                            "Upload Dokumen",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 23,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 16),
                      InkWell(
                        onTap: () => _uploadDocument("KTP"),
                        child: Container(
                          padding: EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey[300]!),
                            borderRadius: BorderRadius.circular(12),
                            color: fotoKTPPath != null
                                ? Colors.green[50]
                                : Colors.grey[50],
                          ),
                          child: Row(
                            children: [
                              Icon(
                                fotoKTPPath != null
                                    ? Icons.check_circle
                                    : Icons.upload_file,
                                color: fotoKTPPath != null
                                    ? Colors.green
                                    : Colors.grey,
                              ),
                              SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Foto KTP",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14,
                                      ),
                                    ),
                                    Text(
                                      fotoKTPPath != null
                                          ? "✓ File terupload"
                                          : "Klik untuk upload",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Icon(Icons.chevron_right, color: Colors.grey),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 12),
                      if (statusPernikahan == 'Cerai Hidup' ||
                          statusPernikahan == 'Cerai Mati') ...[
                        InkWell(
                          onTap: () => _uploadDocument("Akta Cerai"),
                          child: Container(
                            padding: EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey[300]!),
                              borderRadius: BorderRadius.circular(12),
                              color: akteCeraiPath != null
                                  ? Colors.green[50]
                                  : Colors.grey[50],
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  akteCeraiPath != null
                                      ? Icons.check_circle
                                      : Icons.upload_file,
                                  color: akteCeraiPath != null
                                      ? Colors.green
                                      : Colors.grey,
                                ),
                                SizedBox(width: 12),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Akta Cerai / Akta Kematian",
                                        style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 14,
                                        ),
                                      ),
                                      Text(
                                        akteCeraiPath != null
                                            ? "✓ File terupload"
                                            : "Klik untuk upload",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Icon(Icons.chevron_right, color: Colors.grey),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 12),
                      ],
                      InkWell(
                        onTap: () => _uploadDocument("Bukti Sedekah"),
                        child: Container(
                          padding: EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey[300]!),
                            borderRadius: BorderRadius.circular(12),
                            color: buktiSedekahPath != null
                                ? Colors.green[50]
                                : Colors.grey[50],
                          ),
                          child: Row(
                            children: [
                              Icon(
                                buktiSedekahPath != null
                                    ? Icons.check_circle
                                    : Icons.upload_file,
                                color: buktiSedekahPath != null
                                    ? Colors.green
                                    : Colors.grey,
                              ),
                              SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Bukti Sedekah (Pemeliharaan Akun)",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14,
                                      ),
                                    ),
                                    Text(
                                      buktiSedekahPath != null
                                          ? "✓ File terupload"
                                          : "Klik untuk upload",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Icon(Icons.chevron_right, color: Colors.grey),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),
              Card(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.assignment_turned_in,
                            color: Colors.pink[300],
                            size: 30,
                          ),
                          SizedBox(width: 6),
                          Text(
                            "Persetujuan & Kebijakan",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 23,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 16),
                      CheckboxListTile(
                        value: setujuTidakKomunikasiDiluarSistem,
                        onChanged: (value) {
                          setState(() {
                            setujuTidakKomunikasiDiluarSistem = value!;
                          });
                        },
                        activeColor: AppColor.pinktua,
                        title: Text(
                          "Saya siap tidak berkomunikasi diluar sistem",
                          style: TextStyle(fontSize: 14),
                        ),
                        contentPadding: EdgeInsets.zero,
                      ),
                      CheckboxListTile(
                        value: setujuSatuTaarufSatuWaktu,
                        onChanged: (value) {
                          setState(() {
                            setujuSatuTaarufSatuWaktu = value!;
                          });
                        },
                        activeColor: AppColor.pinktua,
                        title: Text(
                          "Setuju jika hanya satu kali taaruf dalam satu waktu",
                          style: TextStyle(fontSize: 14),
                        ),
                        contentPadding: EdgeInsets.zero,
                      ),
                      CheckboxListTile(
                        value: setujuKebijakanPrivasi,
                        onChanged: (value) {
                          setState(() {
                            setujuKebijakanPrivasi = value!;
                          });
                        },
                        activeColor: AppColor.pinktua,
                        title: Text(
                          "Menyetujui kebijakan privasi dan aturan aplikasi",
                          style: TextStyle(fontSize: 14),
                        ),
                        contentPadding: EdgeInsets.zero,
                      ),
                      SizedBox(height: 10),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 30),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: buttonConstant(
                  width: 400,
                  text: "Simpan Profil",
                  onPressed: () async {
                    if (!setujuTidakKomunikasiDiluarSistem ||
                        !setujuSatuTaarufSatuWaktu ||
                        !setujuKebijakanPrivasi) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            "Harap setuju semua persyaratan dan kebijakan",
                          ),
                          backgroundColor: Colors.red,
                        ),
                      );
                      return;
                    }

                    final namaLengkap = namaLengkapController.text.trim();
                    final tempatLahir = tempatLahirController.text.trim();
                    final domisili = domisiliController.text.trim();
                    final suku = sukuController.text.trim();
                    final kewarganegaraan = kewarganegaraanController.text
                        .trim();
                    final pekerjaan = pekerjaanController.text.trim();
                    final bidangPekerjaan = bidangPekerjaanController.text
                        .trim();
                    final penghasilan = penghasilanController.text.trim();
                    final tentangSaya = tentangSayaController.text.trim();
                    final kajianRutin = kajianRutinController.text.trim();

                    if (namaLengkap.isEmpty ||
                        _selectedDate == null ||
                        tempatLahir.isEmpty ||
                        domisili.isEmpty ||
                        suku.isEmpty ||
                        kewarganegaraan.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            "Harap lengkapi semua field yang wajib diisi",
                          ),
                          backgroundColor: Colors.red,
                        ),
                      );
                      return;
                    }

                    final usia = _selectedDate != null
                        ? DateTime.now().year - _selectedDate!.year
                        : 0;

                    final prefs = await SharedPreferences.getInstance();
                    final userId = prefs.getInt('user_id');

                    if (userId == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            "Session tidak valid, silakan login ulang",
                          ),
                          backgroundColor: Colors.red,
                        ),
                      );
                      return;
                    }

                    final profile = UserprofileModel(
                      id: widget.profile?.id,
                      userId: userId,
                      namaLengkap: namaLengkap,
                      jenisKelamin: jenisKelamin ?? 'Ikhwan',
                      tanggalLahir: _selectedDate!.toIso8601String(),
                      usia: usia,
                      tempatlahir: tempatLahir,
                      domisili: domisili,
                      suku: suku,
                      kewarganegaraan: kewarganegaraan,
                      pendidikan: pendidikan ?? 'SD',
                      pekerjaan: pekerjaan.isEmpty ? null : pekerjaan,
                      bidangPekerjaan: bidangPekerjaan.isEmpty
                          ? null
                          : bidangPekerjaan,
                      penghasilan: penghasilan.isEmpty ? null : penghasilan,
                      targetNikah: targetMenikah ?? '< 6 bulan',
                      waliTahu: waliMengetahui ? 1 : 0,
                      bersediaPindah: bersediaPindahKota ? 1 : 0,
                      tentangSaya: tentangSaya,
                      statusNikah: statusPernikahan ?? 'Belum menikah',
                      punyaAnak: punyaAnak ? 1 : 0,
                      jumlahAnak: punyaAnak
                          ? int.tryParse(jumlahAnakController.text)
                          : null,
                      mauPoligami: mauPoligami ?? 'Ya, saya bersedia',
                      sholat: rajinSholatValue ?? 'Selalu tepat waktu',
                      kajianRutin: kajianRutin.isEmpty ? null : kajianRutin,
                      hafalanQuran: hafalanQuran ?? 'Juz 30',
                      bercadar: apaBercadar ? 1 : 0,
                      panjangHijab: panjangHijab ?? 'Tidak Berhijab',
                      fotoKtp: fotoKTPPath,
                      akteCerai: akteCeraiPath,
                      buktiSedekah: buktiSedekahPath,
                      setujuTidakKomunikasiDiluarSistem:
                          setujuTidakKomunikasiDiluarSistem ? 1 : 0,
                      setujuSatuTaarufSatuWaktu: setujuSatuTaarufSatuWaktu
                          ? 1
                          : 0,
                      setujuKebijakanPrivasi: setujuKebijakanPrivasi ? 1 : 0,
                      isProfileComplete: 1,
                      createdAt:
                          widget.profile?.createdAt ??
                          DateTime.now().toIso8601String(),
                      updatedAt: DateTime.now().toIso8601String(),
                    );

                    try {
                      final result = await ProfileController().saveProfile(
                        profile,
                      );
                      if (result['success'] == true) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(result['message']),
                            backgroundColor: Colors.green,
                          ),
                        );
                        if (mounted) {
                          Navigator.of(context).pop(true);
                        }
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              result['message'] ?? 'Gagal menyimpan profil',
                            ),
                            backgroundColor: Colors.red,
                          ),
                        );
                      }
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("Terjadi kesalahan: ${e.toString()}"),
                          backgroundColor: Colors.red,
                        ),
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
