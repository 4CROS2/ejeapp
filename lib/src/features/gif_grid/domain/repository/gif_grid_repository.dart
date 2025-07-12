import 'package:ejeapp/src/features/gif_grid/domain/entity/gif_entity.dart';

abstract interface class GifGridRepository {
  Future<List<GifEntity>> fetchGifs();
}
