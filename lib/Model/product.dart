import 'dart:ui';

class Product {
  final int id,price;
  final String name,picture,description;
  final Color color;
  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.picture,
    required this.price,
    required this.color,
  });
}
List<Product> products = [
  Product(
      id : 1,
      name : "9W LED",
      description : "Your favourite shopping app has a variety of bulbs that you can buy to illuminate your home. You can choose from various LED bulbs and CFL bulbs from popular brands like Philips, Eveready, Syska LED lights, Wipro, Luminous, and Crompton. LED light bulbs are a good choice to go with since they are eco-friendly and energy-efficient. Oh, and here’s a handy tip: make sure that the bulb you choose will fit well in the existing fixtures of your home. The information is updated on 17-May-22.",
      picture : "assets/images/products/9wled.png",
      price : 80,
      color: Color(0xFF3D82AE)
  ),
  Product(
      id : 1,
      name : "11W LED",
      description : "Your favourite shopping app has a variety of bulbs that you can buy to illuminate your home. You can choose from various LED bulbs and CFL bulbs from popular brands like Philips, Eveready, Syska LED lights, Wipro, Luminous, and Crompton. LED light bulbs are a good choice to go with since they are eco-friendly and energy-efficient. Oh, and here’s a handy tip: make sure that the bulb you choose will fit well in the existing fixtures of your home. The information is updated on 17-May-22.",
      picture : "assets/images/products/11wled.png",
      price : 100,
      color: Color(0xFFD3A984)
  ),
  Product(
      id : 1,
      name : "15W LED",
      description : "Your favourite shopping app has a variety of bulbs that you can buy to illuminate your home. You can choose from various LED bulbs and CFL bulbs from popular brands like Philips, Eveready, Syska LED lights, Wipro, Luminous, and Crompton. LED light bulbs are a good choice to go with since they are eco-friendly and energy-efficient. Oh, and here’s a handy tip: make sure that the bulb you choose will fit well in the existing fixtures of your home. The information is updated on 17-May-22.",
      picture : "assets/images/products/15wled.png",
      price : 120,
      color: Color(0xFF989493)
  ),
];