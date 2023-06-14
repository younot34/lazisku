import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lazis/global/global.dart';
import 'package:lazis/splashScreen/splash_screen.dart';

class CarInfoScreen extends StatefulWidget {
  const CarInfoScreen({super.key});

  @override
  State<CarInfoScreen> createState() => _CarInfoScreenState();
}

class _CarInfoScreenState extends State<CarInfoScreen> {
  TextEditingController merkmobilTextEditingController =
      TextEditingController();
  TextEditingController platnomorTextEditingController =
      TextEditingController();
  TextEditingController warnamobilTextEditingController =
      TextEditingController();

  List<String> merkMobilList = ["Lexus", "Avanza", "APV", "Inova", "Panter"];
  String? selectedmerkMobil;

  saveMobilInfo() {
    Map driverMobilInfoMap = {
      "type mobil": merkmobilTextEditingController.text.trim(),
      "platnomor": platnomorTextEditingController.text.trim(),
      "warna mobil": warnamobilTextEditingController.text.trim(),
      "merk mobil": selectedmerkMobil,
    };
    DatabaseReference driverRef =
        FirebaseDatabase.instance.ref().child("driver");
    driverRef
        .child(currentFirebaseUser!.uid)
        .child("detail_mobil")
        .set(driverMobilInfoMap);

    Fluttertoast.showToast(msg: "Detail Mobil berhasil disimpan.");
    Navigator.push(
        context, MaterialPageRoute(builder: (c) => const SplashScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange,
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Image.asset("images/logo.png"),
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              "Info Mobil",
              style: TextStyle(
                fontSize: 26,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            TextField(
              controller: merkmobilTextEditingController,
              keyboardType: TextInputType.text,
              style: const TextStyle(
                color: Colors.white,
              ),
              decoration: const InputDecoration(
                labelText: "type Mobil",
                hintText: "type Mobil",
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
                hintStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                ),
                labelStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                ),
              ),
            ),
            TextField(
              controller: platnomorTextEditingController,
              keyboardType: TextInputType.text,
              style: const TextStyle(
                color: Colors.white,
              ),
              decoration: const InputDecoration(
                labelText: "Nomor Plat",
                hintText: "Nomor Plat",
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
                hintStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                ),
                labelStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                ),
              ),
            ),
            TextField(
              controller: warnamobilTextEditingController,
              keyboardType: TextInputType.text,
              style: const TextStyle(
                color: Colors.white,
              ),
              decoration: const InputDecoration(
                labelText: "Warna Mobil",
                hintText: "Warna Mobil",
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
                hintStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                ),
                labelStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            DropdownButton(
                iconSize: 40,
                dropdownColor: Colors.orange,
                hint: const Text(
                  "Pilih Merk Mobil",
                  style: TextStyle(
                    fontSize: 14.0,
                    color: Colors.white,
                  ),
                ),
                value: selectedmerkMobil,
                onChanged: (newValues) {
                  setState(() {
                    selectedmerkMobil = newValues.toString();
                  });
                },
                items: merkMobilList.map((mobil) {
                  return DropdownMenuItem(
                    value: mobil,
                    child: Text(
                      mobil,
                      style: const TextStyle(color: Colors.white),
                    ),
                  );
                }).toList()),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
                onPressed: () {
                  if (warnamobilTextEditingController.text.isNotEmpty &&
                      platnomorTextEditingController.text.isNotEmpty &&
                      merkmobilTextEditingController.text.isNotEmpty &&
                      selectedmerkMobil != null) {
                    saveMobilInfo();
                  }
                  //Navigator.push(context, MaterialPageRoute(builder: (c) => CarInfoScreen()));
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 32, 144, 36),
                ),
                child: const Text(
                  "Simpan",
                  style: TextStyle(
                    color: Colors.white54,
                    fontSize: 18,
                  ),
                )),
          ],
        ),
      )),
    );
  }
}
