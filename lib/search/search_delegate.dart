import 'package:flutter/material.dart';
import 'package:movie_app/models/models.dart';
import 'package:movie_app/providers/movies_provider.dart';
import 'package:movie_app/router/app_navigator.dart';
import 'package:provider/provider.dart';

class MovieSearchDelegate extends SearchDelegate {
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [IconButton(onPressed: () => query = '', icon: Icon(Icons.delete))];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () => close(context, null),
    );
  }

  Widget _emptyIcon() {
    return Center(child: Icon(Icons.movie_creation, size: 100));
  }

  @override
  Widget buildResults(BuildContext context) {
    return SizedBox.shrink();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isEmpty) {
      return _emptyIcon();
    }

    final movieProvider = Provider.of<MoviesProvider>(context, listen: false);

    return FutureBuilder(
      future: movieProvider.searchMovies(query),
      builder: (_, AsyncSnapshot<List<Movie>> snapshot) {
        if (!snapshot.hasData) return _emptyIcon();

        final movies = snapshot.data!;
        return ListView.builder(
          itemCount: movies.length,

          itemBuilder: (_, index) {
            return _MediaItem(mediaItem: movies[index]);
          },
        );
      },
    );
  }
}

class _MediaItem extends StatelessWidget {
  final MediaItem mediaItem;

  const _MediaItem({required this.mediaItem});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Column(
      children: [
        ListTile(
          leading: FadeInImage(
            placeholder: AssetImage('assets/no-image.jpg'),
            image: NetworkImage(mediaItem.fullPosterImg),
            width: size.width * 0.3,
            fit: BoxFit.cover,
          ),
          title: Text(mediaItem.title),
          onTap: () => AppNavigator.navigateToDetails(context, mediaItem),
        ),
        Divider(),
      ],
    );
  }
}
