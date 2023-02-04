// import 'package:flutter/material.dart';
// import 'package:lazis/infoHandler/app_info.dart';
// import 'package:lazis/models/user_ride_request_information.dart';
// import 'package:lazis/widgets/history_design_ui.dart';
// import 'package:provider/provider.dart';
// import 'package:lazis/mainScreen/main_Screen.dart';

// class PermintaanTab extends StatefulWidget {
//   const PermintaanTab(
//       {Key? key, UserRideRequestInformation? userRideRequestDetails})
//       : super(key: key);

//   @override
//   State<PermintaanTab> createState() => _PermintaanTabState();
// }

// class _PermintaanTabState extends State<PermintaanTab> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         automaticallyImplyLeading: false,
//         centerTitle: true,
//         backgroundColor: const Color(0xffF67034),
//         title: const Text(
//           "Permintaan",
//           style: TextStyle(
//             color: Colors.white,
//             fontSize: 24,
//           ),
//         ),
//       ),
//       body: Column(
//         children: [
//           //total number of trips
//           ListView.separated(
//             separatorBuilder: (context, i) => const Divider(
//               color: Colors.grey,
//               thickness: 2,
//               height: 2,
//             ),
//             itemBuilder: (context, i) {
//               return Card(
//                 color: Colors.white54,
//                 child: HistoryDesignUIWidget(
//                   tripsHistoryModel:
//                       Provider.of<AppInfo>(context, listen: false)
//                           .allTripsHistoryInformationList[i],
//                 ),
//               );
//             },
//             itemCount: Provider.of<AppInfo>(context, listen: false)
//                 .allTripsHistoryInformationList
//                 .length,
//             physics: const ClampingScrollPhysics(),
//             shrinkWrap: true,
//           ),
//         ],
//       ),
//     );
//   }
// }
