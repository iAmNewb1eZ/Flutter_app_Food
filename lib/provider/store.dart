import 'package:flutter/material.dart';

class Store with ChangeNotifier {
  String connect = 'connected';
  int count = 0;
  int sum = 0;
  int sumAll = 0;
  List orderDesign = [];

  void add(index) {
    count = index['count'];
    if (count >= 0) {
      count++;
      sum = count * int.parse(index['price']);
    }

    notifyListeners();
  }

  void remove(index) {
    count = index['count'];
    if (count > 0) {
      count--;
      sum = count * int.parse(index['price']);
    }
    notifyListeners();
  }

  void priceSum(List foods) {
    print(foods);
    notifyListeners();
  }

  void res(sum) {
    sumAll = sum;
    notifyListeners();
  }

  void addOrder(listFoods, itemTable) {
    print(orderDesign.length);
    int id = orderDesign.length;
    orderDesign.add([
      {'id': id, 'Table': itemTable},
      listFoods
    ]);
    getOrder(0, 'listFoods');
    notifyListeners();
  }

  void getOrder(int id, String order) {
    List listFoods = [];
    order == 'listFoods'
        ? {
          orderDesign[id][1]
          .map((e) => {listFoods.add(e), print('e: ${e['name']}')})
          .toList()
          .toString(),
           print(listFoods)
        }
    :print(orderDesign[id][0][order]);
    print(orderDesign);
    notifyListeners();
  }
}
