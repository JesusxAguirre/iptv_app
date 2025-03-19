import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/models/models.dart';

class CardSwipper extends StatelessWidget {
  final List<Movie> movies;

  const CardSwipper({super.key, required this.movies});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    if (movies.isEmpty) {
      return SizedBox(
        width: double.infinity,
        height: size.height * 0.5,
        child: const Center(child: CircularProgressIndicator()),
      );
    }

    return SizedBox(
      width: double.infinity,
      height: isLandscape ? size.height * 0.8 : size.height * 0.6,
      child: Swiper(
        itemCount: movies.length,
        layout: SwiperLayout.STACK,
        itemWidth: isLandscape ? size.width * 0.4 : size.width * 0.6,
        itemHeight: isLandscape ? size.height * 0.6 : size.height * 0.4,
        itemBuilder: (_, index) {
          final movie = movies[index];

          movie.heroId = 'swiper-${movie.id}';
          return GestureDetector(
            onTap:
                () =>
                    Navigator.pushNamed(context, '/details', arguments: movie),
            child: Hero(
              tag: movie.heroId!,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: FadeInImage(
                  placeholder: const AssetImage('assets/no-image.jpg'),
                  image: NetworkImage(movie.fullPosterImg),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
