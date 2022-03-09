import 'dart:convert';

import 'package:movieapp/models/movie.dart';
import 'package:http/http.dart' as http;
import 'package:movieapp/models/res_popular.dart';

class API {
  final String _baseURL = "https://api.themoviedb.org/3";
  static const String imageURL = "https://image.tmdb.org/t/p/w200";
  final String _apiKey = "a92f28e11a27e8e5938a2020be68ba9c";

  Future<List<Movie>> getPopular() async {
    final response = await http.get(
      Uri.parse("$_baseURL/movie/popular?api_key=$_apiKey"),
    );

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response, then parse the JSON.
      var resp = ResPopular.fromRawJson(response.body);
      return resp.results;
    } else {
      // If the server did not return a 200 OK response, then throw an exception.
      throw Exception('Failed to load album');
    }
  }
}
