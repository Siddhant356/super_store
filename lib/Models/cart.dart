
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:super_store/Methods/sharedPrefrences.dart';

import 'sample.dart';

class Cart extends ChangeNotifier {
  List _products=[];
  Cart(){
    _init();
  }
  _init() async {
    print(_products);
  }
  List get cartItems{
    return _products;
  }
  dynamic _totalPrice = 0.0;

  void add(Sample item){
    _products.add(item);
    _totalPrice += item.price;
    notifyListeners();
  }

  void remove(Sample item){
    _totalPrice -=item.price;
    _products.remove(item);
    notifyListeners();
  }

  int get count {
    return _products.length;
  }

  dynamic get totalPrice {
    return _totalPrice;
  }
}

