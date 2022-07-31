import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:household/Constant.dart';
import 'package:household/Model/countModel.dart';
import 'package:household/Model/product.dart';
import 'package:household/Model/productModel.dart';
import 'package:household/views/DetailsScreen.dart';
import 'package:household/views/cart.dart';
import 'package:household/views/loginscreen.dart';
import 'package:household/views/meterReadingScreen.dart';
import 'package:household/views/productsScreen.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Model/userModel.dart';
import '../Loader/ColorLoader.dart';
import 'ItemCard.dart';
import 'favourites.dart';
import 'package:badges/badges.dart';

class homeScreen extends StatefulWidget {
  const homeScreen({Key? key}) : super(key: key);
  @override
  State<homeScreen> createState() => _homeScreenState();
}

class _homeScreenState extends State<homeScreen> {
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
            GestureDetector(
              onTap: () => Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => Cart())),
              child: Badge(
                badgeContent: Consumer<CountModel>(
                    builder: (context, value, child) => Text(
                        '${value.itemCount}',
                        style: TextStyle(color: Colors.white))),
                animationDuration: Duration(milliseconds: 300),
                child: Icon(Icons.shopping_cart),
              ),
            ),
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
                                  image: NetworkImage(
                                      'https://thearchitecturedesigns.com/wp-content/webp-express/webp-images/uploads/2020/02/craftman-house-21-min-759x500.jpg.webp'),
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
                            onTap: () {},
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
                          InkWell(
                            onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        MeterReadingScreen())),
                            child: ListTile(
                              title: Text('Meter Reading'),
                              leading: Icon(
                                Icons.power,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                          Divider(),
                          InkWell(
                            onTap: () {},
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
        body: contentInit(context) // GridView.builder,
        );
  }

  Column contentInit(BuildContext context) {
    return Column(
              children: [
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
                      Text('Total elactricity consumption            :',style: TextStyle(color: Colors.white),),
                      Text('Today\'s elactricity consumption        :',style: TextStyle(color: Colors.white),),
                      Text('Yesterday\'s elactricity consumption :',style: TextStyle(color: Colors.white))
                    ],
                  )
                ),
                Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(vertical: 70, horizontal: 20),
                    margin: EdgeInsets.symmetric(vertical: 50, horizontal: 20),
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
                    child: Text('House Hold connects local electricity organizations with their customers, making the process of accessing their services much more convenient. Customers can view their consumption, register complaints, purchase products through the app, among other options.',
                    style: TextStyle(
                      color: Colors.white,
                    ),textAlign: TextAlign.justify)),
              ],
            );
          }
        }
