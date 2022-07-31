import 'dart:convert';
import 'package:household/Constant.dart';
import 'package:household/Screens/registrationscreen.dart';
import 'package:household/Screens/userHomeScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'LineManScreen/lineManHomeScreen.dart';

class loginscreen extends StatefulWidget {
  const loginscreen({Key? key}) : super(key: key);

  @override
  State<loginscreen> createState() => _loginscreenState();
}

class _loginscreenState extends State<loginscreen> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  Future postData(BuildContext ctx) async {
    var response =await http.post(Uri.parse('${BASE_URL}login.php'),
        body: {
          "username" : _usernameController.text,
          "password" : _passwordController.text,
        });
    var jsonData = jsonDecode(response.body);
    if(jsonData['message'] == "true"){
      final _role =jsonData['role'];
      final _sharedprfs = await SharedPreferences.getInstance();
      _sharedprfs.setString('id', jsonData['id']);
      _sharedprfs.setString('role', jsonData['role']);
      _sharedprfs.setBool("login", true);
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
      ScaffoldMessenger.of(ctx).showSnackBar(SnackBar(
          behavior: SnackBarBehavior.floating,
          margin: EdgeInsets.all(10),
          content: Text("Username and password does not match")));
    }
    // return users;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black
      ,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 100,
            ),
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
              margin: EdgeInsets.symmetric(vertical: 85, horizontal: 20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white10,
                boxShadow: [
                  BoxShadow(
                      color: Theme.of(context).hintColor.withOpacity(0.2),
                      offset: Offset(0, 10),
                      blurRadius: 20)
                ],
              ),
              child: Form(child: Column(
                children: [
                  SizedBox(
                    height: 45,
                  ),
                  TextField(
                    controller: _usernameController,
                    style: TextStyle(
                      color: Colors.white,
                    ),
                    cursorColor: Colors.white,
                    decoration: InputDecoration(
                      hintText: "Username",
                      hintStyle: TextStyle(color: Colors.white54),
                      prefixIcon: Icon(Icons.email,
                        color: Colors.white,),
                    ),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  TextField(
                    controller: _passwordController,
                    style: TextStyle(color: Colors.white),
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: "Password",
                      hintStyle: TextStyle(color: Colors.white54),
                      prefixIcon: Icon(Icons.password,
                          color: Colors.white),
                    ),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>registrationscreen()));
                      },
                          child: Text('Dont have an account? Sign Up',style: TextStyle(color: Colors.blue))),
                      ElevatedButton.icon(onPressed: (){postData(context);},
                        icon: Icon(Icons.login,color: Colors.black,),
                        label: Text("Login",style: TextStyle(
                            color: Colors.black
                        ),),
                        style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.grey),),),
                    ],
                  ),
                  SizedBox(
                    height: 45,
                  ),
                ],
              )),
            )
          ],
        ),
      ),
    );
  }
}
