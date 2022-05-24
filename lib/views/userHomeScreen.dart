import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:household/Constant.dart';
import 'package:household/Model/product.dart';
import 'package:household/Model/productModel.dart';
import 'package:household/views/DetailsScreen.dart';
import 'package:household/views/cart.dart';
import 'package:household/views/loginscreen.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../Model/userModel.dart';
import '../Loader/ColorLoader.dart';
import 'ItemCard.dart';
import 'favourites.dart';

class homeScreen extends StatefulWidget {
  const homeScreen({Key? key}) : super(key: key);
  @override
  State<homeScreen> createState() => _homeScreenState();
}

class _homeScreenState extends State<homeScreen> {
  Future<List<ProductModel>> _getProduct() async {
    var data = await http
        .get(Uri.parse("${BASE_URL}view_product.php"));
    List jsonData = jsonDecode(data.body);
    List<Color> colors = [Color(0xFF3D82AE),Color(0xFFD3A984),Color(0xFF989493)];
    int item = 0;
    List<ProductModel> products =
    jsonData.map<ProductModel>((json) => ProductModel.fromJson(json,item!=colors.last?colors[item++]: colors[item=0])).toList();
    // print(jsonData.first['product_name']);
    return products;
  }
  Future<UserModel> _getUsers() async {
    final _sharedprfs = await SharedPreferences.getInstance();
    final _id = _sharedprfs.getString('id');
    var data = await http.post(
        Uri.parse("${BASE_URL}get_userdata.php"),
        body: {
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
            IconButton(
              icon: Icon(Icons.shopping_cart,
                color: kTextLightColor,),
                onPressed: () =>Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Cart()))
            ),
            IconButton(
                onPressed: () async {
                  final _sharedprfs = await SharedPreferences.getInstance();
                  await _sharedprfs.clear();
                  _sharedprfs.remove("login");
                  Navigator.of(context).pushReplacement(
                      (MaterialPageRoute(builder: (context) => loginscreen())));
                },
                icon: Icon(Icons.logout,
                  color: kTextLightColor,)),

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
                              style:
                              TextStyle(color: Colors.white),
                            ),
                            accountEmail: Text(
                              snapshot.data!.email.toString(),
                              style:
                              TextStyle(color: Colors.white),
                            ),
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: NetworkImage('https://thearchitecturedesigns.com/wp-content/webp-express/webp-images/uploads/2020/02/craftman-house-21-min-759x500.jpg.webp')
                                  ,fit: BoxFit.cover),
                            ),
                          ),
                          InkWell(
                            onTap: (){
                              Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>(homeScreen())));
                            },
                            child: ListTile(
                              title: Text('Home Page'),
                              leading: Icon(Icons.home,color: Colors.green,),
                            ),
                          ),
                          InkWell(
                            onTap: (){},
                            child: ListTile(
                              title: Text('My Orders'),
                              leading: Icon(Icons.shopping_basket,color: Colors.grey,),
                            ),
                          ),
                          InkWell(
                            onTap: ()=>Navigator.of(context).push(MaterialPageRoute(builder: (context)=>(Favourites()))),
                            child: ListTile(
                              title: Text('Favorite'),
                              leading: Icon(Icons.favorite,color: Colors.red,),
                            ),
                          ),
                          InkWell(
                            onTap: (){},
                            child: ListTile(
                              title: Text('Daily Elactricity Usage'),
                              leading: Icon(Icons.dashboard,color: Colors.grey,),
                            ),
                          ),
                          InkWell(
                            onTap: (){},
                            child: ListTile(
                              title: Text('Meter Reading'),
                              leading: Icon(Icons.power,color: Colors.grey,),
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
        body: contentInit(context) // GridView.builder,
    );
  }

  SafeArea contentInit(BuildContext context) {
    return SafeArea(
        child: FutureBuilder(
          future: _getProduct(),
          builder: (BuildContext context,
              AsyncSnapshot<List<ProductModel>> snapshot){
    if (!snapshot.hasData) {
    return Center(child: ColorLoader());
    } else {
          return GridView.builder(
              itemCount: snapshot.data?.length,
              gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2), // SliverGridDelegateWithFixedCrossAxisCount
              itemBuilder: (BuildContext context, int index){
                return ItemCard(
                  product:snapshot.data!.elementAt(index),
                  press: () =>Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetailsScreen(product:snapshot.data!.elementAt(index)),
                    ),
                  ),
                );// Single_prod
              });
    }
          },
        ),
      );
  }
}
