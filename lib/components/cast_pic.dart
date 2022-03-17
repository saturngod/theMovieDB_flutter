import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movieapp/network/api.dart';

class CastPic extends StatelessWidget {
  String? profilePath;
   CastPic({ Key? key , required this.profilePath}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    ImageProvider<Object> img ;

    if(profilePath == null) {
      img = const AssetImage("assets/img/cast.png");
    }
    else {
    img = CachedNetworkImageProvider(
                            API.imageURL + profilePath!);
    }
    return CircleAvatar(
                        backgroundImage: img);
    
    
  }
}