import 'package:ejeapp/src/features/gif_grid/data/datasource/gif_datasource.dart';
import 'package:ejeapp/src/features/gif_grid/data/repository/gif_repository_impl.dart';
import 'package:ejeapp/src/features/gif_grid/domain/repository/gif_grid_repository.dart';
import 'package:ejeapp/src/features/gif_grid/domain/usecase/gif_grid_usecase.dart';
import 'package:ejeapp/src/features/gif_grid/presentation/cubit/gif_grid_cubit.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //datasource
  sl.registerLazySingleton<GifDatasource>(() => IGifDatasource());

  //repository
  sl.registerLazySingleton<GifGridRepository>(
    () => IGifRepository(datasource: sl<GifDatasource>()),
  );

  //usecase
  sl.registerLazySingleton(
    () => GifGridUsecase(repository: sl<GifGridRepository>()),
  );
  //cubit
  sl.registerFactory(() => GifGridCubit(gifGridUsecase: sl<GifGridUsecase>()));
}
