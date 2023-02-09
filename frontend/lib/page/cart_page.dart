import 'package:flutter/material.dart';
import 'package:frontend/model/cart_model.dart';
import 'package:provider/provider.dart';

class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Mes plantes"),),
      body: Column(
        children: [
          Text("Vous avez ${context.watch<CartModel>().lsProducts.length} plantes enregistrées"),
          TextButton(
            onPressed: () =>context.read<CartModel>().removeAllProducts(),
            child: Text("Delete All"),
          ),
          Consumer<CartModel>(
              builder: (_,cart,__) => Expanded( //Expanded permet de faire prendre au widget la place restante
                child: ListView.builder(
                    itemCount: cart.lsProducts.length,
                    itemBuilder: (_,index) =>
                        ListTile(
                          title: Text(cart.lsProducts[index].title),
                          leading: Hero(
                            tag: cart.lsProducts[index].id,
                            child: Image.network(cart.lsProducts[index].image,
                                width: 80, height: 80),
                          ),
                          trailing: TextButton(
                              onPressed: () =>context.read<CartModel>().removeProduct(cart.lsProducts[index]),
                              child: Text("Delete"),
                          ),
                        )

                ),
              )
          )
          ,TextButton(
            onPressed: () =>context.read<CartModel>().removeAllProducts(),
            child: Text("Ajouter une plante"),
          ),
        ],
      ),
    );
  }
}