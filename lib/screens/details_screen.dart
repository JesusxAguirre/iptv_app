import 'package:flutter/material.dart';
import 'package:movie_app/models/models.dart';
import 'package:movie_app/widgets/widgets.dart' show PlayVideoButton;

class DetailsScreen extends StatelessWidget {
  final String heroId;

  const DetailsScreen({super.key, required this.heroId});
  @override
  Widget build(BuildContext context) {
    final MediaItem mediaItem =
        ModalRoute.of(context)!.settings.arguments as MediaItem;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _CustomAppBar(mediaItem: mediaItem),
          SliverList(
            delegate: SliverChildListDelegate([
              _PosterAndTitle(mediaItem: mediaItem),
              _OverView(mediaItem: mediaItem),
            ]),
          ),
        ],
      ),
    );
  }
}

class _CustomAppBar extends StatelessWidget {
  final MediaItem mediaItem;

  const _CustomAppBar({required this.mediaItem});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 200,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        titlePadding: EdgeInsets.all(0),
        title: Container(
          width: double.infinity,
          color: Colors.black45,
          alignment: Alignment.bottomCenter,
          padding: EdgeInsets.only(bottom: 10),
          child: Text(mediaItem.title, style: TextStyle(fontSize: 16)),
        ),
        background: FadeInImage(
          placeholder: AssetImage('assets/loading.gif'),
          image: NetworkImage(mediaItem.fullPosterImg),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class _PosterAndTitle extends StatelessWidget {
  final MediaItem mediaItem;

  const _PosterAndTitle({required this.mediaItem});

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Container(
      margin: EdgeInsets.only(top: 10),
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          PlayVideoButton(),
          SizedBox(height: 20),
          Row(
            children: [
              Hero(
                tag: mediaItem.heroId!,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: FadeInImage(
                    height: 150,
                    width: 110,
                    placeholder: AssetImage('assets/no-image.jpg'),
                    image: NetworkImage(mediaItem.fullPosterImg),

                    fit: BoxFit.cover,
                  ),
                ),
              ),

              SizedBox(width: 20),

              Expanded(
                child: Column(
                  children: [
                    Text(
                      mediaItem.title,
                      style: textTheme.headlineSmall,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                      maxLines: 2,
                    ),
                    Text(
                      mediaItem.originalTitle,
                      style: textTheme.labelLarge,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.star_border_outlined,
                          size: 30,
                          color: Colors.yellow,
                        ),
                        SizedBox(width: 5),
                        Text(
                          '${mediaItem.voteAverage}',
                          style: textTheme.labelLarge,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _OverView extends StatelessWidget {
  final MediaItem mediaItem;

  const _OverView({required this.mediaItem});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      child: Text(
        mediaItem.overview,
        textAlign: TextAlign.justify,
        style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
      ),
    );
  }
}
