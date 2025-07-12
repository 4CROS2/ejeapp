import 'package:ejeapp/src/features/gif_grid/data/datasource/gif_datasource.dart';
import 'package:ejeapp/src/features/gif_grid/data/model/gif_model.dart';
import 'package:ejeapp/src/features/gif_grid/domain/repository/gif_grid_repository.dart';

class IGifRepository implements GifGridRepository {
  IGifRepository({required GifDatasource datasource})
    : _datasource = datasource;

  final GifDatasource _datasource;

  @override
  Future<List<GifModel>> fetchGifs() async {
    final response = await _datasource.getGifs();
    final data = response['data'] as List<dynamic>;
    return data.map((entry) => GifModel.fromJson(json: entry)).toList();
    // Alternative if response is actually a List:
    // return response.map((json) => GifModel.fromJson(json: json)).toList();
  }
}
