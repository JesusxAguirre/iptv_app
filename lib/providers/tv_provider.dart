import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:movie_app/models/models.dart';

class TvProvider extends ChangeNotifier {
  final String _token =
      'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJmODc5YzIxMjFlY2U5ZGQwMjFmYmJjYjliMGEzNmNkYiIsIm5iZiI6MTc0MTgxNDI3Ni4zODUsInN1YiI6IjY3ZDFmYTA0NjQ0NDM5ODRiMTFlMTA4NiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.fb4eNhVpz1ovPbTQTG984SrqCmDQduNZShBwMzk0s-0';
  final String _baseUrl = 'api.themoviedb.org';

  final String _language = 'es-ES';
  List<TvChannel> tvChannels = [];
  List<Tv> popularTvSeries = [];

  int _popularTvPage = 0;

  TvProvider() {
    getTvChannels();
    getTvSeries();
  }

  Future<String> _getJsonData(String path, [int page = 1]) async {
    var url = Uri.https(_baseUrl, path, {
      'language': _language,
      'page': '$page',
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
  }

  getTvChannels() async {
    String path = '/3/watch/providers/tv';

    final jsonData = await _getJsonData(path);

    final TvChannelResponse data = TvChannelResponse.fromJson(jsonData);

    tvChannels = data.results;

    notifyListeners();
  }

  getTvSeries() async {
    String path = '/3/tv/popular';

    _popularTvPage++;

    final jsonData = await _getJsonData(path, _popularTvPage);

    final TvSeriesResponse data = TvSeriesResponse.fromJson(jsonData);

    popularTvSeries = [...popularTvSeries, ...data.results];
  }
}
