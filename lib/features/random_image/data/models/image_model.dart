import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
part 'image_model.g.dart';

@JsonSerializable()
class ImageModel extends Equatable {
  final String url;
  final String artist;
  @JsonKey(name: "artist_url")
  final String artistUrl;
  @JsonKey(name: "source_url")
  final String sourceUrl;
  final String error;
  const ImageModel({
    required this.url,
    required this.artist,
    required this.artistUrl,
    required this.sourceUrl,
    required this.error,
  });

  @override
  List<Object> get props {
    return [
      url,
      artist,
      artistUrl,
      sourceUrl,
      error,
    ];
  }

  factory ImageModel.fromJson(Map<String, dynamic> json) =>
      _$ImageModelFromJson(json);

  /// Connect the generated [_$NumberTriviaModel] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$ImageModelToJson(this);
}
