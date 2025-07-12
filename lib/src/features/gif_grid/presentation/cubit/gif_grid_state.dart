part of 'gif_grid_cubit.dart';

class GifGridState extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadingGift extends GifGridState {}

class SuccessGift extends GifGridState {
  SuccessGift({required this.gifs});
  final List<GifEntity> gifs;

  @override
  List<Object?> get props => [gifs];
}

class ErrorGift extends GifGridState {
  ErrorGift({required this.message});
  final String message;

  @override
  List<Object?> get props => [message];
}
