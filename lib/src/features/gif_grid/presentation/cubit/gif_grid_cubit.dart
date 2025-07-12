import 'package:ejeapp/src/features/gif_grid/domain/entity/gif_entity.dart';
import 'package:ejeapp/src/features/gif_grid/domain/usecase/gif_grid_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'gif_grid_state.dart';

class GifGridCubit extends Cubit<GifGridState> {
  GifGridCubit({required GifGridUsecase gifGridUsecase})
    : _gifGridUsecase = gifGridUsecase,
      super(GifGridState());

  final GifGridUsecase _gifGridUsecase;

  void getGifs() async {
    try {
      emit(LoadingGift());
      final List<GifEntity> gifs = await _gifGridUsecase.fetchGifs();
      emit(SuccessGift(gifs: gifs));
    } catch (e) {
      emit(ErrorGift(message: e.toString()));
    }
  }
}
