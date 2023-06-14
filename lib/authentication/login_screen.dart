import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
// import 'package:lazis/authentication/signup_screen.dart';
import 'package:lazis/splashScreen/splash_screen.dart';
import '../global/global.dart';
import '../widgets/progress_dialog.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();
  validateFrom() {
    if (emailTextEditingController.text.isEmpty) {
      Fluttertoast.showToast(msg: "kolom tidak boleh kosong");
    } else if (!emailTextEditingController.text.contains("@")) {
      Fluttertoast.showToast(msg: "email tidak valid");
    } else if (passwordTextEditingController.text.isEmpty) {
      Fluttertoast.showToast(msg: "password harus diisi");
    } else {
      LoginDriver();
    }
  }

  // ignore: non_constant_identifier_names
  LoginDriver() async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext c) {
          return ProgressDialog(
            message: "Prosses, harap tunggu",
          );
        });
    final User? firebaseUser = (await fAuth
            .signInWithEmailAndPassword(
      email: emailTextEditingController.text.trim(),
      password: passwordTextEditingController.text.trim(),
    )
            .catchError((msg) {
      Navigator.pop(context);
      Fluttertoast.showToast(msg: "Error: $msg");
    }))
        .user;

    if (firebaseUser != null) {
      DatabaseReference driverRef =
          FirebaseDatabase.instance.ref().child("driver");
      driverRef.child(firebaseUser.uid).once().then((driverKey) {
        final snap = driverKey.snapshot;
        if (snap.value != null) {
          currentFirebaseUser = firebaseUser;
          Fluttertoast.showToast(msg: "Login Success.");
          Navigator.push(
              context, MaterialPageRoute(builder: (c) => const SplashScreen()));
        } else {
          Fluttertoast.showToast(msg: "No record exist with this email.");
          fAuth.signOut();
          Navigator.push(
              context, MaterialPageRoute(builder: (c) => const SplashScreen()));
        }
      });
    } else {
      // ignore: use_build_context_synchronously
      Navigator.pop(context);
      Fluttertoast.showToast(msg: "Login Gagal");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        // centerTitle: true,
        backgroundColor: Colors.transparent,
        title: Image.asset(
          "images/logo.png",
          width: 115,
          // height: 160,
        ),
      ),
      backgroundColor: const Color.fromARGB(255, 0, 0, 0),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              const SizedBox(
                height: 150,
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Image.asset(
                  "images/login.png",
                  width: 160,
                  // height: 160,
                ),
              ),
              const SizedBox(
                height: 30,
              ),

              Container(
                child: TextFormField(
                  controller: emailTextEditingController,
                  keyboardType: TextInputType.emailAddress,
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                  decoration: const InputDecoration(
                    labelText: "Email",
                    // hintText: "Email",
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 3, color: Colors.white),
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    // border: const BorderRadius.circular(50.0),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color.fromARGB(255, 244, 144, 3),
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    hintStyle: TextStyle(
                      color: Color.fromARGB(255, 244, 144, 3),
                      fontSize: 15,
                    ),
                    labelStyle: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Container(
                child: TextField(
                  controller: passwordTextEditingController,
                  keyboardType: TextInputType.text,
                  obscureText: true,
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                  decoration: const InputDecoration(
                    labelText: "Password",
                    // hintText: "Password",
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 3, color: Colors.white),
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Color.fromARGB(255, 244, 144, 3)),
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    hintStyle: TextStyle(
                      color: Color.fromARGB(255, 244, 144, 3),
                      fontSize: 15,
                    ),
                    labelStyle: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              ElevatedButton(
                  onPressed: () {
                    validateFrom();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 244, 144, 3),
                  ),
                  child: const Text(
                    "Login",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  )),
              const SizedBox(
                height: 30,
              ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: [
              //     const Text(

              //         "Belum Punya Akun?",
              //         style: TextStyle(color: Colors.black),

              //       // onPressed: (){
              //       //   Navigator.push(context, MaterialPageRoute(builder: (c) => SignUpScreen()));
              //       // },
              //     ),
              //     const SizedBox(width: 10,),
              //     InkWell(
              //       child: const Text(
              //         'Klik disini.',
              //         style: TextStyle(
              //           color: Colors.blue,
              //         ),
              //       ),
              //       onTap: () {
              //         Navigator.push(context, MaterialPageRoute(builder: (c) => SignUpScreen()));
              //       },
              //     ),
              //   ],
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
