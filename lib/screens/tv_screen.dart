import 'package:flutter/material.dart';
import 'package:movie_app/models/tv_channel.dart';
import 'package:movie_app/providers/tv_provider.dart';
import 'package:provider/provider.dart';

class TvScreen extends StatelessWidget {
  const TvScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final tvProvider = Provider.of<TvProvider>(context);

    final List<TvChannel> channels = tvProvider.tvChannels;

    return Expanded(
      child: ListView.builder(
        itemCount: channels.length,
        itemBuilder: (context, index) {
          if (index == 0) {
            return Column(
              children: [
                SizedBox(
                  height: size.height * 0.6,
                  width: double.infinity,
                  child: FadeInImage(
                    fit: BoxFit.cover,
                    placeholder: AssetImage('assets/no-image.jpg'),
                    image: NetworkImage(
                      'https://www.rockaxis.com/img/newsList/3148230.jpg',
                    ),
                  ),
                ),

                const SizedBox(height: 5),
                ListTile(
                  onTap: () {},
                  leading: Image.network(
                    channels[index].FullPosterImg,
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover,
                  ),

                  trailing: Icon(
                    Icons.arrow_forward_outlined,
                    color: Colors.white,
                  ),
                  title: Text(channels[index].providerName),
                ),
              ],
            );
          }

          return ListTile(
            onTap: () {},
            leading: Image.network(
              channels[index].FullPosterImg,
              width: 50, // Ancho de la imagen
              height: 50, // Alto de la imagen
              fit: BoxFit.cover, // Ajusta la imagen al espacio disponible
            ),

            trailing: Icon(Icons.arrow_forward_outlined, color: Colors.white),
            title: Text(channels[index].providerName),
          );
        },
      ),
    );
  }
}
