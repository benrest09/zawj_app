import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:zawj_app/constant/app_color.dart';
import 'package:zawj_app/constant/button_style.dart';
import 'package:zawj_app/constant/decoration_form.dart';
import 'package:zawj_app/database/preference.dart';
import 'package:zawj_app/extention/navigator.dart';
import 'package:zawj_app/homepage.dart';
import 'package:zawj_app/models/user_model.dart';
import 'package:zawj_app/registpage.dart';

import '../database/sqflite.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isipassword = true;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 50,
        backgroundColor: Colors.white,
        title: Row(
          children: [
            Text(
              'Find My Zawj',
              style: GoogleFonts.poppins(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: const Color(0xFFE76CA3),
              ),
            ),
            const SizedBox(width: 8),
            const Icon(
              Icons.favorite,
              color: Color.fromARGB(255, 239, 97, 144),
              size: 24,
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 50),

                Text(
                  "Selamat Datang",
                  style: GoogleFonts.montaga(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: AppColor.pinktua,
                  ),
                ),

                const SizedBox(height: 8),

                Text(
                  "Masuk untuk melanjutkan perjalanan menuju pernikahan yang berkah.",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.montserrat(
                    fontSize: 14,
                    color: AppColor.abumuda,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 40),

                TextFormField(
                  controller: emailController,
                  decoration: decorationConstant(
                    hintText: 'Email',
                  ).copyWith(prefixIcon: Icon(Icons.email_outlined)),
                ),

                const SizedBox(height: 16),

                TextFormField(
                  controller: passwordController,
                  obscureText: isipassword,
                  decoration: decorationConstant(hintText: 'Password').copyWith(
                    prefixIcon: const Icon(Icons.lock_outlined),
                    suffixIcon: IconButton(
                      icon: Icon(
                        isipassword ? Icons.visibility_off : Icons.visibility,
                      ),
                      onPressed: () {
                        setState(() {
                          isipassword = !isipassword;
                        });
                      },
                    ),
                  ),
                ),

                const SizedBox(height: 8),

                Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    "Lupa Password?",
                    style: const TextStyle(
                      color: Color(0xFFE76CA3),
                      fontSize: 15,
                    ),
                  ),
                ),

                const SizedBox(height: 40),
                buttonConstant(
                  text: 'Masuk',
                  width: 400,
                  onPressed: () async {
                    final UserModel? login = await DBHelper.loginUser(
                      email: emailController.text,
                      password: passwordController.text,
                    );
                    if (login != null) {
                      PreferenceHandler.storingIsLogin(true);
                      ScaffoldMessenger.of(
                        context,
                      ).showSnackBar(SnackBar(content: Text("Login Berhasil")));

                      await Future.delayed(const Duration(seconds: 2));
                      context.push(Homepage());
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            "Login Gagal, email atau password salah",
                          ),
                        ),
                      );
                    }
                  },
                ),

                const SizedBox(height: 30),
                Center(
                  child: Text(
                    "Atau lanjutkan dengan",
                    style: GoogleFonts.montaga(
                      color: AppColor.hitam,
                      fontSize: 18,
                    ),
                  ),
                ),
                SizedBox(height: 35),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      borderRadius: BorderRadius.circular(50),
                      onTap: () {
                        print("google login");
                      },
                      child: Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(0xFBFCF7FF),
                          //Color(0xFFFFB7DC),
                          boxShadow: [
                            BoxShadow(
                              color: const Color.fromARGB(255, 201, 199, 199),
                              blurRadius: 12,
                              offset: Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Center(
                          child: Image.asset(
                            'assets/icons/google.png',
                            width: 30,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 20),

                    InkWell(
                      borderRadius: BorderRadius.circular(50),
                      onTap: () {
                        print("google login");
                      },
                      child: Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(0xFBFCF7FF),
                          //Color(0xFFFFB7DC),
                          boxShadow: [
                            BoxShadow(
                              color: const Color.fromARGB(255, 201, 199, 199),
                              blurRadius: 12,
                              offset: Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Center(
                          child: Image.asset(
                            'assets/icons/apple.png',
                            width: 30,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 20),

                    InkWell(
                      borderRadius: BorderRadius.circular(50),
                      onTap: () {
                        print("google login");
                      },
                      child: Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(0xFBFCF7FF),
                          //Color(0xFFFFB7DC),
                          boxShadow: [
                            BoxShadow(
                              color: const Color.fromARGB(255, 201, 199, 199),
                              blurRadius: 12,
                              offset: Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Center(
                          child: Image.asset(
                            'assets/icons/facebook.png',
                            width: 30,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 20, height: 16),
                  ],
                ),
                SizedBox(height: 20),

                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Belum Punya Akun? ",
                        style: GoogleFonts.montaga(
                          fontSize: 16,
                          color: AppColor.hitam,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          context.push(Registpage());
                        },
                        child: Text(
                          "Daftar",
                          style: GoogleFonts.montserrat(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFFE76CA3),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
