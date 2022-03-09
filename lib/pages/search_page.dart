import 'package:flutter/material.dart';
import 'package:movieapp/components/search_list.dart';
import 'package:movieapp/models/movie.dart';
import 'package:movieapp/network/api.dart';

class SearchPage extends StatefulWidget {
  SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  var movieAPI = API();
  List<Movie>? result;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: TextField(
        style: const TextStyle(
          color: Colors.white,
        ),
        textInputAction: TextInputAction.search,
        onSubmitted: (value) {
          movieAPI.getSearch(value).then((value) {
            setState(() {
              result = value;
              print(result!.length);
            });
          });
        },
        decoration: const InputDecoration(
            hintStyle: TextStyle(color: Colors.white), hintText: "Search"),
      )),
      body: result == null
          ? Text("Please Search First")
          : SearchList(list: result!),
    );
  }
}
