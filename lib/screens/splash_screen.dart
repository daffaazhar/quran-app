import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quran_app/globals.dart';
import 'package:quran_app/screens/home_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text('Quran App',
                    style: GoogleFonts.poppins(
                      color: primary,
                      fontWeight: FontWeight.bold,
                      fontSize: 28.0,
                    )),
                const SizedBox(height: 16.0),
                Text('Learn Quran and\nRecite once everyday',
                    style: GoogleFonts.poppins(color: gray, fontSize: 18.0),
                    textAlign: TextAlign.center),
                const SizedBox(height: 48.0),
                Stack(
                  clipBehavior: Clip.none,
                  children: <Widget>[
                    Container(
                      height: 500,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(28.0),
                        color: primary,
                      ),
                      child: SvgPicture.asset(
                        'assets/svgs/splash.svg',
                        alignment: Alignment.topCenter,
                      ),
                    ),
                    Positioned(
                      left: 0,
                      right: 0,
                      bottom: -28,
                      child: Center(
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => const HomeScreen()));
                          },
                          style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 40.0, vertical: 16.0),
                              backgroundColor: secondary,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              )),
                          child: Text(
                            'Get Started',
                            style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
