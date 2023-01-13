import 'package:anime_heaven/api/api.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'my_home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => AnimeProvider(),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Anime Heaven',
          theme: ThemeData(
            primarySwatch: Colors.blue,
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          home: MyHomePage("Anime Heaven"),
        ));
  }
}
