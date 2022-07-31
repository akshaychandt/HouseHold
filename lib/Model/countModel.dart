import 'package:flutter/material.dart';
class CountModel extends ChangeNotifier{
  int count=1;
  int itemCount=0;
  int get getCount=>count;
  incrementCount(){
    if(count<10){
      count++;
      notifyListeners();
    }
  }
  decrementCount(){
    if(count>1){
      count--;
      notifyListeners();
    }
  }
  cartItemCountIncrement(){
    itemCount=0;
    notifyListeners();
  }
  cartItemCountDecrement(){
      itemCount--;
    notifyListeners();
  }

}