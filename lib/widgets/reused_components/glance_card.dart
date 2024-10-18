import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class GlanceCard extends StatelessWidget {
  final String mainText;
  final String caption;
  final List<Color> gradientColors;
  const GlanceCard(this.mainText, this.caption, this.gradientColors, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.transparent,
        ),
        borderRadius: BorderRadius.circular(8.0),
        gradient: LinearGradient(
          colors: gradientColors,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        children: <Widget>[
          SizedBox(
            width: double.infinity,
            height: 12.0,
          ),
          Text(
            mainText,
            style: GoogleFonts.ibmPlexMono(
              fontSize: 48.0,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
          SizedBox(
            height: 18.0,
          ),
          Align(
              alignment: Alignment.bottomLeft,
              child: Text(
                caption,
                style: GoogleFonts.ibmPlexMono(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w300,
                  color: Colors.white,
                ),
              )),
        ],
      ),
    );
  }
}
