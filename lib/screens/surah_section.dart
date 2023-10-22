import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import '../globals.dart';
import '../models/surah.dart';
import 'detail_screen.dart';

class SurahSection extends StatefulWidget {
  const SurahSection({Key? key}) : super(key: key);

  @override
  _SurahSectionState createState() => _SurahSectionState();
}

class _SurahSectionState extends State<SurahSection> {
  final TextEditingController _searchController = TextEditingController();
  List<Surah> _filteredSurahs = [];

  @override
  void initState() {
    super.initState();
    _loadSurahList();
  }

  Future<void> _loadSurahList() async {
    String data = await rootBundle.loadString('assets/datas/listSurah.json');
    final surahList = surahFromJson(data);
    setState(() {
      _filteredSurahs = surahList;
    });
  }

  void _performSearch(String query) {
    if (query.isEmpty) {
      _loadSurahList();
    } else {
      setState(() {
        _filteredSurahs = _filteredSurahs
            .where((surah) =>
                surah.namaLatin.toLowerCase().contains(query.toLowerCase()))
            .toList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 18.0, bottom: 4),
          child: TextField(
            controller: _searchController,
            decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      width: 1, color: const Color(0xFFBBC4CE).withOpacity(0.35)),
                  borderRadius: BorderRadius.circular(12),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      width: 1, color: primary),
                  borderRadius: BorderRadius.circular(12),
                ),
                hintText: "Search Surah",
                hintStyle: GoogleFonts.poppins(fontSize: 16, color: gray),
                prefixIcon: Padding(
                  padding: const EdgeInsets.all(14.0),
                  child: SvgPicture.asset(
                    'assets/svgs/search-icon.svg',
                    width: 12,
                    height: 12,
                  ),
                ),
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 14, horizontal: 18)),
            onChanged: (query) {
              _performSearch(query);
            },
          ),
        ),
        Expanded(
            child: ListView.separated(
                itemBuilder: (context, index) {
                  final surah = _filteredSurahs[index];
                  final isFirstItem = index == 0;
                  final isLastItem = index == _filteredSurahs.length - 1;

                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0) +
                        EdgeInsets.only(
                          top: isFirstItem ? 8.0 : 0.0,
                          bottom: isLastItem ? 8.0 : 0.0,
                        ),
                    child: _surahItem(surah: surah, context: context),
                  );
                },
                separatorBuilder: (context, index) => Divider(
                      height: 0,
                      color: const Color(0xFFBBC4CE).withOpacity(.35),
                    ),
                itemCount: _filteredSurahs.length))
      ],
    );
  }

  Widget _surahItem({required Surah surah, required BuildContext context}) =>
      GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => DetailScreen(noSurat: surah.nomor)));
        },
        child: Row(
          children: [
            Stack(
              children: [
                SvgPicture.asset('assets/svgs/number-border.svg'),
                SizedBox(
                  width: 36,
                  height: 36,
                  child: Center(
                    child: Text(
                      "${surah.nomor}",
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: dark,
                        height: 1,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(width: 16),
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  surah.namaLatin,
                  style: GoogleFonts.poppins(
                      color: dark, fontSize: 16, fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Text(
                      surah.tempatTurun.name,
                      style: GoogleFonts.poppins(
                          color: gray,
                          fontSize: 12,
                          fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(width: 6),
                    Container(
                      width: 4,
                      height: 4,
                      decoration: BoxDecoration(
                          color: const Color(0xFFBBC4CE).withOpacity(.35),
                          shape: BoxShape.circle),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      "${surah.jumlahAyat} AYAT",
                      style: GoogleFonts.poppins(
                          color: gray,
                          fontSize: 12,
                          fontWeight: FontWeight.w500),
                    ),
                  ],
                )
              ],
            )),
            Text(
              surah.nama,
              style: GoogleFonts.amiri(
                  color: primary2, fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      );
}
