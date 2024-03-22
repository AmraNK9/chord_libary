import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: must_be_immutable
class Retry extends StatelessWidget {
  VoidCallback onTap;

  Retry({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: 500,
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Icon(
                FontAwesomeIcons.sadCry,
                size: 140,
              ),
              const SizedBox(
                height: 40,
              ),
              Text(
                "WHAT?",
                style: GoogleFonts.handlee(
                  fontSize: 44,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                "Something whant worng.",
                style: GoogleFonts.montserrat(
                    fontSize: 16, color: Colors.grey[800]),
              ),
              Text(
                "Let's try one more time",
                style: GoogleFonts.montserrat(
                    fontSize: 16, color: Colors.grey[800]),
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: onTap,
                style: ButtonStyle(
                  elevation:
                      MaterialStateProperty.resolveWith<double?>((states) {
                    if (states.contains(MaterialState.pressed)) {
                      // Elevation when pressed
                      return 0.0;
                    }
                    // Elevation for other states (default)
                    return 0.4; // You can adjust the elevation value here
                  }),
                  padding: MaterialStateProperty.all(
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 10)),
                ),
                child: Text(
                  "TRY AGAIN",
                  style: GoogleFonts.poppins(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(height: 100)
            ],
          ),
        ),
      ),
    );
  }
}
