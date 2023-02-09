import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../model/product_model.dart';
import '../model/review_model.dart';


class ReviewPage extends StatelessWidget {
  final Product product;
  ReviewPage(this.product,{Key? key}) : super(key: key);
//Review(this.id_produit, this.image_profile, this.avis, this.note);
  List<Review> LReview = [
    Review("WOW",1,'https://picsum.photos/80/80','Super bien en vrai', 'bernard',5),
    Review("Eviter",1,'https://picsum.photos/80/80','Pas aimé boff','jean',2),
    Review("Moyen",1,'https://picsum.photos/80/80','Incroyable, mais pas ouf en même temps','henry',3),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(product.title)),
        body:ListView.builder(
              itemCount: LReview.length,
              itemBuilder: (context, index) {

                return  Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListTile(
                      title: Text(LReview[index].nom, style: Theme
                          .of(context)
                          .textTheme
                          .headline6),
                      leading:
                      ClipOval(
                          child: Image.network(
                            LReview[index].image_profile,)
                      ),
                    ),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          constructImageNote(LReview[index], 1),
                          constructImageNote(LReview[index], 2),
                          constructImageNote(LReview[index], 3),
                          constructImageNote(LReview[index], 4),
                          constructImageNote(LReview[index], 5),
                        ]

                    ),

                    ListTile(
                      title: Text(LReview[index].titre),
                      subtitle: Text(LReview[index].avis),
                    )

                  ],

                );
              }

    )
    );
        }

}


Icon constructImageNote(Review avis, int compteur){
  if(compteur <= avis.note){
    return const Icon(Icons.star);
  }
  else{
    return const Icon(Icons.star_border);
  }
  compteur++;
}