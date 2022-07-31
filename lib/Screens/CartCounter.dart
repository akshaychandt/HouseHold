// import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:household/Constant.dart';
import 'package:household/Model/countModel.dart';
import 'package:provider/provider.dart';

class CartCounter extends StatefulWidget {
  const CartCounter({Key? key}) : super(key: key);

  @override
  State<CartCounter> createState() => _CartCounterState();
}

class _CartCounterState extends State<CartCounter> {
  @override
  Widget build(BuildContext context) {
    return Consumer<CountModel>(
      builder: (context, value, child) => 
     Row(
        children: <Widget>[
          buildOutlineButton(
            icon: Icons.remove,
            press: () {
              value.decrementCount();
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: kDefaultPaddin / 2),
            child: Text(
              // if our item is less  then 10 then  it shows 01 02 like that
              value.getCount.toString(),
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
          buildOutlineButton(
              icon: Icons.add,
              press: () {
                value.incrementCount();
                print(value.count);
              }),
        ],
      ),
    );
  }

  SizedBox buildOutlineButton({required IconData icon, required Function() press}) {
    return SizedBox(
      width: 40,
      height: 32,
      child: TextButton(style: TextButton.styleFrom(
        padding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(13),
        ),
      ),
        onPressed: press,
        child: Icon(icon),
      ),
    );
  }
}
