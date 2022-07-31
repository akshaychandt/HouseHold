import 'dart:async';
import 'package:flutter/material.dart';
import 'package:household/Screens/LineManScreen/lineManHomeScreen.dart';
import 'package:household/Screens/loginscreen.dart';
import 'package:household/Screens/userHomeScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class splashscreen extends StatefulWidget {

  const splashscreen({Key? key}) : super(key: key);

  @override
  State<splashscreen> createState() => _splashscreenState();
}

class _splashscreenState extends State<splashscreen> {
  @override
  void initState() {
    Timer(Duration(seconds: 2),()async{
      final _sharedprfs = await SharedPreferences.getInstance();
      final _role = _sharedprfs.getString('role');
      if(_sharedprfs.containsKey("login")) {
        if(_role == 'user'){
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => (homeScreen())));
        }
        else if(_role == 'lineman'){
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => (lineManHomeScreen())));
        }
      }
      else{
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => (loginscreen())));
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset('assets/images/products/logo.png',
          height: 150,
          width: 150,),
      ),
    );
  }
}
