import 'package:flutter/material.dart';
import 'package:zawj_app/constant/app_color.dart';
import 'package:zawj_app/constant/button_style.dart';
import 'package:zawj_app/daftarpage.dart';
import 'package:zawj_app/extention/navigator.dart';

class Profilpage extends StatefulWidget {
  const Profilpage({super.key});

  @override
  State<Profilpage> createState() => _ProfilpageState();
}

class _ProfilpageState extends State<Profilpage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Container(
            height: 180,
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.white, AppColor.pinkmuda],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 120),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Card(
                    elevation: 6,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: ListTile(
                      contentPadding: EdgeInsets.symmetric(
                        vertical: 16,
                        horizontal: 16,
                      ),
                      leading: CircleAvatar(
                        radius: 30,
                        backgroundImage: AssetImage("assets/images/ikhwan.jpg"),
                      ),
                      title: Text(
                        "Ahmad Fadil",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      subtitle: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.location_on_outlined, size: 16),
                          SizedBox(width: 4),
                          Text("Jakarta"),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              CircleAvatar(
                                backgroundColor: AppColor.pinktua,
                                child: const Icon(
                                  Icons.description,
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(width: 12),
                              Expanded(
                                child: Text(
                                  "Lengkapi profil taaruf anda",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          const Text(
                            "Agar dapat memulai proses taaruf dan mendapatkan rekomendasi pasangan, silakan lengkapi formulir data diri Anda terlebih dahulu.",
                          ),
                          const SizedBox(height: 20),
                          Center(
                            child: buttonConstant(
                              text: "Isi Sekarang",
                              width: 300,
                              onPressed: () async {
                                context.push(Daftarpage());
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
