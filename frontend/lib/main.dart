import 'package:flutter/material.dart';
import 'package:frontend/model/cart_model.dart';
import 'package:frontend/page/product_check_page.dart';
import 'package:frontend/model/product_model.dart';
import 'package:frontend/page/review_page.dart';
import 'model/review_model.dart';
import 'page/cart_page.dart';
import 'page/list_product_page.dart';
import 'page/detail_product_page.dart';
import 'package:provider/provider.dart';

import 'package:go_router/go_router.dart';

void main() {
  runApp(
      ChangeNotifierProvider<CartModel>(
      create : (_)=>CartModel([]) ,
      child: MyApp()
    )
  );
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  final GoRouter _router = GoRouter(
    initialLocation: '/',
    routes: <GoRoute>[
      GoRoute(
        path: '/',
        builder: (_, state) => ListProductPage(),
        //builder: (_, state) => ProductCheckPage(),
        routes: [
          GoRoute(
            path: 'detail',
            builder: (_, state) =>  DetailProductPage(state.extra as Product),
            routes:[
              GoRoute(
                path: 'review',
                builder: (_, state) => ReviewPage(state.extra as Product),
              )
            ]
          ),
          GoRoute(
            path: 'cart',
            builder: (_, state) =>  const CartPage(),
          ),
        ]
      )
    ]
  );


  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _router,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      //home: CartPage(),
    );
  }
}

