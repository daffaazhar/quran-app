import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quran_app/globals.dart';
import 'package:quran_app/screens/surah_section.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _appBar(),
      bottomNavigationBar: _bottomNavigationBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) => [
            SliverToBoxAdapter(
              child: _lastRead(),
            ),
          ],
          body: const SurahSection(),
        ),
      ),
    );
  }

  Widget _lastRead() {
    return Padding(
      padding: const EdgeInsets.only(top: 24.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xFFDF98FA), Color(0xFF9055FF)],
            ),
          ),
          child: Stack(
            children: [
              Container(
                height: 138,
              ),
              Positioned(
                bottom: -24,
                right: -32,
                child: SvgPicture.asset('assets/svgs/quran.svg'),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        SvgPicture.asset('assets/svgs/book.svg'),
                        const SizedBox(width: 8),
                        Text(
                          'Last Read',
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 22),
                    Text(
                      'Al-Fatihah',
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Ayah No: 1',
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  AppBar _appBar() => AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            IconButton(
                onPressed: () {},
                icon: SvgPicture.asset('assets/svgs/hamburger-icon.svg')),
            const SizedBox(width: 18),
            Text('Holy Quran',
                style: GoogleFonts.poppins(
                    fontSize: 20, fontWeight: FontWeight.bold, color: primary)),
          ],
        ),
      );

  BottomNavigationBar _bottomNavigationBar() => BottomNavigationBar(
        backgroundColor: Colors.white,
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        elevation: 28,
        items: [
          _bottomNavigationBarItem(
              icon: 'assets/svgs/quran-icon.svg', label: 'Quran'),
          _bottomNavigationBarItem(
              icon: 'assets/svgs/lamp-icon.svg', label: 'Tips'),
          _bottomNavigationBarItem(
              icon: 'assets/svgs/pray-icon.svg', label: 'Prayer'),
          _bottomNavigationBarItem(
              icon: 'assets/svgs/doa-icon.svg', label: 'Doa'),
          _bottomNavigationBarItem(
              icon: 'assets/svgs/bookmark-icon.svg', label: 'Bookmark'),
        ],
      );

  BottomNavigationBarItem _bottomNavigationBarItem(
          {required String icon, required String label}) =>
      BottomNavigationBarItem(
          icon: SvgPicture.asset(
            icon,
            theme: SvgTheme(currentColor: gray),
          ),
          activeIcon: SvgPicture.asset(
            icon,
            theme: SvgTheme(currentColor: primary),
          ),
          label: label);
}
