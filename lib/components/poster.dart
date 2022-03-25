import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movieapp/network/api.dart';

class Poster extends StatelessWidget {
  String? posterPath;
   Poster({ Key? key, required this.posterPath }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if(posterPath == null) {
      return Image.asset("assets/img/cover.jpg");
    }
    return CachedNetworkImage(imageUrl: API.imageURL + posterPath!, placeholder: (context, url) => Image.asset("assets/img/cover.jpg"));
  }
}