import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movieapp/components/movie_list.dart';
import 'package:movieapp/controllers/home_controller.dart';
import 'package:movieapp/models/movie.dart';
import 'package:movieapp/network/api.dart';
import 'package:movieapp/pages/search_page.dart';
import 'package:movieapp/pages/signin_page.dart';

class MainPage extends StatefulWidget {
  MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  // List<Movie>? popularMovies;
  // List<Movie>? nowPlayingMovies;
  final HomeController c = Get.put(HomeController());

  @override
  void initState() {
    super.initState();
    c.loadPopular();
    c.loadNowPlaying();
  }

  Widget _popularList() => c.popularMovies.isEmpty ? 
          const CircularProgressIndicator() : 
          MovieList(
                  list: c.popularMovies,
                  title: "Popular",
                );

Widget _nowPlayingList() => c.nowPlayingMovies.isEmpty ? 
          const CircularProgressIndicator() : 
          MovieList(
                  list: c.nowPlayingMovies,
                  title: "Now Playing",
                );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(icon: const Icon(Icons.logout),onPressed: () {
            FirebaseAuth.instance.signOut();
            Get.off(() => SigninPage());
          },),
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
        body: Obx(() {
          return Column(children: [
            _nowPlayingList(),
            _popularList()
            ]);
        })
        
        );
  }
}
