
import 'package:lazis/infoHandler/app_info.dart';
import 'package:flutter/material.dart';
import 'package:lazis/models/user_ride_request_information.dart';
import 'package:lazis/widgets/history_design_ui.dart';
import 'package:provider/provider.dart';

class RiwayatTabPage extends StatefulWidget {
  const RiwayatTabPage(
      {Key? key, UserRideRequestInformation? userRideRequestDetails})
      : super(key: key);

  @override
  _RiwayatTabPageState createState() => _RiwayatTabPageState();
}

class _RiwayatTabPageState extends State<RiwayatTabPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor: Colors.transparent,
        title: const Text(
          "Riwayat",
          style: TextStyle(
            color: Color.fromARGB(255, 244, 144, 3),
            fontSize: 24,
          ),
        ),
      ),
      body: Container(
        child: Column(
          children: [
            ListView.separated(
              separatorBuilder: (context, i) => const Divider(
                color: Colors.transparent,
                thickness: 2,
                height: 2,
              ),
              itemBuilder: (context, i) {
                return Card(
                  color: Colors.white54,
                  child: HistoryDesignUIWidget(
                    tripsHistoryModel:
                        Provider.of<AppInfo>(context, listen: false)
                            .allTripsHistoryInformationList[i],
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
      ),
    );
  }
}
