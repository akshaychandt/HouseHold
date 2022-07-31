import 'dart:convert';
import 'package:lottie/lottie.dart';
import 'package:flutter/material.dart';
import 'package:household/Constant.dart';
import 'package:household/Model/countModel.dart';
import 'package:household/Model/powerconsumptionmodel.dart';
import 'package:household/Screens/about.dart';
import 'package:household/Screens/cart.dart';
import 'package:household/Screens/loginscreen.dart';
import 'package:household/Screens/ordersscreen.dart';
import 'package:household/Screens/productsScreen.dart';
import 'package:http/http.dart' as http;
import 'package:permission_handler/permission_handler.dart' as p;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Model/userModel.dart';
import '../Loader/ColorLoader.dart';
import 'favourites.dart';
import 'package:badges/badges.dart';
import 'package:background_sms/background_sms.dart';

class homeScreen extends StatefulWidget {
  const homeScreen({Key? key}) : super(key: key);
  @override
  State<homeScreen> createState() => _homeScreenState();
}

class _homeScreenState extends State<homeScreen> {
  get_meter_no() async {
    final sharedprfs = await SharedPreferences.getInstance();
    var _user_id =  sharedprfs.getString('id');
    var data = await http.post(Uri.parse('${BASE_URL}view_user'),
    body: {
      "id" : _user_id
    });
    
    var jsonData = jsonDecode(data.body);
    var meter_number = jsonData['meter_number'];
    print(meter_number);
    var mobile_number = jsonData['mobile'];
    // sendSms('The house with meter number ${meter_number} has no elactricity', mobile_number);
  }
  sendSms() async {
    final sharedprfs = await SharedPreferences.getInstance();
    var _user_id =  sharedprfs.getString('id');
    print('user id =${_user_id}');
    var data = await http.post(Uri.parse('${BASE_URL}view_user.php'),
        body: {
          "id" : _user_id
        });
    var jsonData = jsonDecode(data.body);
    print("json data =${jsonData}");
    var meter_number = jsonData['meter_number'];
    print("meter number = ${meter_number}");
    var mobile_number = jsonData['mobile'];
    var complaint = 'The house with meter number: ${meter_number} has no elactricity';
    var response = await http.post(Uri.parse('${BASE_URL}send_complaint.php'),
        body: {
          "meter_number" : meter_number,
          "complaint" : complaint
        });
    var json = jsonDecode(response.body);
    print('complaint=${json}');
    if (await p.Permission.sms.status.isDenied) {
      print("premission denied");
      if (await p.Permission.sms.request().isDenied) {
        print("denied0");
        return;
      }
    }

    SmsStatus result = await BackgroundSms.sendMessage(
        phoneNumber: mobile_number, message: complaint,simSlot: 1);
    if (result == SmsStatus.sent) {
      print("Sent");
    } else {
      print("Failed");
    }
  }
  Future<UserModel> _getUsers() async {
    final _sharedprfs = await SharedPreferences.getInstance();
    final _id = _sharedprfs.getString('id');
    var data = await http.post(Uri.parse("${BASE_URL}get_userdata.php"), body: {
      "id": _id,
    });
    var jsonData = jsonDecode(data.body);
    UserModel users = UserModel.fromJson(jsonData);
    return users;
  }
  Future<PowerConsumptionModel> _getConsumption() async {
    final result = await http.get(Uri.parse(IOT_URL));
    // print(result.body);
    final data = PowerConsumptionModel.fromJson(jsonDecode(result.body));
    var sharedprfs = await SharedPreferences.getInstance();
    var total_consumption=0;
    // var consumption = sharedprfs.getString('total_consumption');
    // total_consumption = total_consumption+int.parse(data.feeds!.first.field1!);
    // sharedprfs.setString('total_consumption', total_consumption.toString());
    return data;
    // print(data.feeds!.first.field1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: Text('House Hold'),
          centerTitle: true,
          actions: [
            // IconButton(
            //   icon: Icon(Icons.search,color: kTextLightColor,),
            //   onPressed: () {},
            // ),
            // GestureDetector(
            //   onTap: () => Navigator.of(context)
            //       .push(MaterialPageRoute(builder: (context) => Cart())),
            //   child: Badge(
            //     badgeContent: Consumer<CountModel>(
            //         builder: (context, value, child) => Text(
            //             '${value.itemCount}',
            //             style: TextStyle(color: Colors.white))),
            //     animationDuration: Duration(milliseconds: 300),
            //     child: Icon(Icons.shopping_cart),
            //   ),
            // ),
            IconButton(
                onPressed: () => Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => Cart())),
                icon: Icon(Icons.shopping_cart)),
            IconButton(
                onPressed: () async {
                  final _sharedprfs = await SharedPreferences.getInstance();
                  await _sharedprfs.clear();
                  _sharedprfs.remove("login");
                  Navigator.of(context).pushReplacement(
                      (MaterialPageRoute(builder: (context) => loginscreen())));
                },
                icon: Icon(Icons.logout)),
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
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage(
                                      'assets/images/products/cover.png'),
                                  fit: BoxFit.cover),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                      builder: (context) => (homeScreen())));
                            },
                            child: ListTile(
                              title: Text('Home Page'),
                              leading: Icon(
                                Icons.home,
                                color: Colors.green,
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        ProductsScreen())),
                            child: ListTile(
                              title: Text('Products'),
                              leading: Icon(
                                Icons.dashboard,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: ()=> Navigator.push(context, MaterialPageRoute(builder: (context)=>OrdersScreen())),
                            child: ListTile(
                              title: Text('My Orders'),
                              leading: Icon(
                                Icons.shopping_basket,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () => Navigator.of(context).push(
                                MaterialPageRoute(
                                    builder: (context) => (Favourites()))),
                            child: ListTile(
                              title: Text('Wishlist'),
                              leading: Icon(
                                Icons.favorite,
                                color: Colors.red,
                              ),
                            ),
                          ),
                          Divider(),
                          InkWell(
                            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context)=>About())),
                            child: ListTile(
                              title: Text('About'),
                              leading: Icon(
                                Icons.help,
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
        body: buildBody(context) // GridView.builder,
        );
  }

  Column buildBody(BuildContext context) {
    return Column(
              children: [
                FutureBuilder(
                  future: _getUsers(),
                  builder: (BuildContext context,
                  AsyncSnapshot<UserModel> snapshot) {
                    if(!snapshot.hasData){
                      return Center(child: ColorLoader(),);
                    }
                    else{
                      return Text('Welcome ${snapshot.data!.name}',
                      style: TextStyle(fontWeight: FontWeight.w500,
                      fontSize: 25),);
                    }
                  },
                ),
                SizedBox(height: 50,),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
                  margin: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.black87,
                    boxShadow: [
                      BoxShadow(
                          color: Theme.of(context).hintColor.withOpacity(0.2),
                          offset: Offset(0, 10),
                          blurRadius: 20)
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FutureBuilder(
                        future: _getConsumption(),
                        builder: (BuildContext context,
                                 AsyncSnapshot<PowerConsumptionModel> snapshot) {
                          if(!snapshot.hasData){
                            return Center(child: ColorLoader(),);
                          }
                          else{

                            String vatts = snapshot.data!.feeds!.first.field1!;
                            var total_consumption_in_kWH = (double.parse(vatts));
                            var todays_consumption = snapshot.data!.feeds!.first.field2!;
                            var voltage = snapshot.data!.feeds!.first.field3!;
                            var powerloss = snapshot.data!.feeds!.last.field4!;
                            // var previos_consumption = (total_consumption_in_kWH)-(double.parse(todays_consumption));
                            if(powerloss == '0'){
                              sendSms();
                              // sendSms('The house with meter number 1234 has no elactricity', '6238038974');
                              // get_meter_no();
                              return SingleChildScrollView(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'No Elactricity',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    // Text('Previous elactricity consumption      : ${previos_consumption}kWh',style: TextStyle(color: Colors.white)),
                                  ],
                                ),
                              );
                            }
                            else{
                          return SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Total elactricity consumption            : ${vatts}kWh',
                                  style: TextStyle(color: Colors.white),
                                ),
                                Text(
                                  'Today\'s elactricity consumption        : ${todays_consumption}kWh',
                                  style: TextStyle(color: Colors.white),
                                ),
                                Text(
                                  'Voltage                                                   : ${voltage}v',
                                  style: TextStyle(color: Colors.white),
                                ),
                                ElevatedButton(
                                    onPressed: () => get_meter_no,
                                    child: Text('SMS')),
                                // Text('Previous elactricity consumption      : ${previos_consumption}kWh',style: TextStyle(color: Colors.white)),
                              ],
                            ),
                          );
                        }
                      }
                          }
                        ),
                    ],
                  )
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Lottie.asset('assets/lotie/home.json'),
                ),
              ],
            );
          }
        }
