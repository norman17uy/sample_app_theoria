import 'package:sample_app_theoria/features/random_image/data/models/image_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../../../core/error/exception.dart';

abstract class ImageRemoteDataSource {
  Future<ImageModel> getRandomImage();
}

class ImageRemoteDataSourceImpl implements ImageRemoteDataSource {
  final http.Client client;

  ImageRemoteDataSourceImpl(this.client);
  @override
  Future<ImageModel> getRandomImage() async {
    final url = Uri.parse("https://api.catboys.com/img");
    final response = await client.get(
      url,
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      return ImageModel.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }
}
