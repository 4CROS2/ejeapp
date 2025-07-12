import 'package:ejeapp/src/features/gif_grid/domain/entity/gif_entity.dart';
import 'package:ejeapp/src/features/gif_grid/presentation/cubit/gif_grid_cubit.dart';
import 'package:ejeapp/src/injection/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GifGridScreen extends StatefulWidget {
  const GifGridScreen({super.key});

  @override
  State<GifGridScreen> createState() => _GifGridScreenState();
}

class _GifGridScreenState extends State<GifGridScreen> {
  /// Función que consume la API de Giphy para obtener los GIFs en tendencia

  @override
  Widget build(BuildContext context) {
    // Muestra los GIFs en un GridView.
    return Scaffold(
      appBar: AppBar(title: Text('GIFs en Tendencia')),
      body: BlocProvider<GifGridCubit>(
        create: (context) => sl<GifGridCubit>()..getGifs(),
        child: BlocBuilder<GifGridCubit, GifGridState>(
          builder: (BuildContext context, GifGridState state) {
            return AnimatedSwitcher(
              duration: Duration(milliseconds: 4000),
              transitionBuilder: (child, animation) {
                return FadeTransition(opacity: animation, child: child);
              },
              child: switch (state) {
                ErrorGift _ => Center(
                  key: ValueKey('error'),
                  child: Text(
                    'Error: ${state.message}',
                    style: TextStyle(color: Colors.red),
                  ),
                ),

                SuccessGift _ => GridView.builder(
                  key: ValueKey('success'),
                  // Ajustamos la cantidad de columnas con gridDelegate
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, // 2 columnas
                    crossAxisSpacing: 8.0, // Espacio horizontal entre celdas
                    mainAxisSpacing: 8.0, // Espacio vertical entre celdas
                    childAspectRatio:
                        0.8, // Ajusta la altura/anchura de cada celda
                  ),
                  itemCount: state.gifs.length,
                  padding: const EdgeInsets.all(8.0),
                  itemBuilder: (context, index) {
                    final gif = state.gifs[index];

                    // Cada elemento de la cuadrícula será una "tarjeta" que muestre el GIF.
                    return AnimationCard(gif: gif);
                  },
                ),
                _ => Center(
                  key: ValueKey('loading'),
                  child: CircularProgressIndicator(),
                ),
              },
            );
          },
        ),
      ),
    );
  }
}

class AnimationCard extends StatefulWidget {
  const AnimationCard({super.key, required this.gif});

  final GifEntity gif;

  @override
  State<AnimationCard> createState() => _AnimationCardState();
}

class _AnimationCardState extends State<AnimationCard>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller);
    _controller.forward(); // Inicia la animación al construir el widget
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return ScaleTransition(
          scale: _animation,
          child: Opacity(
            opacity: _animation.value,
            child: child,
          ),
        );
      },
      child: Card(
        elevation: 3,
        child: Column(
          children: [
            Expanded(
              // Muestra el GIF usando Image.network
              child: Image.network(widget.gif.url, fit: BoxFit.cover),
            ),
            // Muestra el título en la parte inferior
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 4),
              child: Text(
                widget.gif.title,
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                // Opcional: Limitar el texto a 1 o 2 líneas
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  @override
  bool get wantKeepAlive => true;
}
