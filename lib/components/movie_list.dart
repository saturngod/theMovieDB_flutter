import 'package:flutter/material.dart';
import 'package:movieapp/models/movie.dart';
import 'package:movieapp/network/api.dart';

class MovieList extends StatefulWidget {
  List<Movie> list;
  String title;

  MovieList({Key? key, required this.list, required this.title})
      : super(key: key);

  @override
  State<MovieList> createState() => _MovieListState();
}

class _MovieListState extends State<MovieList> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 12, top: 12),
            child: Text(
              widget.title,
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 234,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: widget.list.length,
                itemBuilder: (BuildContext context, int index) {
                  Movie m = widget.list[index];
                  return SizedBox(
                    width: 125,
                    height: 230,
                    child: Card(
                      child: Column(children: [
                        SizedBox(
                          height: 180,
                          child: Image.network(API.imageURL + m.posterPath),
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        Padding(
                            padding: const EdgeInsets.all(4),
                            child: Text(
                              m.title,
                              maxLines: 2,
                            ))
                      ]),
                    ),
                  );
                }),
          )
        ],
      ),
    );
  }
}
