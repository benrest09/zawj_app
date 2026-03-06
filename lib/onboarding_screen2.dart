import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:zawj_app/constant/app_color.dart';
import 'package:zawj_app/constant/button_style.dart';
import 'package:zawj_app/extention/navigator.dart';
import 'package:zawj_app/onboarding_screen3.dart';

class OnboardingScreen2 extends StatefulWidget {
  const OnboardingScreen2({super.key});

  @override
  State<OnboardingScreen2> createState() => _OnboardingScreen2State();
}

class _OnboardingScreen2State extends State<OnboardingScreen2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: 50),
              Image.asset(
                "assets/images/onboarding2.png",
                width: 300,
                height: 400,
                fit: BoxFit.contain,
              ),
              Text(
                "Privasi dan Keamanan",
                style: GoogleFonts.montaga(
                  fontWeight: FontWeight.w500,
                  fontSize: 30,
                ),
              ),
              SizedBox(height: 10),
              Text(
                "Data Anda Terlindungi",
                style: GoogleFonts.montserrat(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: AppColor.pinkmuda,
                ),
              ),
              SizedBox(height: 10),
              Text(
                textAlign: TextAlign.center,
                "Kami menjaga privasi dan keamanan data pribadi Anda dengan standar tertinggi dan proses verifikasi ketat untuk memastikan profil yang autentik",
                style: GoogleFonts.montserrat(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  color: AppColor.abutua,
                  height: 1.7,
                ),
              ),
              SizedBox(height: 10),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  buttonConstant(
                    text: 'Selanjutnya',
                    width: 300,
                    onPressed: () {
                      context.push(OnboardingScreen3());
                    },
                    icon: Icons.chevron_right_rounded,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
