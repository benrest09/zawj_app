import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:zawj_app/constant/app_color.dart';
import 'package:zawj_app/constant/button_style.dart';
import 'package:zawj_app/extention/navigator.dart';
import 'package:zawj_app/loginpage.dart';
import 'package:zawj_app/registpage.dart';

class OnboardingScreen3 extends StatefulWidget {
  const OnboardingScreen3({super.key});

  @override
  State<OnboardingScreen3> createState() => _OnboardingScreen3State();
}

class _OnboardingScreen3State extends State<OnboardingScreen3> {
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
              SizedBox(height: 40),
              Image.asset(
                "assets/images/onboarding3.png",
                width: 400,
                height: 500,
                fit: BoxFit.contain,
              ),
              Text(
                "Siap Memulai?",
                style: GoogleFonts.montaga(
                  fontWeight: FontWeight.w500,
                  fontSize: 30,
                ),
              ),
              SizedBox(height: 10),
              Text(
                "Menuju Pernikahan yang Berkah",
                style: GoogleFonts.montserrat(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: AppColor.pinkmuda,
                ),
              ),
              SizedBox(height: 10),
              Text(
                textAlign: TextAlign.center,
                'Bergabunglah dengan para Muslim dan \n'
                'Muslimah yang telah menemukan pasangan \n'
                'hidup mereka melalui Find My Zawj \n',
                style: GoogleFonts.montserrat(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  color: AppColor.abutua,
                  height: 1.7,
                ),
              ),

              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  buttonConstant(
                    text: 'Selanjutnya',
                    width: 300,
                    onPressed: () {
                      context.push(Registpage());
                    },
                    icon: Icons.chevron_right_rounded,
                  ),
                  SizedBox(height: 10),
                  SizedBox(
                    width: 300,
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColor.abumuda,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                      ),
                      onPressed: () {
                        context.push(LoginPage());
                      },
                      child: Text(
                        "Sudah Punya Akun",
                        style: GoogleFonts.montserrat(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
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
