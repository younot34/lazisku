import 'dart:async';
// import 'dart:html';

import 'package:flutter/material.dart';
import 'package:lazis/authentication/login_screen.dart';
import 'package:lazis/authentication/signup_screen.dart';
import 'package:lazis/global/global.dart';
import 'package:lazis/mainScreen/main_Screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  
  @override
  _SplashScreenState createState() =>_SplashScreenState();
  
}

class _SplashScreenState extends State<SplashScreen>{
  startTimer(){
    
    Timer(const Duration(seconds:2), () async {
      if(await fAuth.currentUser != null){
        currentFirebaseUser = fAuth.currentUser;
        Navigator.push(context, MaterialPageRoute(builder: (c)=> MainScreen()));
      }
      else{
        Navigator.push(context, MaterialPageRoute(builder: (c)=> LoginScreen()));
      }
      
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    startTimer();
  }
  
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor:Colors.white ,
      body: 
      Center(
        
        child: 
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            
          
          children: [
            
            Image.asset("images/logo.png",
            width: 200,
            
            ),
            const SizedBox(height: 10,),
            const Text("Driver LazisMu",
            style: TextStyle(
              fontSize: 26,
              color: Colors.black,
              fontWeight: FontWeight.bold,
        ),),
          ],
        ),

      ),

    ) ;
  }
}