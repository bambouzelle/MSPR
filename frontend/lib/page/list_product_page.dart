import 'package:flutter/material.dart';
import 'package:frontend/model/cart_model.dart';
import 'package:go_router/go_router.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../model/product_model.dart';

class ListProductPage extends StatelessWidget {
  ListProductPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<http.Response>(
        future: http.get(Uri.parse("https://fakestoreapi.com/products/")),
        builder: (_, snapshot) {
          if (snapshot.hasData && snapshot.data != null) {
            String body = snapshot.data!.body;
            final List<dynamic> lsProductsJSON = jsonDecode(body) as List;
            List<Product> lsProducts = List.empty(growable: true);
            lsProductsJSON.forEach((mapProduct) =>
                lsProducts.add(Product.fromJson(mapProduct))
            );
            return Scaffold(
                appBar: AppBar(title: const Text("Liste des annonces"), actions: [IconButton(onPressed: ()=>context.go('/cart'), icon: const Icon(Icons.shopping_bag_outlined))],),
                body:ListView.builder(
                    itemCount: lsProducts.length,
                    itemBuilder: (context, index){
                      return InkWell(
                        onTap: () => context.go('/detail',extra: lsProducts[index]),
                        child: ListTile(
                          title: Text(lsProducts[index].title),
                          subtitle: Text("${lsProducts[index].price} €",
                              style: Theme.of(context).textTheme.titleLarge),
                          leading: Hero(
                            tag: lsProducts[index].id,
                            child: Image.network(lsProducts[index].image,
                                width: 80, height: 80),
                          ),
                          trailing: TextButton(
                            onPressed: ()=> context.read<CartModel>().addProduct(lsProducts[index]),
                            child: Text("add"),
                          ),
                        ),
                      );
                    }
                )
            );
          }
          return const CircularProgressIndicator();
        }
    );
  }


}
