import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lazis/assistants/assistant_methods.dart';
import 'package:lazis/global/global.dart';
import 'package:lazis/infoHandler/app_info.dart';
import 'package:lazis/mainScreen/new_trip_screen.dart';
import 'package:lazis/models/user_ride_request_information.dart';
// import 'package:lazis/widgets/history_design_ui.dart';
import 'package:provider/provider.dart';
// import 'package:lazis/mainScreen/main_screen.dart';

class PermintaanTab extends StatefulWidget {
  UserRideRequestInformation? userRideRequestDetails;
  PermintaanTab(
      {super.key, UserRideRequestInformation? userRideRequestDetails});

  @override
  State<PermintaanTab> createState() => _PermintaanTabState();
}

class _PermintaanTabState extends State<PermintaanTab> {


  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor: Colors.transparent,
        title: const Text(
          "Permintaan",
          style: TextStyle(
            color: Color.fromARGB(255, 244, 144, 3),
            fontSize: 24,
          ),
        ),
      ),
      body: Column(
        children: [
          //listpermintaan
          ListView.separated(
            separatorBuilder: (context, i) => const Divider(
              color: Colors.grey,
              thickness: 2,
              height: 2,
            ),
            itemBuilder: (context, i) {
              return Card(
                color: Colors.white54,
                child: Container(
                  margin: const EdgeInsets.all(8),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.grey[800],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(
                        height: 14,
                      ),

                      Image.asset(
                        "images/car_logo.png",
                        width: 160,
                      ),

                      const SizedBox(
                        height: 10,
                      ),

                      //title
                      const Text(
                        "Permintaan Baru",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 22,
                            color: Colors.grey),
                      ),

                      const SizedBox(height: 14.0),

                      const Divider(
                        height: 3,
                        thickness: 3,
                      ),

                      //alamat
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          children: [
                            //lokasi pasien
                            Row(
                              children: [
                                Image.asset(
                                  "images/origin.png",
                                  width: 30,
                                  height: 30,
                                ),
                                const SizedBox(
                                  width: 14,
                                ),
                                Expanded(
                                  child: Text(
                                    widget
                                        .userRideRequestDetails!.originAddress!,
                                    style: const TextStyle(
                                      fontSize: 16,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(height: 20.0),

                            //lokasi perminataan
                            Row(
                              children: [
                                Image.asset(
                                  "images/destination.png",
                                  width: 30,
                                  height: 30,
                                ),
                                const SizedBox(
                                  width: 14,
                                ),
                                Expanded(
                                  child: Text(
                                    widget.userRideRequestDetails!
                                        .destinationAddress!,
                                    style: const TextStyle(
                                      fontSize: 16,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                      const Divider(
                        height: 3,
                        thickness: 3,
                      ),

                      //buttons tolak terima
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red,
                              ),
                              onPressed: () {
                                audioPlayer.pause();
                                audioPlayer.stop();
                                audioPlayer = AssetsAudioPlayer();

                                //Tolak Permintaan
                                FirebaseDatabase.instance
                                    .ref()
                                    .child("All Ride Requests")
                                    .child(widget
                                        .userRideRequestDetails!.rideRequestId!)
                                    .remove()
                                    .then((value) {
                                  FirebaseDatabase.instance
                                      .ref()
                                      .child("driver")
                                      .child(currentFirebaseUser!.uid)
                                      .child("newRideStatus")
                                      .set("idle");
                                }).then((value) {
                                  FirebaseDatabase.instance
                                      .ref()
                                      .child("driver")
                                      .child(currentFirebaseUser!.uid)
                                      .child("tripsHistory")
                                      .child(widget.userRideRequestDetails!
                                          .rideRequestId!)
                                      .remove();
                                }).then((value) {
                                  Fluttertoast.showToast(
                                      msg:
                                          "Ride Request has been Cancelled, Successfully. Restart App Now.");
                                });

                                Future.delayed(
                                    const Duration(milliseconds: 3000), () {
                                  SystemNavigator.pop();
                                });
                              },
                              child: Text(
                                "Tolak".toUpperCase(),
                                style: const TextStyle(
                                  fontSize: 14.0,
                                ),
                              ),
                            ),
                            const SizedBox(width: 25.0),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.green,
                              ),
                              onPressed: () {
                                audioPlayer.pause();
                                audioPlayer.stop();
                                audioPlayer = AssetsAudioPlayer();

                                //Terima permintaan
                                acceptRideRequest(context);
                              },
                              child: Text(
                                "Terima".toUpperCase(),
                                style: const TextStyle(
                                  fontSize: 14.0,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
            itemCount: Provider.of<AppInfo>(context, listen: false)
                .allTripsHistoryInformationList
                .length,
            physics: const ClampingScrollPhysics(),
            shrinkWrap: true,
          ),
        ],
      ),
    );
  }

  acceptRideRequest(BuildContext context) {
    String getRideRequestId = "";
    FirebaseDatabase.instance
        .ref()
        .child("driver")
        .child(currentFirebaseUser!.uid)
        .child("newRideStatus")
        .once()
        .then((snap) {
      if (snap.snapshot.value != null) {
        getRideRequestId = snap.snapshot.value.toString();
      } else {
        Fluttertoast.showToast(msg: "This ride request do not exists.");
      }

      if (getRideRequestId == widget.userRideRequestDetails!.rideRequestId) {
        FirebaseDatabase.instance
            .ref()
            .child("driver")
            .child(currentFirebaseUser!.uid)
            .child("newRideStatus")
            .set("accepted");

        AssistantMethods.pauseLiveLocationUpdates();

        //trip started now - send driver to new tripScreen
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (c) => NewTripScreen(
                      userRideRequestDetails: widget.userRideRequestDetails,
                    )));
      } else {
        Fluttertoast.showToast(msg: "This Ride Request do not exists.");
      }
    });
  }
}
