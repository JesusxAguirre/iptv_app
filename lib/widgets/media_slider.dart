import 'package:flutter/material.dart';
import 'package:movie_app/models/models.dart';
import 'package:movie_app/router/app_navigator.dart';

class MediaSlider extends StatefulWidget {
  final List<MediaItem> mediaItems;
  final String? mediaTitle;

  final Function onNextPage;

  const MediaSlider({
    super.key,
    required this.mediaItems,
    this.mediaTitle,
    required this.onNextPage,
  });

  @override
  State<MediaSlider> createState() => _MediaSliderState();
}

class _MediaSliderState extends State<MediaSlider> {
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    scrollController.addListener(() {
      if (scrollController.position.pixels >=
          scrollController.position.maxScrollExtent - 500) {
        widget.onNextPage();
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 260,

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          widget.mediaTitle != null
              ? Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  widget.mediaTitle!,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              )
              : SizedBox.shrink(),

          const SizedBox(height: 5),

          Expanded(
            child: ListView.builder(
              controller: scrollController,
              scrollDirection: Axis.horizontal,
              itemCount: widget.mediaItems.length,
              itemBuilder:
                  (context, index) =>
                      _MediaPoster(mediaItem: widget.mediaItems[index]),
            ),
          ),
        ],
      ),
    );
  }
}

class _MediaPoster extends StatelessWidget {
  final MediaItem mediaItem;

  const _MediaPoster({required this.mediaItem});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 14),

      child: Column(
        children: [
          GestureDetector(
            onTap: () => AppNavigator.navigateToDetails(context, mediaItem),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: FadeInImage(
                width: 130,
                height: 190,
                placeholder: AssetImage('assets/no-image.jpg'),
                image: NetworkImage(mediaItem.fullPosterImg),
                fit: BoxFit.cover,
              ),
            ),
          ),

          const SizedBox(height: 5),

          Text(
            mediaItem.title,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
