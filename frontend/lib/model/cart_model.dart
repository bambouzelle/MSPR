import 'package:flutter/cupertino.dart';
import 'product_model.dart';

class CartModel extends ChangeNotifier{
  final List<Product> lsProducts;

  CartModel(this.lsProducts);

  addProduct(Product product){
    lsProducts.add(product);
    notifyListeners();
  }

  removeAllProducts(){
    lsProducts.clear();
    notifyListeners();
  }

  removeProduct(Product product){
    lsProducts.remove(product);
    notifyListeners();
  }

  getAllPrice(){
    num priceTotal =0;
    for(int i =0; i<lsProducts.length;i++){
      priceTotal += lsProducts[i].price;
    }
    return priceTotal;
  }
}