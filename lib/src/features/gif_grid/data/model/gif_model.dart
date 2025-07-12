//modelo que respresenta un GIF representado por la API
import 'package:ejeapp/src/features/gif_grid/domain/entity/gif_entity.dart';

class GifModel extends GifEntity {
  GifModel({required super.id, required super.title, required super.url});

  static GifModel fromJson({required Map<String, dynamic> json}) {
    return GifModel(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      url: json['images']['fixed_height']['url'] ?? '',
    );
  }
}
