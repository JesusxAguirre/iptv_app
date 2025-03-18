import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/models/models.dart';

class CardSwipper extends StatelessWidget {
  final List<Movie> movies;

  const CardSwipper({super.key, required this.movies});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    if (movies.isEmpty) {
      return SizedBox(
        width: double.infinity,
        height: size.height * 0.5,
        child: Center(child: CircularProgressIndicator()),
      );
    }

    return SizedBox(
      width: double.infinity,
      height: size.height * 0.5,
      child: Swiper(
        itemCount: movies.length,
        layout: SwiperLayout.STACK,
        itemWidth: size.width * 0.6,
        itemHeight: size.height * 0.4,
        itemBuilder: (_, index) {
          final movie = movies[index];

          return GestureDetector(
            onTap:
                () =>
                    Navigator.pushNamed(context, '/details', arguments: movie),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Hero(
                tag: movie.id,
                child: FadeInImage(
                  placeholder: AssetImage('assets/no-image.jpg'),
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
