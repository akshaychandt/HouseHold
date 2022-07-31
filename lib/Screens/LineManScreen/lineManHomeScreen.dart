import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:household/Constant.dart';
import 'package:household/Loader/ColorLoader.dart';
import 'package:household/Model/complantModel.dart';
import 'package:household/Screens/about.dart';
import 'package:household/Screens/loginscreen.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../Model/userModel.dart';

class lineManHomeScreen extends StatefulWidget {
  const lineManHomeScreen({Key? key}) : super(key: key);

  @override
  State<lineManHomeScreen> createState() => _lineManHomeScreenState();
}

class _lineManHomeScreenState extends State<lineManHomeScreen> {
  Future<UserModel> _getUsers() async {
    final _sharedprfs = await SharedPreferences.getInstance();
    final _id = _sharedprfs.getString('id');
    var data = await http.post(Uri.parse("${BASE_URL}get_lineman.php"), body: {
      "id": _id,
    });
    var jsonData = jsonDecode(data.body);
    UserModel users = UserModel.fromJson(jsonData);
    return users;
  }

  Future<List<ComplaintModel>> _getComplaint() async {
    var data = await http.get(Uri.parse("${BASE_URL}view_complaint.php"));
    List jsonData = jsonDecode(data.body);
    List<ComplaintModel> complaints = jsonData
        .map<ComplaintModel>((json) => ComplaintModel.fromJson(json))
        .toList();
    return complaints;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('House Hold'),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
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
                builder:
                    (BuildContext context, AsyncSnapshot<UserModel> snapshot) {
                  if (!snapshot.hasData) {
                    return Center(child: ColorLoader());
                  } else {
                    return Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        UserAccountsDrawerHeader(
                          accountName: Text(
                            snapshot.data!.name.toString(),
                            style: TextStyle(color: Colors.white),
                          ),
                          accountEmail: Text(
                            snapshot.data!.email.toString(),
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        InkWell(
                          onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => lineManHomeScreen())),
                          child: ListTile(
                            title: Text('Home Page'),
                            leading: Icon(
                              Icons.home,
                              color: Colors.green,
                            ),
                          ),
                        ),
                        Divider(),
                        InkWell(
                          onTap: () => Navigator.push(context,
                              MaterialPageRoute(builder: (context) => About())),
                          child: ListTile(
                            title: Text('About'),
                            leading: Icon(
                              Icons.help,
                              color: Colors.blue,
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () async {
                            final _sharedprfs =
                                await SharedPreferences.getInstance();
                            await _sharedprfs.clear();
                            _sharedprfs.remove("login");
                            Navigator.of(context).pushReplacement(
                                (MaterialPageRoute(
                                    builder: (context) => loginscreen())));
                          },
                          child: ListTile(
                            title: Text('Logout'),
                            leading: Icon(
                              Icons.login_outlined,
                              color: Colors.blue,
                            ),
                          ),
                        ),
                      ],
                    );
                  }
                }),
          ],
        ),
      ),
      body: FutureBuilder(
          future: _getComplaint(),
          builder: (BuildContext context,
              AsyncSnapshot<List<ComplaintModel>> snapshot) {
            if (!snapshot.hasData) {
              return Center(child: ColorLoader());
            } else {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (BuildContext, index) {
                  return Card(
                    child: Container(
                      padding: EdgeInsets.all(kDefaultPaddin),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: ListTile(
                          leading: Text(
                            snapshot.data![index].date.toString(),
                            style: TextStyle(color: Colors.black,fontSize: 15),
                          ),
                          title: Text(snapshot.data![index].complaint.toString(),style: TextStyle(fontSize: 20),),
                          subtitle:
                              Text('Post.no/Meter.no:${snapshot.data![index].postNumber.toString()}',style: TextStyle(fontSize: 15)),
                          trailing: CircleAvatar(
                            child: IconButton(
                              icon: Icon(Icons.check),
                              onPressed: () async {
                                final _complaint_id =
                                    snapshot.data![index].complaintId;
                                var data = await http.post(
                                    Uri.parse("${BASE_URL}update_complaint.php"),
                                    body: {
                                      "complaint_id": _complaint_id,
                                    });
                                var jsonData = jsonDecode(data.body);
                                if (jsonData['message'] == 'true') {
                                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                      behavior: SnackBarBehavior.floating,
                                      margin: EdgeInsets.only(
                                          bottom: 100, left: 20, right: 20),
                                      content: Text(
                                        "Complaint Solved",
                                        style: TextStyle(color: Colors.greenAccent),
                                      )));
                                  setState(() {
                                    _getComplaint();
                                  });
                                }
                              },
                            ),
                          )
                          ),
                    ),
                  );
                },
              );
            }
          }),
    );
  }
}
