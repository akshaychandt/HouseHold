import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:household/views/loginscreen.dart';
import 'package:http/http.dart' as http;

import '../Constant.dart';

class registrationscreen extends StatefulWidget {
  const registrationscreen({Key? key}) : super(key: key);

  @override
  State<registrationscreen> createState() => _registrationscreenState();
}
class _registrationscreenState extends State<registrationscreen> {
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _formkey = GlobalKey<FormState>();

  postData(BuildContext ctx) async{
    var response =await http.post(Uri.parse('${BASE_URL}registration.php'),
        body: {
          "name" : _nameController.text,
          "email" : _emailController.text,
          "username" : _usernameController.text,
          "password" : _passwordController.text,
          "mobile" : _phoneController.text,
        });
    // print(response.body);
    if(response.body == "true") {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => loginscreen()));
    }
    else{
      ScaffoldMessenger.of(ctx).showSnackBar(SnackBar(
          behavior: SnackBarBehavior.floating,
          margin: EdgeInsets.all(10),
          content: Text("Please Check Your Connection")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white10
      ,
      body: SingleChildScrollView(
        child: Form(
          key: _formkey,
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
                child: Column(
                  children: [
                    SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      validator: (value){
                        if(value!.isEmpty){
                          return "is Empty";
                        }
                        return null;
                      },
                      controller: _nameController,
                      style: TextStyle(
                        color: Colors.white,
                      ),
                      cursorColor: Colors.white,
                      decoration: InputDecoration(
                        hintText: "Name",
                        hintStyle: TextStyle(color: Colors.white54),
                        prefixIcon: Icon(Icons.drive_file_rename_outline,
                            color: Colors.white),

                      ),
                    ),
                    TextFormField(
                      validator: (value){
                        if(value!.isEmpty){
                          return "is Empty";
                        }
                        return null;
                      },
                      controller: _emailController,
                      style: TextStyle(
                        color: Colors.white,
                      ),
                      cursorColor: Colors.white,
                      decoration: InputDecoration(
                        hintText: "Email",
                        hintStyle: TextStyle(color: Colors.white54),
                        prefixIcon: Icon(Icons.email,
                            color: Colors.white),

                      ),
                    ),
                    TextFormField(
                      validator: (value){
                        if(value!.isEmpty){
                          return "is Empty";
                        }
                        return null;
                      },
                      controller: _usernameController,
                      style: TextStyle(
                        color: Colors.white,
                      ),
                      cursorColor: Colors.white,
                      decoration: InputDecoration(
                        hintText: "Username",
                        hintStyle: TextStyle(color: Colors.white54),
                        prefixIcon: Icon(Icons.drive_file_rename_outline_outlined,
                            color: Colors.white),

                      ),
                    ),
                    TextFormField(
                      validator: (value){
                        if(value!.isEmpty){
                          return "is Empty";
                        }
                        return null;
                      },
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
                    TextFormField(
                      validator: (value){
                        if(value!.isEmpty){
                          return "is Empty";
                        }
                        return null;
                      },
                      controller: _phoneController,
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        hintText: "Phone",
                        hintStyle: TextStyle(color: Colors.white54),
                        prefixIcon: Icon(Icons.phone_android,
                            color: Colors.white),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Row(mainAxisAlignment:MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(onPressed: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>loginscreen()));
                        },
                            child: Text('Already have an account? Login',style: TextStyle(color: Colors.blue),)),
                        ElevatedButton.icon(onPressed: (){
                          if(_formkey.currentState!.validate()){
                          postData(context);
                          }
                          },
                          icon: Icon(Icons.login,color: Colors.black,),
                          label: Text("Register",style: TextStyle(
                              color: Colors.black
                          ),),
                          style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.grey),),),
                      ],
                    ),
                    SizedBox(
                      height: 35,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

}
