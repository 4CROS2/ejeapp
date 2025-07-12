//modelo que respresenta un GIF representado por la API
class GifModel {
  final String id;
  final String title;
  final String url;
  GifModel({required this.id, required this.title, required this.url});
  factory GifModel.fromJson(Map<String, dynamic> json) {
    return GifModel(
      id: json['id'],
      title: json['title'],
      url: json['images']['fixed_heigh']['url'],
    );
  }
} 