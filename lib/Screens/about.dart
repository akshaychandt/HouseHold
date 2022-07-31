import 'package:flutter/material.dart';
import 'package:household/Screens/cart.dart';

class About extends StatelessWidget {
  const About({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text('About'),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {},
          ),
          IconButton(
              icon: Icon(Icons.shopping_cart),
              onPressed: () =>Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Cart()))
          ),

        ],
      ),
      body: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(vertical: 40, horizontal: 20),
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
          child: Text('House Hold connects local electricity organizations with their consumers, making the process of accessing their services much more convenient. Consumers can view their consumption, purchase products through the app, among other options.',
              style: TextStyle(
                color: Colors.white,
              ),textAlign: TextAlign.justify))
    );
  }
}
