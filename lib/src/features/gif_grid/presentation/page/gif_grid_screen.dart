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
                return FadeTransition(
                  opacity: animation,
                  child: child,
                );
              },
              child: switch (state) {
                ErrorGift _ => Center(
                  child: Text(
                    'Error: ${state.message}',
                    style: TextStyle(color: Colors.red),
                  ),
                ),

                SuccessGift _ => GridView.builder(
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
                    return Card(
                      elevation: 3,
                      child: Column(
                        children: [
                          Expanded(
                            // Muestra el GIF usando Image.network
                            child: Image.network(gif.url, fit: BoxFit.cover),
                          ),
                          // Muestra el título en la parte inferior
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 4,
                              horizontal: 4,
                            ),
                            child: Text(
                              gif.title,
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                              // Opcional: Limitar el texto a 1 o 2 líneas
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
                _ => Center(child: CircularProgressIndicator()),
              },
            );
          },
        ),
      ),
    );
  }
}
