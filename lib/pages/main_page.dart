import 'package:flutter/material.dart';
import 'package:movieapp/components/movie_list.dart';
import 'package:movieapp/models/movie.dart';
import 'package:movieapp/network/api.dart';
import 'package:movieapp/pages/search_page.dart';

class MainPage extends StatefulWidget {
  MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  List<Movie>? popularMovies;
  List<Movie>? nowPlayingMovies;

  loadPopular() {
    API().getPopular().then((value) {
      setState(() {
        popularMovies = value;
      });
    });

    API().getNowPlaying().then((value) {
      setState(() {
        nowPlayingMovies = value;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    loadPopular();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Movie App"),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => SearchPage()));
                },
                icon: const Icon(Icons.search))
          ],
        ),
        body: Column(children: [
          nowPlayingMovies == null
              ? const Center(child: CircularProgressIndicator())
              : MovieList(
                  list: nowPlayingMovies!,
                  title: "Now Playing",
                ),
          popularMovies == null
              ? const Center(child: CircularProgressIndicator())
              : MovieList(
                  list: popularMovies!,
                  title: "Popular",
                )
        ]));
  }
}
