import 'dart:async';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:movie_app/helpers/debouncer.dart';
import 'package:movie_app/models/models.dart';

class MoviesProvider extends ChangeNotifier {
  final String _token =
      'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJmODc5YzIxMjFlY2U5ZGQwMjFmYmJjYjliMGEzNmNkYiIsIm5iZiI6MTc0MTgxNDI3Ni4zODUsInN1YiI6IjY3ZDFmYTA0NjQ0NDM5ODRiMTFlMTA4NiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.fb4eNhVpz1ovPbTQTG984SrqCmDQduNZShBwMzk0s-0';
  final String _baseUrl = 'api.themoviedb.org';
  final String _language = 'es-MX';

  List<Movie> onDisplayMovies = [];
  List<Movie> onPopularMovies = [];

  final debouncer = Debouncer(duration: Duration(milliseconds: 500));

  final StreamController<List<Movie>> _streamController =
      StreamController.broadcast();

  Stream<List<Movie>> get sugggestionStream => _streamController.stream;

  int _popularPage = 0;

  MoviesProvider() {
    getPopularMoviews();
    getNowPlayingMovies();
  }

  Future<String> _getJsonData(
    String path, [
    int page = 1,
    String query = '',
  ]) async {
    try {
      var url = Uri.https(_baseUrl, path, {
        'language': _language,
        'page': '$page',
        'query': query,
      });

      var response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $_token',
        },
      );

      return response.body;
    } catch (error) {
      return '';
    }
  }

  getPopularMoviews() async {
    _popularPage++;

    String path = '/3/movie/popular';

    final PopularMoviesResponse popularMovies = PopularMoviesResponse.fromJson(
      await _getJsonData(path, _popularPage),
    );

    onPopularMovies = [...onPopularMovies, ...popularMovies.results];

    notifyListeners();
  }

  getNowPlayingMovies() async {
    String path = '/3/movie/now_playing';

    final NowPlayingResponse nowPlayingsMovies = NowPlayingResponse.fromJson(
      await _getJsonData(path),
    );

    onDisplayMovies = nowPlayingsMovies.results;

    notifyListeners();
  }

  Future<List<Movie>> searchMovies(String query) async {
    String path = '/3/search/movie';

    final data = PopularMoviesResponse.fromJson(
      await _getJsonData(path, 1, query),
    );

    return data.results;
  }

  void getSuggestionsByQuery(String searchTerm) {
    debouncer.value = '';
    debouncer.onValue = (value) async {
      final results = await searchMovies(searchTerm);

      _streamController.add(results);
    };

    final timer = Timer.periodic(Duration(milliseconds: 300), (_) {
      debouncer.value = searchTerm;
    });

    Future.delayed(Duration(microseconds: 301)).then((_) => timer.cancel());
  }
}
