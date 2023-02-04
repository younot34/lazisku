import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:lazis/assistants/assistant_methods.dart';
import 'package:lazis/infoHandler/app_info.dart';
import 'package:flutter/material.dart';
import 'package:lazis/mainScreen/trips_history_screen.dart';
import 'package:lazis/models/user_ride_request_information.dart';
import 'package:lazis/widgets/history_design_ui.dart';
import 'package:lazis/widgets/progress_dialog.dart';
import 'package:provider/provider.dart';
import 'package:lazis/mainScreen/new_trip_screen.dart';


class EarningsTabPage extends StatefulWidget {
  const EarningsTabPage({Key? key, UserRideRequestInformation? userRideRequestDetails}) : super(key: key);
  

  @override
  _EarningsTabPageState createState() => _EarningsTabPageState();
}



class _EarningsTabPageState extends State<EarningsTabPage> {
  
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar:  AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor: const Color(0xffF67034),
        title: const Text(
                      "History",
                      
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                      ),
                    ),
      ),
      body: Container(
        
        color: const Color.fromARGB(205, 243, 243, 243),
        child: Column(
          children: [
    
            //total number of trips
            ListView.separated(
              separatorBuilder: (context, i)=> const Divider(
                color: Colors.grey,
                thickness: 2,
                height: 2,
              ),
              itemBuilder: (context, i)
              {
                return Card(
                  color: Colors.white54,
                  child: HistoryDesignUIWidget(
                    tripsHistoryModel: Provider.of<AppInfo>(context, listen: false).allTripsHistoryInformationList[i],
                  ),
                );
              },
              itemCount: Provider.of<AppInfo>(context, listen: false).allTripsHistoryInformationList.length,
              physics: const ClampingScrollPhysics(),
              shrinkWrap: true,
            ),
          ],
        ),
      ),
    );
  }
}
