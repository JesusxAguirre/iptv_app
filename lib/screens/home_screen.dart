import 'package:flutter/material.dart';
import 'package:movie_app/providers/movies_provider.dart';
import 'package:movie_app/providers/providers.dart';

import 'package:movie_app/widgets/widgets.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final moviesProvider = Provider.of<MoviesProvider>(context);
    final tvProvider = Provider.of<TvProvider>(context);

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            CardSwipper(movies: moviesProvider.onDisplayMovies),
            MediaSlider(
              mediaItems: moviesProvider.onPopularMovies,
              mediaTitle: 'Popular Movies',
              onNextPage: () => moviesProvider.getPopularMoviews(),
            ),
            MediaSlider(
              mediaItems: tvProvider.popularTvSeries,
              onNextPage: () => tvProvider.getTvSeries(),
              mediaTitle: 'Popular Tv Shows',
            ),
          ],
        ),
      ),
    );
  }
}
