import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import '../globals.dart';
import '../models/ayat.dart';
import '../models/surah.dart';

class DetailScreen extends StatelessWidget {
  final int noSurat;

  const DetailScreen({Key? key, required this.noSurat}) : super(key: key);

  Future<Surah> _getDetailSurah() async {
    final response = await Dio().get('https://equran.id/api/surat/$noSurat');
    return Surah.fromJson(jsonDecode(response.toString()));
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Surah>(
        future: Future.delayed(const Duration(milliseconds: 500), () => _getDetailSurah()),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Scaffold(body: SpinKitRing(color: primary));
          }

          if (!snapshot.hasData) {
            return const Scaffold(
              backgroundColor: Colors.white,
            );
          }

          Surah surah = snapshot.data!;
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: _appBar(context: context, surah: surah),
            body: NestedScrollView(
              headerSliverBuilder: (context, innerBoxIsScrolled) => [
                SliverToBoxAdapter(
                  child: _details(surah: surah),
                )
              ],
              body: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: ListView.separated(
                    itemBuilder: (context, index) => _ayatItem(
                        ayat: surah.ayat!
                            .elementAt(index + (noSurat == 1 ? 1 : 0))),
                    separatorBuilder: (context, index) => Container(),
                    itemCount: surah.jumlahAyat + (noSurat == 1 ? -1 : 0)),
              ),
            ),
          );
        });
  }

  Widget _ayatItem({required Ayat ayat}) => Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
            decoration: BoxDecoration(
                color: const Color(0xFF121931).withOpacity(.05),
                borderRadius: BorderRadius.circular(10)),
            child: Row(
              children: [
                Container(
                  width: 28,
                  height: 28,
                  decoration:
                      BoxDecoration(color: primary, shape: BoxShape.circle),
                  child: Center(
                    child: Text("${ayat.nomor}",
                        style: GoogleFonts.poppins(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Colors.white)),
                  ),
                ),
                const Spacer(),
                SvgPicture.asset('assets/svgs/share-icon.svg'),
                const SizedBox(width: 16),
                SvgPicture.asset('assets/svgs/play-icon.svg'),
                const SizedBox(width: 16),
                SvgPicture.asset('assets/svgs/boomark-icon-primary.svg'),
              ],
            ),
          ),
          const SizedBox(height: 24),
          Text(
            ayat.ar,
            textAlign: TextAlign.right,
            style: GoogleFonts.amiri(
                color: dark, fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 18),
          Text(
            ayat.idn,
            textAlign: TextAlign.left,
            style: GoogleFonts.poppins(
                color: dark, fontSize: 16, fontWeight: FontWeight.w400),
          ),
          const SizedBox(height: 18),
        ],
      );

  Widget _details({required Surah surah}) => Padding(
      padding: const EdgeInsets.all(24) + const EdgeInsets.only(bottom: 16),
      child: _detail(surah: surah));

  ClipRRect _detail({required Surah surah}) {
    return ClipRRect(
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
              height: 258,
            ),
            Positioned(
              bottom: -38,
              right: -52,
              child: Opacity(
                  opacity: 0.15,
                  child: SvgPicture.asset('assets/svgs/quran.svg', width: 318)),
            ),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(28.0),
              child: Column(
                children: [
                  Text(
                    surah.namaLatin,
                    style: GoogleFonts.poppins(
                      fontSize: 26,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    surah.arti,
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(
                    width: 200,
                    child: Divider(
                      height: 32,
                      thickness: 2,
                      color: Colors.white.withOpacity(.35),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        surah.tempatTurun.name,
                        style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(width: 6),
                      Container(
                        width: 4,
                        height: 4,
                        decoration: BoxDecoration(
                            color: const Color(0xFFFFFFFF).withOpacity(.35),
                            shape: BoxShape.circle),
                      ),
                      const SizedBox(width: 6),
                      Text(
                        "${surah.jumlahAyat} AYAT",
                        style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                  const SizedBox(height: 32),
                  SvgPicture.asset('assets/svgs/basmalah.svg')
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  AppBar _appBar({required BuildContext context, required Surah surah}) =>
      AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            IconButton(
                onPressed: () => Navigator.of(context).pop(),
                icon: SvgPicture.asset('assets/svgs/back-icon.svg')),
            const SizedBox(width: 18),
            Text(surah.namaLatin,
                style: GoogleFonts.poppins(
                    fontSize: 20, fontWeight: FontWeight.bold, color: primary)),
            const Spacer(),
            IconButton(
                onPressed: () {},
                icon: SvgPicture.asset('assets/svgs/search-icon.svg')),
          ],
        ),
      );
}
