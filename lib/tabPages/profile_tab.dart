import 'package:google_fonts/google_fonts.dart';
import 'package:lazis/authentication/login_screen.dart';
import 'package:lazis/global/global.dart';
import 'package:flutter/material.dart';
import 'package:lazis/infoHandler/app_info.dart';
import 'package:lazis/theme.dart';
import 'package:provider/provider.dart';
import 'package:smooth_star_rating_null_safety/smooth_star_rating_null_safety.dart';

class ProfileTabPage extends StatefulWidget {
  const ProfileTabPage({Key? key}) : super(key: key);

  @override
  State<ProfileTabPage> createState() => _ProfileTabPageState();
}

class _ProfileTabPageState extends State<ProfileTabPage> {
  double ratingsNumber = 0;
  String titleStarRating = "Baik";

  @override
  void initState() {
    super.initState();

    getRatingsNumber();
  }

  getRatingsNumber() {
    setState(() {
      ratingsNumber = double.parse(
          Provider.of<AppInfo>(context, listen: false).driverAverageRating);
    });

    setupRatingsTitle();
  }

  setupRatingsTitle() {
    if (ratingsNumber == 1) {
      setState(() {
        titleStarRating = "Sangat Buruk";
      });
    }
    if (ratingsNumber == 2) {
      setState(() {
        titleStarRating = "Buruk";
      });
    }
    if (ratingsNumber == 3) {
      setState(() {
        titleStarRating = "Baik";
      });
    }
    if (ratingsNumber == 4) {
      setState(() {
        titleStarRating = "Sangat Baik";
      });
    }
    if (ratingsNumber == 5) {
      setState(() {
        titleStarRating = "Mengagumkan";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: cWhite,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0.5,
        centerTitle: true,
        backgroundColor: cWhite,
        title: Text(
          "Profil",
          style: GoogleFonts.poppins(
            color: cBlack,
            fontWeight: semibold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              //Nama
              Text(
                onlineDriverData.name!,
                style: GoogleFonts.poppins(
                  fontSize: 48,
                  color: cBlack,
                  fontWeight: bold,
                ),
              ),

              // Rating
              SmoothStarRating(
                rating: ratingsNumber,
                allowHalfRating: false,
                starCount: 5,
                color: cOrange,
                borderColor: cOrange,
                size: 24,
              ),

              const SizedBox(height: 12.0),

              // Keterangan Rating
              Text(
                titleStarRating,
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: semibold,
                  color: cBlack,
                ),
              ),

              // Informasi Driver
              Container(
                margin: const EdgeInsets.only(top: 32),
                padding: const EdgeInsets.all(16),
                height: 177,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: cWhite,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: cGrey,
                      blurRadius: 0.1,
                      spreadRadius: 0.1,
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Informasi Driver',
                      style: GoogleFonts.poppins(
                        color: cBlack,
                        fontSize: 16,
                        fontWeight: semibold,
                      ),
                    ),
                    const SizedBox(height: 9),
                    Container(
                      height: 1,
                      width: double.infinity,
                      color: cGrey,
                    ),
                    const SizedBox(height: 9),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Nomor Telepon',
                          style: GoogleFonts.poppins(
                            color: cGrey,
                          ),
                        ),
                        Text(
                          onlineDriverData.phone!,
                          style: GoogleFonts.poppins(
                            color: cBlack,
                            fontSize: 16,
                            fontWeight: semibold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Email',
                          style: GoogleFonts.poppins(
                            color: cGrey,
                          ),
                        ),
                        Text(
                          onlineDriverData.email!,
                          style: GoogleFonts.poppins(
                            color: cBlack,
                            fontSize: 16,
                            fontWeight: semibold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Informasi Mobil
              Container(
                margin: const EdgeInsets.only(top: 18, bottom: 32),
                padding: const EdgeInsets.all(16),
                height: 234,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: cWhite,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: cGrey,
                      blurRadius: 0.1,
                      spreadRadius: 0.1,
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Informasi Mobil',
                      style: GoogleFonts.poppins(
                        color: cBlack,
                        fontSize: 16,
                        fontWeight: semibold,
                      ),
                    ),
                    const SizedBox(height: 9),
                    Container(
                      height: 1,
                      width: double.infinity,
                      color: cGrey,
                    ),
                    const SizedBox(height: 9),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Plat Nomor',
                          style: GoogleFonts.poppins(
                            color: cGrey,
                          ),
                        ),
                        Text(
                          onlineDriverData.platnomor!,
                          style: GoogleFonts.poppins(
                            color: cBlack,
                            fontSize: 16,
                            fontWeight: semibold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Jenis',
                          style: GoogleFonts.poppins(
                            color: cGrey,
                          ),
                        ),
                        Text(
                          onlineDriverData.merkmobil!,
                          style: GoogleFonts.poppins(
                            color: cBlack,
                            fontSize: 16,
                            fontWeight: semibold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Tipe',
                          style: GoogleFonts.poppins(
                            color: cGrey,
                          ),
                        ),
                        Text(
                          onlineDriverData.warnamobil!,
                          style: GoogleFonts.poppins(
                            color: cBlack,
                            fontSize: 16,
                            fontWeight: semibold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              Container(
                height: 60,
                width: double.infinity,
                child: TextButton(
                  onPressed: () {
                    fAuth.signOut();
                    Navigator.push(context,
                        MaterialPageRoute(builder: (c) => const LoginScreen()));
                  },
                  style: TextButton.styleFrom(
                    backgroundColor: cOrange,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: Text(
                    'Logout',
                    style: GoogleFonts.poppins(
                      color: cWhite,
                      fontSize: 16,
                      fontWeight: semibold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
