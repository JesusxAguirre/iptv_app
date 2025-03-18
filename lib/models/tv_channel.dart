import 'dart:convert';

class TvChannel {
  Map<String, int> displayPriorities;
  int displayPriority;
  String logoPath;
  String providerName;
  int providerId;

  TvChannel({
    required this.displayPriorities,
    required this.displayPriority,
    required this.logoPath,
    required this.providerName,
    required this.providerId,
  });

  get FullPosterImg {
    return 'https://image.tmdb.org/t/p/w500$logoPath';
  }

  factory TvChannel.fromJson(String str) => TvChannel.fromMap(json.decode(str));

  factory TvChannel.fromMap(Map<String, dynamic> json) => TvChannel(
    displayPriorities: Map.from(
      json["display_priorities"],
    ).map((k, v) => MapEntry<String, int>(k, v)),
    displayPriority: json["display_priority"],
    logoPath: json["logo_path"],
    providerName: json["provider_name"],
    providerId: json["provider_id"],
  );

  get posterPath => null;
}
