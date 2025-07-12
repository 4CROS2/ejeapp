import 'package:ejeapp/src/features/gif_grid/domain/entity/gif_entity.dart';
import 'package:ejeapp/src/features/gif_grid/domain/repository/gif_grid_repository.dart';

class GifGridUsecase {
  GifGridUsecase({required GifGridRepository repository})
    : _repository = repository;

  final GifGridRepository _repository;

  Future<List<GifEntity>> fetchGifs() async {
    return await _repository.fetchGifs();
  }
}
