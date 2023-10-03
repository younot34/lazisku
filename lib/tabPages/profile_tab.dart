// import 'dart:html';

import 'package:lazis/authentication/login_screen.dart';
import 'package:lazis/global/global.dart';
import 'package:flutter/material.dart';
import 'package:lazis/infoHandler/app_info.dart';
import 'package:provider/provider.dart';
import 'package:smooth_star_rating_null_safety/smooth_star_rating_null_safety.dart';

import '../widgets/info_design_ui.dart';

class ProfileTabPage extends StatefulWidget {
  const ProfileTabPage({Key? key}) : super(key: key);

  @override
  State<ProfileTabPage> createState() => _ProfileTabPageState();
}

class _ProfileTabPageState extends State<ProfileTabPage> {
  double ratingsNumber = 0;
  String titleStarRating = "baik";

  @override
  void initState() {
    // TODO: implement initState
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
        titleStarRating = "sangat buruk";
      });
    }
    if (ratingsNumber == 2) {
      setState(() {
        titleStarRating = "buruk";
      });
    }
    if (ratingsNumber == 3) {
      setState(() {
        titleStarRating = "baik";
      });
    }
    if (ratingsNumber == 4) {
      setState(() {
        titleStarRating = "sangat baik";
      });
    }
    if (ratingsNumber == 5) {
      setState(() {
        titleStarRating = "mengagumkan";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 2,
        centerTitle: true,
        backgroundColor: Colors.transparent,
        title: const Text(
          "Profil",
          style: TextStyle(
            color: Color.fromARGB(255, 244, 144, 3),
            fontSize: 24,
          ),
        ),
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 16,
          ),
          //name
          Text(
            onlineDriverData.name!,
            style: const TextStyle(
              fontSize: 50.0,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),

          // const SizedBox(height: 22.0,),

          SmoothStarRating(
            rating: ratingsNumber,
            allowHalfRating: false,
            starCount: 5,
            color: const Color.fromARGB(255, 244, 144, 3),
            borderColor: const Color.fromARGB(255, 244, 144, 3),
            size: 30,
          ),

          const SizedBox(
            height: 12.0,
          ),

          Text(
            titleStarRating,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),

          const SizedBox(
            height: 18.0,
          ),
          const Divider(
            height: 4.0,
            thickness: 4.0,
          ),
          const SizedBox(
            height: 38.0,
          ),

          //phone
          InfoDesignUIWidget(
            textInfo: onlineDriverData.phone!,
            iconData: Icons.phone_iphone,
          ),

          //email
          InfoDesignUIWidget(
            textInfo: onlineDriverData.email!,
            iconData: Icons.email,
          ),

          InfoDesignUIWidget(
            textInfo:
                "${driverVehicleType!} ${onlineDriverData.merkmobil!} ${onlineDriverData.warnamobil!} ${onlineDriverData.platnomor!}",
            iconData: Icons.car_repair,
          ),

          const SizedBox(
            height: 20,
          ),

          ElevatedButton(
            onPressed: () {
              fAuth.signOut();
              // Navigator.push(); menuju ke login
              Navigator.push(
                  context, MaterialPageRoute(builder: (c) => const LoginScreen()));
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromARGB(255, 244, 144, 3),
            ),
            child: const Text(
              "Logout",
              style: TextStyle(color: Colors.white),
            ),
          )
        ],
      ),
    );
  }
}
