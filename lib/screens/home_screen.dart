import 'package:doffa/widgets/git_versioning.dart';
import 'package:doffa/widgets/my_ads.dart';
import 'package:doffa/widgets/my_coffee_button.dart';
import 'package:doffa/widgets/my_date_picker_card.dart';
import 'package:doffa/widgets/my_logo_wide.dart';
import 'package:doffa/widgets/my_ratio_card.dart';
import 'package:doffa/widgets/my_sign_out_button.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: 400),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              spacing: 8,
              children: [
                Row(
                  spacing: 16,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [MyLogoWide(), MyCoffeeButton(), MySignOutButton()],
                ),
                MyDatePickerCard(),
                MyAds(),
                MyRatioCard(),
                // MyHistoryCard(),
                MyDataCard(),
                MyProgressCard(),
                MyAds(),
                MyAds(),
                GitVersioningWidget(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class MyProgressCard extends StatelessWidget {
  const MyProgressCard({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double maxWidth = constraints.maxWidth;
        return Container(
          width: maxWidth,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF3A3A3A), Color(0xFF222222)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.all(Radius.circular(8)),
            border: Border.all(color: Color(0xFF606060), width: 2),
          ),
          child: Padding(
            padding: const EdgeInsets.only(top: 16, left: 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 8,
              children: [
                Text(
                  "PROGRESS",
                  style: GoogleFonts.montserrat(
                    fontSize: maxWidth / 18,
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    height: 1,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  "Changes between start and end dZate",
                  style: GoogleFonts.montserrat(
                    fontSize: maxWidth / 32,
                    color: Colors.white,
                    fontWeight: FontWeight.w100,
                    height: 1,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Container(
                  width: maxWidth,
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 55, 55, 55),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(8),
                      bottomRight: Radius.circular(8),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      spacing: 8,
                      children: [
                        Text(
                          "100",
                          style: GoogleFonts.montserrat(
                            fontSize: maxWidth / 6,
                            color: Color.fromARGB(255, 109, 255, 129),
                            fontWeight: FontWeight.w900,
                            height: 1,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class MyHistoryCard extends StatelessWidget {
  const MyHistoryCard({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double maxWidth = constraints.maxWidth;
        return Container(
          width: maxWidth,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF3A3A3A), Color(0xFF222222)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.all(Radius.circular(8)),
            border: Border.all(color: Color(0xFF606060), width: 2),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 16,
              children: [
                Text(
                  "History",
                  style: GoogleFonts.montserrat(
                    fontSize: maxWidth / 24,
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    height: 1,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class MyDataCard extends StatelessWidget {
  const MyDataCard({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double maxWidth = constraints.maxWidth;
        return Container(
          width: maxWidth,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF3A3A3A), Color(0xFF222222)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.all(Radius.circular(8)),
            border: Border.all(color: Color(0xFF606060), width: 2),
          ),
          child: Padding(
            padding: const EdgeInsets.only(top: 16, left: 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 8,
              children: [
                Text(
                  "DATA",
                  style: GoogleFonts.montserrat(
                    fontSize: maxWidth / 18,
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    height: 1,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  "Measurements",
                  style: GoogleFonts.montserrat(
                    fontSize: maxWidth / 32,
                    color: Colors.white,
                    fontWeight: FontWeight.w100,
                    height: 1,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Container(
                  width: maxWidth,
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 55, 55, 55),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(8),
                      bottomRight: Radius.circular(8),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      spacing: 8,
                      children: [
                        Text(
                          "100",
                          style: GoogleFonts.montserrat(
                            fontSize: maxWidth / 6,
                            color: Color.fromARGB(255, 109, 255, 129),
                            fontWeight: FontWeight.w900,
                            height: 1,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
