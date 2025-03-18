import 'dart:convert';

import 'package:movie_app/models/tv_channel.dart';

class TvChannelResponse {
  List<TvChannel> results;

  TvChannelResponse({required this.results});

  factory TvChannelResponse.fromJson(String str) =>
      TvChannelResponse.fromMap(json.decode(str));

  factory TvChannelResponse.fromMap(Map<String, dynamic> json) =>
      TvChannelResponse(
        results: List<TvChannel>.from(
          json["results"].map((x) => TvChannel.fromMap(x)),
        ),
      );
}
