import 'package:flutter/material.dart';
import 'package:household/Constant.dart';
import 'package:household/Model/productModel.dart';

class CounterComponent extends StatefulWidget {
  final ProductModel product;
  final Function(int) onCount;
  const CounterComponent({Key? key,required this.product,required this.onCount}) : super(key: key);
  @override
  State<CounterComponent> createState() => _CounterComponentState();
}

class _CounterComponentState extends State<CounterComponent> {
  var itemCount=1;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Column( mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TextButton(
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(13),
                    ),
                  ),
                  onPressed: (){
                    if(itemCount>1) {
                      setState(() {
                        itemCount--;
                        widget.onCount(itemCount);
                      });
                    }
                  },
                  child: Icon(Icons.remove),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: kDefaultPaddin / 2),
                  child: Text(
                    itemCount.toString(),
                    style: Theme.of(context)
                        .textTheme
                        .headline6,
                  ),
                ),
                TextButton(
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(13),
                    ),
                  ),
                  onPressed: (){
                    if(itemCount<10) {
                      setState(() {
                        itemCount++;
                        widget.onCount(itemCount);
                      });
                    }
                  },
                  child: Icon(Icons.add),
                ),
              ],
            ),
          ],
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              // products is out demo list
              widget.product.productName
                  .toString(),
              style: TextStyle(color: kTextLightColor),
            ),
          ],
        ),
        // SizedBox(
        //   width: 5,
        // ),
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              "\₹${int.parse( widget.product.price!) * itemCount}",
              style:
              TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),

      ],
    );
  }
}
