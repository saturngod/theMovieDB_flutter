import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movieapp/components/blur_background.dart';
import 'package:movieapp/components/cast_pic.dart';
import 'package:movieapp/components/poster.dart';
import 'package:movieapp/models/cast.dart';
import 'package:movieapp/models/movie.dart';
import 'package:movieapp/network/api.dart';

class DetailPage extends StatefulWidget {
  Movie movie;
  String heroTag = "";
  DetailPage({Key? key, required this.movie, required this.heroTag}) : super(key: key);

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  var api = API();
  List<Cast>? casts;
  @override
  void initState() {
    api.getCast(widget.movie.id).then((value) {
      setState(() {
        casts = value;
      });
    });
    super.initState();
  }

  _castInformation() => ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: casts!.length,
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        itemBuilder: (BuildContext context, int index) {
          Cast c = casts![index];
          
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                CastPic(profilePath: c.profilePath),
                const SizedBox(
                  width: 12,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      c.originalName,
                      style: const TextStyle(color: Colors.white),
                    ),
                    Text(
                      c.character,
                      style: const TextStyle(color: Colors.white24),
                    ),
                  ],
                )
              ],
            ),
          );
        },
      );
  _movieInformation() => Column(
        children: [
          Hero(
              tag: widget.heroTag,
              child: Poster(posterPath: widget.movie.posterPath)),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(widget.movie.title,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold)),
          ),
          const SizedBox(
            height: 14,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              widget.movie.overview,
              style: const TextStyle(color: Colors.white),
            ),
          )
        ],
      );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(widget.movie.title)),
        body: Stack(
          children: [
            widget.movie.backdropPath != null ? BlurBackground(
              backdropPath: widget.movie.backdropPath!,
            ) : Container(),
            SingleChildScrollView(
              child: Column(
                children: [
                  _movieInformation(),
                  const SizedBox(
                    height: 12,
                  ),
                  casts == null
                      ? const CircularProgressIndicator()
                      : _castInformation()
                ],
              ),
            )
          ],
        ));
  }
}
