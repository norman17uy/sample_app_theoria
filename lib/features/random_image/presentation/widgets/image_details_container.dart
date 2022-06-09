import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:sample_app_theoria/features/random_image/data/models/image_model.dart';

class ImageDetailsContainer extends StatelessWidget {
  final ImageModel imageModel;
  const ImageDetailsContainer({
    Key? key,
    required this.imageModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height / 2,
      child: Column(
        children: [
          SizedBox(
            height: 200,
            width: 200,
            child: CachedNetworkImage(
              imageUrl: imageModel.url,
            ),
          ),
          const SizedBox(
            height: 50,
          ),
          Wrap(
            children: [
              const Text(
                "Artits: ",
                style: TextStyle(fontSize: 20),
              ),
              Text(
                imageModel.artist,
                style: const TextStyle(fontSize: 20),
              )
            ],
          )
        ],
      ),
    );
  }
}
