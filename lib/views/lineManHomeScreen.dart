import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:household/views/loginscreen.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../Model/userModel.dart';

class lineManHomeScreen extends StatefulWidget {
  const lineManHomeScreen({Key? key}) : super(key: key);

  @override
  State<lineManHomeScreen> createState() => _lineManHomeScreenState();
}

class _lineManHomeScreenState extends State<lineManHomeScreen> {
  Future<UserModel> _getUsers() async {
    final _sharedprfs = await SharedPreferences.getInstance();
    final _id = _sharedprfs.getString('id');
    var data = await http.post(
        Uri.parse("http://192.168.68.121/API/shopping/getUserData.php"),
        body: {
          "id": _id,
        });
    var jsonData = jsonDecode(data.body);
    UserModel users = UserModel.fromJson(jsonData);
    // print(jsonData['name']);
    // print(users.name);
    return users;
  }
  @override
  Widget build(BuildContext context) {
    final List<String> images = [
      'images/carouselimages/mensfashion.jpg',
      'images/carouselimages/kidsfashion.jpg',
      'images/carouselimages/womenfashion.jpg'
    ];
    List<Widget>generateImagesTiles(){
      return images.map((element)=>ClipRRect(
        child:Image.asset(element,
          fit: BoxFit.cover,),
        borderRadius: BorderRadius.circular(15.0),
      )). toList();
    }
    return Scaffold(
      appBar: AppBar(
        title: Text('House Hold'),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () async {
                final _sharedprfs = await SharedPreferences.getInstance();
                await _sharedprfs.clear();
                _sharedprfs.remove("login");
                Navigator.of(context).pushReplacement(
                    (MaterialPageRoute(builder: (context) => loginscreen())));
              },
              icon: Icon(Icons.logout))
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            FutureBuilder(
                future: _getUsers(),
                builder: (BuildContext context,
                    AsyncSnapshot<UserModel> snapshot) {
                  if (!snapshot.hasData) {
                    return Text("loading...");
                  } else {
                    return Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        UserAccountsDrawerHeader(
                          accountName: Text(
                            snapshot.data!.name.toString(),
                            style:
                            TextStyle(color: Colors.white),
                          ),
                          accountEmail: Text(
                            snapshot.data!.email.toString(),
                            style:
                            TextStyle(color: Colors.white),
                          ),
                        ),
                        InkWell(
                          onTap: (){},
                          child: ListTile(
                            title: Text('Home Page'),
                            leading: Icon(Icons.home,color: Colors.green,),
                          ),
                        ),
                        InkWell(
                          onTap: (){},
                          child: ListTile(
                            title: Text('Complaints'),
                            leading: Icon(Icons.person,color: Colors.green,),
                          ),
                        ),
                        Divider(),
                        InkWell(
                          onTap: (){},
                          child: ListTile(
                            title: Text('About'),
                            leading: Icon(Icons.help,color: Colors.blue,),
                          ),
                        ),
                      ],
                    );
                  }
                }),
          ],
        ),
      ),
    );
  }
}

