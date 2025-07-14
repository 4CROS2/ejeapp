import 'package:ejeapp/firebase_options.dart';
import 'package:ejeapp/src/features/gif_grid/presentation/page/gif_grid_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:ejeapp/src/injection/injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  await Firebase.initializeApp(options:DefaultFirebaseOptions.currentPlatform);
  runApp(MyApp());
}

// Widget principal de la aplicación.
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Giphy Grid Example',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: GifGridScreen(), // Pantalla principal con GridView
    );
  }
}
