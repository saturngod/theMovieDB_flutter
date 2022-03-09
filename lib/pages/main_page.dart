import 'package:flutter/material.dart';
import 'package:movieapp/models/movie.dart';
import 'package:movieapp/network/api.dart';

class MainPage extends StatefulWidget {
  MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  List<Movie>? popularMovies;

  loadPopular() {
    API().getPopular().then((value) {
      setState(() {
        popularMovies = value;
        print(popularMovies!.length);
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
      ),
      body: popularMovies == null
          ? const Text("Loading...")
          : Container(
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  const Text("Popular"),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 230,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: popularMovies!.length,
                        itemBuilder: (BuildContext context, int index) {
                          Movie m = popularMovies![index];
                          return SizedBox(
                            width: 125,
                            height: 217,
                            child: Card(
                              child: Column(children: [
                                SizedBox(
                                  height: 180,
                                  child: Image.network(
                                      API.imageURL + m.posterPath),
                                ),
                                const SizedBox(
                                  height: 4,
                                ),
                                Text(m.title)
                              ]),
                            ),
                          );
                        }),
                  )
                ],
              ),
            ),
    );
  }
}
