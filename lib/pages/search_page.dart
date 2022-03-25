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
          title: SizedBox(
            height: 44,
            child: TextField(
        
        textInputAction: TextInputAction.search,
        onSubmitted: (value) {
            movieAPI.getSearch(value).then((value) {
              setState(() {
                result = value;
                
              });
            });
        },
        decoration:  InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(40.0),
               borderSide: BorderSide.none,
            ),
            fillColor: Colors.white,
            filled: true,
              hintStyle: TextStyle(color: Colors.grey), 
              hintText: "Search"),
      ),
          )),
      body: result == null
          ? const Text("Please Search First")
          : SearchList(list: result!),
    );
  }
}
