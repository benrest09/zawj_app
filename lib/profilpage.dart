import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:zawj_app/constant/app_color.dart';
import 'package:zawj_app/daftarpage.dart';
import 'package:zawj_app/loginpage.dart';
import 'package:zawj_app/controller/profile_controller.dart';
import 'package:zawj_app/models/userprofile_model.dart';

class ProfilPage extends StatefulWidget {
  const ProfilPage({super.key});

  @override
  State<ProfilPage> createState() => _ProfilPageState();
}

class _ProfilPageState extends State<ProfilPage> {
  UserprofileModel? _profile;
  bool _isLoading = true;
  bool _hasCompleteProfile = false;

  @override
  void initState() {
    super.initState();
    _checkProfile();
  }

  Future<void> _checkProfile() async {
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getInt('user_id');

    if (userId != null) {
      final hasProfile = await ProfileController().checkProfileComplete(userId);
      if (hasProfile) {
        final result = await ProfileController().getProfile(userId);
        if (result['success'] && result['data'] != null) {
          setState(() {
            _profile = result['data'] as UserprofileModel;
            _hasCompleteProfile = true;
            _isLoading = false;
          });
          return;
        }
      }
    }
    if (mounted) {
      setState(() {
        _hasCompleteProfile = false;
        _isLoading = false;
      });
    }
  }

  Future<void> _logout() async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'Konfirmasi Logout',
          style: GoogleFonts.montserrat(fontWeight: FontWeight.bold),
        ),
        content: const Text('Apakah Anda yakin ingin keluar?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Batal'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            style: ElevatedButton.styleFrom(backgroundColor: AppColor.pinktua),
            child: const Text('Logout'),
          ),
        ],
      ),
    );

    if (confirm == true && mounted) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.clear();

      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => LoginPage()),
        (route) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Scaffold(
        body: Center(child: CircularProgressIndicator(color: AppColor.pinktua)),
      );
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 70,
        automaticallyImplyLeading: false,
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
              'Profil',
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
      body: _hasCompleteProfile && _profile != null
          ? _buildCompleteProfile()
          : _buildIncompleteProfile(),
    );
  }

  Widget _buildIncompleteProfile() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Colors.white, AppColor.pinkmuda.withOpacity(0.2)],
        ),
      ),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Card(
            elevation: 6,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24),
            ),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(30),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          AppColor.pinkmuda,
                          AppColor.pinktua.withOpacity(0.8),
                        ],
                      ),
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: AppColor.pinktua.withOpacity(0.3),
                          blurRadius: 15,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.person_outline,
                      size: 60,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 25),
                  Text(
                    'Profil belum lengkap',
                    style: GoogleFonts.montserrat(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: AppColor.pinktua,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Lengkapi profil agar bisa memulai taaruf',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.montserrat(
                      fontSize: 14,
                      color: Colors.grey[600],
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 35),
                  SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: ElevatedButton(
                      onPressed: () async {
                        final result = await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const Daftarpage(),
                          ),
                        );
                        if (result == true && mounted) {
                          _checkProfile();
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColor.pinktua,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(26),
                        ),
                        elevation: 3,
                        shadowColor: AppColor.pinktua.withOpacity(0.4),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Lengkapi Profil',
                            style: GoogleFonts.montserrat(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(width: 8),
                          const Icon(
                            Icons.arrow_forward,
                            color: Colors.white,
                            size: 18,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCompleteProfile() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Card(
            elevation: 3,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.white, AppColor.pinkmuda.withOpacity(0.1)],
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            AppColor.pinkmuda,
                            AppColor.pinktua.withOpacity(0.8),
                          ],
                        ),
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: AppColor.pinktua.withOpacity(0.2),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.person,
                        size: 50,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 15),
                    Text(
                      _profile!.namaLengkap,
                      style: GoogleFonts.montserrat(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.location_on,
                          size: 16,
                          color: AppColor.pinktua,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          _profile!.domisili,
                          style: GoogleFonts.montserrat(
                            fontSize: 14,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          _buildInfoCard('Informasi Dasar', [
            _buildInfoRow('Nama Lengkap', _profile!.namaLengkap),
            _buildInfoRow('Jenis Kelamin', _profile!.jenisKelamin),
            _buildInfoRow('Usia', '${_profile!.usia} tahun'),
            _buildInfoRow('Domisili', _profile!.domisili),
            _buildInfoRow('Suku', _profile!.suku),
            _buildInfoRow('Kewarganegaraan', _profile!.kewarganegaraan),
          ]),
          const SizedBox(height: 15),
          _buildInfoCard('Pendidikan & Karir', [
            _buildInfoRow('Pendidikan', _profile!.pendidikan),
            _buildInfoRow('Pekerjaan', _profile!.pekerjaan ?? '-'),
            if (_profile!.bidangPekerjaan != null)
              _buildInfoRow('Bidang Pekerjaan', _profile!.bidangPekerjaan!),
            if (_profile!.penghasilan != null)
              _buildInfoRow('Penghasilan', _profile!.penghasilan!),
          ]),
          const SizedBox(height: 15),
          _buildInfoCard('Kesiapan Menikah', [
            _buildInfoRow('Target Menikah', _profile!.targetNikah),
            _buildInfoRow(
              'Wali Mengetahui',
              _profile!.waliTahu == 1 ? 'Ya' : 'Tidak',
            ),
            _buildInfoRow(
              'Bersedia Pindah',
              _profile!.bersediaPindah == 1 ? 'Ya' : 'Tidak',
            ),
          ]),
          const SizedBox(height: 15),
          _buildInfoCard('Status Pernikahan', [
            _buildInfoRow('Status', _profile!.statusNikah),
            _buildInfoRow(
              'Punya Anak',
              _profile!.punyaAnak == 1 ? 'Ya' : 'Tidak',
            ),
            if (_profile!.jumlahAnak != null)
              _buildInfoRow('Jumlah Anak', '${_profile!.jumlahAnak}'),
            _buildInfoRow('Mau Poligami', _profile!.mauPoligami),
          ]),
          const SizedBox(height: 15),
          _buildInfoCard('Pemahaman Agama', [
            _buildInfoRow('Sholat', _profile!.sholat),
            if (_profile!.kajianRutin != null)
              _buildInfoRow('Kajian Rutin', _profile!.kajianRutin!),
            _buildInfoRow('Hafalan Quran', _profile!.hafalanQuran),
            _buildInfoRow('Bercadar', _profile!.bercadar == 1 ? 'Ya' : 'Tidak'),
            _buildInfoRow('Panjang Hijab', _profile!.panjangHijab),
          ]),
          const SizedBox(height: 15),
          _buildInfoCard('Tentang Saya', [
            _buildInfoRow('', _profile!.tentangSaya),
          ]),
          const SizedBox(height: 30),
          Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () async {
                    final result = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            Daftarpage(isEdit: true, profile: _profile),
                      ),
                    );
                    if (result == true && mounted) {
                      _checkProfile();
                    }
                  },
                  icon: const Icon(Icons.edit),
                  label: const Text('Edit Profil'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColor.pinktua,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 2,
                  ),
                ),
              ),
              const SizedBox(width: 15),
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: _logout,
                  icon: const Icon(Icons.logout),
                  label: const Text('Logout'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red[400],
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 2,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildInfoCard(String title, List<Widget> children) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: AppColor.pinkmuda.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    Icons.check_circle_outline,
                    size: 18,
                    color: AppColor.pinktua,
                  ),
                ),
                const SizedBox(width: 10),
                Text(
                  title,
                  style: GoogleFonts.montserrat(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppColor.pinktua,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            ...children,
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (label.isNotEmpty)
            SizedBox(
              width: 140,
              child: Text(
                label,
                style: GoogleFonts.montserrat(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey[700],
                ),
              ),
            ),
          Expanded(
            child: Text(
              value,
              style: GoogleFonts.montserrat(
                fontSize: 14,
                color: Colors.black87,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
