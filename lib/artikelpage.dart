import 'package:flutter/material.dart';

class Artikelpage extends StatelessWidget {
  const Artikelpage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(child: Center(child: Text("INI ARTIKEL"))),
      ),
    );
  }
}
