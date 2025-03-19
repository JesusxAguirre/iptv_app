import 'dart:convert';

import 'package:movie_app/models/models.dart';

class TvSeriesResponse {
  int page;
  List<Tv> results;
  int totalPages;
  int totalResults;

  TvSeriesResponse({
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  factory TvSeriesResponse.fromJson(String str) =>
      TvSeriesResponse.fromMap(json.decode(str));

  factory TvSeriesResponse.fromMap(Map<String, dynamic> json) =>
      TvSeriesResponse(
        page: json["page"],
        results: List<Tv>.from(json["results"].map((x) => Tv.fromMap(x))),
        totalPages: json["total_pages"],
        totalResults: json["total_results"],
      );
}

class Tv implements MediaItem {
  bool adult;
  String? backdropPath;
  List<int> genreIds;
  @override
  int id;
  List<String> originCountry;
  String originalLanguage;
  String originalName;

  String overview;
  double popularity;

  @override
  String? posterPath;
  String firstAirDate;
  String name;
  double voteAverage;
  int voteCount;

  String? heroId;

  @override
  get fullPosterImg {
    return 'https://image.tmdb.org/t/p/w500$posterPath';
  }

  Tv({
    required this.adult,
    required this.backdropPath,
    required this.genreIds,
    required this.id,
    required this.originCountry,
    required this.originalLanguage,
    required this.originalName,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.firstAirDate,
    required this.name,
    required this.voteAverage,
    required this.voteCount,
  });

  factory Tv.fromJson(String str) => Tv.fromMap(json.decode(str));

  factory Tv.fromMap(Map<String, dynamic> json) => Tv(
    adult: json["adult"],
    backdropPath: json["backdrop_path"],
    genreIds: List<int>.from(json["genre_ids"].map((x) => x)),
    id: json["id"],
    originCountry: List<String>.from(json["origin_country"].map((x) => x)),
    originalLanguage: json["original_language"],
    originalName: json["original_name"],
    overview: json["overview"],
    popularity: json["popularity"]?.toDouble(),
    posterPath: json["poster_path"] ?? '',
    firstAirDate: json["first_air_date"],
    name: json["name"],
    voteAverage: json["vote_average"]?.toDouble(),
    voteCount: json["vote_count"],
  );

  @override
  String get title => name;

  @override
  String get originalTitle => originalName;
}
