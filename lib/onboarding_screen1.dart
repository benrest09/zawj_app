import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:zawj_app/constant/app_color.dart';
import 'package:zawj_app/constant/button_style.dart';
import 'package:zawj_app/extention/navigator.dart';
import 'package:zawj_app/onboarding_screen2.dart';

class OnboardingScreen1 extends StatefulWidget {
  const OnboardingScreen1({super.key});

  @override
  State<OnboardingScreen1> createState() => _OnboardingScreen1State();
}

class _OnboardingScreen1State extends State<OnboardingScreen1> {
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
                "assets/images/onboarding1.png",
                width: 300,
                height: 400,
                fit: BoxFit.contain,
              ),
              Text(
                "Cari Pasangan Halal",
                style: GoogleFonts.montaga(
                  fontWeight: FontWeight.w500,
                  fontSize: 30,
                ),
              ),
              SizedBox(height: 10),
              Text(
                "Dengan Cara yang Diridhai Allah",
                style: GoogleFonts.montserrat(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: AppColor.pinkmuda,
                ),
              ),
              SizedBox(height: 10),
              Text(
                textAlign: TextAlign.center,
                'Temukan pasangan hidup yang sejalan\n'
                'dengan nilai-nilai islam dan tujuan \n'
                'pernikanan yang sakinah mawaddah, \n'
                'warohmah',
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
                      context.push(OnboardingScreen2());
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
