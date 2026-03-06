import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:zawj_app/constant/app_color.dart';
import 'package:zawj_app/constant/button_style.dart';
import 'package:zawj_app/constant/decoration_form.dart';
import 'package:zawj_app/extention/navigator.dart';
import 'package:zawj_app/handlers/regist_handler.dart';
import 'package:zawj_app/loginpage.dart';

class Registpage extends StatefulWidget {
  const Registpage({super.key});

  @override
  State<Registpage> createState() => _RegistpageState();
}

class _RegistpageState extends State<Registpage> {
  final TextEditingController namaController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  bool isipassword = true;
  bool confirmpassword = true;
  bool isLoading = false;

  @override
  void dispose() {
    namaController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
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
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(18),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Selamat Datang",
                style: GoogleFonts.montaga(
                  fontSize: 35,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFFE76CA3),
                ),
              ),
              const SizedBox(height: 10),
              Text(
                "Daftar untuk memulai perjalanan menuju pernikahan yang berkah",
                textAlign: TextAlign.center,
                style: GoogleFonts.montserrat(
                  fontSize: 15,
                  color: AppColor.hitam,
                ),
              ),
              const SizedBox(height: 30),
              TextFormField(
                controller: namaController,
                decoration: decorationConstant(
                  hintText: 'Nama Lengkap',
                ).copyWith(prefixIcon: const Icon(Icons.person)),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: decorationConstant(
                  hintText: 'Email',
                ).copyWith(prefixIcon: const Icon(Icons.email_outlined)),
              ),
              const SizedBox(height: 10),
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
              const SizedBox(height: 10),
              TextFormField(
                controller: confirmPasswordController,
                obscureText: confirmpassword,
                decoration: decorationConstant(hintText: 'Konfirmasi Password')
                    .copyWith(
                      prefixIcon: const Icon(Icons.lock_outlined),
                      suffixIcon: IconButton(
                        icon: Icon(
                          confirmpassword
                              ? Icons.visibility_off
                              : Icons.visibility,
                        ),
                        onPressed: () {
                          setState(() {
                            confirmpassword = !confirmpassword;
                          });
                        },
                      ),
                    ),
              ),
              const SizedBox(height: 35),
              isLoading
                  ? const CircularProgressIndicator(color: AppColor.pinktua)
                  : buttonConstant(
                      onPressed: () async {
                        setState(() => isLoading = true);
                        await RegisterHandler.register(
                          context: context,
                          nama: namaController.text,
                          email: emailController.text,
                          password: passwordController.text,
                          confirmPassword: confirmPasswordController.text,
                          onSuccess: () {
                            context.pushReplacement(const LoginPage());
                          },
                        );
                        if (mounted) {
                          setState(() => isLoading = false);
                        }
                      },
                      text: 'Daftar',
                      width: 300,
                    ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Sudah punya akun? ",
                    style: GoogleFonts.montaga(
                      fontSize: 14,
                      color: AppColor.hitam,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      context.pushReplacement(const LoginPage());
                    },
                    child: Text(
                      "Login",
                      style: GoogleFonts.montserrat(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: AppColor.pinktua,
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
