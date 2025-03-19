abstract class MediaItem {
  String get title;
  String get originalTitle;
  String get overview;
  double get voteAverage;
  String? get posterPath;

  String? heroId;
  int get id;
  String get fullPosterImg; // Implementado en cada modelo
}
