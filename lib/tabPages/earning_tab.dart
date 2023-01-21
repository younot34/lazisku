import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:lazis/assistants/assistant_methods.dart';
import 'package:lazis/infoHandler/app_info.dart';
import 'package:flutter/material.dart';
import 'package:lazis/mainScreen/trips_history_screen.dart';
import 'package:lazis/models/user_ride_request_information.dart';
import 'package:lazis/widgets/progress_dialog.dart';
import 'package:provider/provider.dart';
import 'package:lazis/mainScreen/new_trip_screen.dart';


class EarningsTabPage extends StatefulWidget {
  const EarningsTabPage({Key? key, UserRideRequestInformation? userRideRequestDetails}) : super(key: key);
  
  get userRideRequestDetails => userRideRequestDetails(NewTripScreen());

  @override
  _EarningsTabPageState createState() => _EarningsTabPageState();
}



class _EarningsTabPageState extends State<EarningsTabPage> {
  UserRideRequestInformation? userRideRequestDetails;
  String? buttonTitle = "accept";
  Color? buttonColor = Colors.green;

  Set<Marker> setOfMarkers = Set<Marker>();
  Set<Circle> setOfCircle = Set<Circle>();
  Set<Polyline> setOfPolyline = Set<Polyline>();
  List<LatLng> polyLinePositionCoordinates = [];
  PolylinePoints polylinePoints = PolylinePoints();

  double mapPadding = 0;
  BitmapDescriptor? iconAnimatedMarker;
  var geoLocator = Geolocator();
  Position? onlineDriverCurrentPosition;

  String rideRequestStatus = "accepted";

  String durationFromOriginToDestination = "";

  bool isRequestDirectionDetails = false;

  
  @override
  Widget build(BuildContext context) {
    
    return Container(
      
      color: Colors.grey,
      child: Column(
        children: [

          //earnings
          Container(
            color: const Color(0xffF67034),
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 40),
              child: Column(
                children: const [

                  Text(
                    "History",
                    
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 40,
                    ),
                  ),

                  SizedBox(height: 10,),

                  // Text(
                  //   "\$ " + Provider.of<AppInfo>(context, listen: false).driverTotalEarnings,
                  //   style: const TextStyle(
                  //     color: Colors.grey,
                  //     fontSize: 60,
                  //     fontWeight: FontWeight.bold,
                  //   ),
                  // ),

                ],
              ),
            ),
          ),

          //total number of trips
          ElevatedButton(
              onPressed: ()
              {
                Navigator.push(context, MaterialPageRoute(builder: (c)=> TripsHistoryScreen()));
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white54
              ),
              
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Row(
                  children: [

                    Image.asset(
                      "images/car_logo.png",
                      width: 100,
                    ),

                    const SizedBox(
                      width: 6,
                    ),

                    const Text(
                      "perjalanan selesai",
                      style: TextStyle(
                        color: Colors.black54,
                      ),
                    ),

                    Expanded(
                      child: Container(
                        child: Text(
                          Provider.of<AppInfo>(context, listen: false).allTripsHistoryInformationList.length.toString(),
                          textAlign: TextAlign.end,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
          ),
          ElevatedButton.icon(
                      onPressed: ()async

                      {
                          
                        //[driver has arrived at user PickUp Location] - Arrived Button
                        if(rideRequestStatus == "accept")
                        {
                          
                          rideRequestStatus = "arrived";

                          FirebaseDatabase.instance.ref()
                              .child("All Ride Requests")
                              .child(widget.userRideRequestDetails!.rideRequestId!)
                              .child("status")
                              .set(rideRequestStatus);

                          setState(() {
                           buttonTitle = "Let's Go"; //start the trip
                            buttonColor = Colors.lightGreen;
                          }); 

                          showDialog(
                              context: context,
                              barrierDismissible: false,
                              builder: (BuildContext c)=> NewTripScreen()
                          );
                          Navigator.push(context, MaterialPageRoute(builder: (c)=> NewTripScreen()));

                          // await drawPolyLineFromOriginToDestination(
                          //     widget.userRideRequestDetails!.originLatLng!,
                          //     widget.userRideRequestDetails!.destinationLatLng!
                          // );

                        }
                        //[user has already sit in driver's car. Driver start trip now] - Lets Go Button
                        // else if(rideRequestStatus == "rute")
                        // {
                        //   rideRequestStatus = "ontrip";

                        //   FirebaseDatabase.instance.ref()
                        //       .child("All Ride Requests")
                        //       .child(widget.userRideRequestDetails!.rideRequestId!)
                        //       .child("status")
                        //       .set(rideRequestStatus);

                        //   setState(() {
                        //     buttonTitle = "End Trip"; //end the trip
                        //     buttonColor = Colors.redAccent;
                        //   });
                        // }
                        // //[user/Driver reached to the dropOff Destination Location] - End Trip Button
                        // else if(rideRequestStatus == "ontrip")
                        // {
                        //   endTripNow();
                        // }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: buttonColor,
                      ),
                      icon: const Icon(
                        Icons.directions_car,
                        color: Colors.white,
                        size: 25,
                      ),
                      label: Text(
                        buttonTitle!,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
          // Positioned(
          //   bottom: 0,
          //   left: 0,
          //   right: 0,
          //   child: Container(
          //     decoration: const BoxDecoration(
          //       color: Colors.black,
          //       borderRadius: BorderRadius.only(
          //         topLeft: Radius.circular(18),
          //       ),
          //       boxShadow:
          //       [
          //         BoxShadow(
          //           color: Colors.white30,
          //           blurRadius: 18,
          //           spreadRadius: .5,
          //           offset: Offset(0.6, 0.6),
          //         ),
          //       ],
          //     ),
          //     child: Padding(
          //       padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
          //       child: Column(
          //         children: [

          //           //duration
          //           Text(
          //             durationFromOriginToDestination,
          //             style: const TextStyle(
          //               fontSize: 16,
          //               fontWeight: FontWeight.bold,
          //               color: Colors.lightGreenAccent,
          //             ),
          //           ),

          //           const SizedBox(height: 18,),

          //           const Divider(
          //             thickness: 2,
          //             height: 2,
          //             color: Colors.grey,
          //           ),

          //           const SizedBox(height: 8,),

          //           //user name - icon
          //           Row(
          //             children: [
          //               Text(
          //                 widget.userRideRequestDetails!.userName!,
          //                 style: const TextStyle(
          //                   fontSize: 20,
          //                   fontWeight: FontWeight.bold,
          //                   color: Colors.lightGreenAccent,
          //                 ),
          //               ),
          //               const Padding(
          //                 padding: EdgeInsets.all(10.0),
          //                 child: Icon(
          //                   Icons.phone_android,
          //                   color: Colors.grey,
          //                 ),
          //               ),
          //             ],
          //           ),

          //           const SizedBox(height: 18,),

          //           //user PickUp Address with icon
          //           Row(
          //             children: [
          //               Image.asset(
          //                 "images/origin.png",
          //                 width: 30,
          //                 height: 30,
          //               ),
          //               const SizedBox(width: 14,),
          //               Expanded(
          //                 child: Container(
          //                   child: Text(
          //                     widget.userRideRequestDetails!.originAddress!,
          //                     style: const TextStyle(
          //                       fontSize: 16,
          //                       color: Colors.grey,
          //                     ),
          //                   ),
          //                 ),
          //               ),
          //             ],
          //           ),

          //           const SizedBox(height: 20.0),

          //           //user DropOff Address with icon
          //           Row(
          //             children: [
          //               Image.asset(
          //                 "images/destination.png",
          //                 width: 30,
          //                 height: 30,
          //               ),
          //               const SizedBox(width: 14,),
          //               Expanded(
          //                 child: Container(
          //                   child: Text(
          //                     widget.userRideRequestDetails!.destinationAddress!,
          //                     style: const TextStyle(
          //                       fontSize: 16,
          //                       color: Colors.grey,
          //                     ),
          //                   ),
          //                 ),
          //               ),
          //             ],
          //           ),

          //           const SizedBox(height: 24,),

          //           const Divider(
          //             thickness: 2,
          //             height: 2,
          //             color: Colors.grey,
          //           ),

          //           const SizedBox(height: 10.0),

          //           ElevatedButton.icon(
          //             onPressed: () async
          //             {
          //               //[driver has arrived at user PickUp Location] - Arrived Button
          //               if(rideRequestStatus == "rute")
          //               {
                          
          //                 rideRequestStatus = "rute";

          //                 FirebaseDatabase.instance.ref()
          //                     .child("All Ride Requests")
          //                     .child(widget.userRideRequestDetails!.rideRequestId!)
          //                     .child("status")
          //                     .set(rideRequestStatus);

          //                 setState(() {
          //                   buttonTitle = "Let's Go"; //start the trip
          //                   buttonColor = Colors.lightGreen;
          //                 });

          //                 showDialog(
          //                     context: context,
          //                     barrierDismissible: false,
          //                     builder: (BuildContext c)=> ProgressDialog(
          //                       message: "Loading...",
          //                     ),
          //                 );

          //                 // await drawPolyLineFromOriginToDestination(
          //                 //     widget.userRideRequestDetails!.originLatLng!,
          //                 //     widget.userRideRequestDetails!.destinationLatLng!
          //                 // );

          //                 Navigator.push(context, MaterialPageRoute(builder: (c)=> NewTripScreen(
          //                 userRideRequestDetails: widget.userRideRequestDetails,
          //                 )));
          //               }
                        
          //             },
          //             style: ElevatedButton.styleFrom(
          //               backgroundColor: buttonColor,
          //             ),
          //             icon: const Icon(
          //               Icons.directions_car,
          //               color: Colors.white,
          //               size: 25,
          //             ),
          //             label: Text(
          //               buttonTitle!,
          //               style: const TextStyle(
          //                 color: Colors.white,
          //                 fontSize: 14,
          //                 fontWeight: FontWeight.bold,
          //               ),
          //             ),
          //           ),

          //         ],
          //       ),
          //     ),
          //   ),
          // )
        ],
      ),
    );
  }
}
