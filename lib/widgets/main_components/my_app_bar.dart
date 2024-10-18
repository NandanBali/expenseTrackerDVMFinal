import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyAppBar extends StatelessWidget {
  const MyAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      title: Title(color: Colors.white, child: Text("EXPENSE TRACKER", style: GoogleFonts.ibmPlexMono(),)),
    );
  }
}
