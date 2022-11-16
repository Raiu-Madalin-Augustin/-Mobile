import 'package:flutter/material.dart';
import 'my_home_page.dart';

class RegisterAnime extends StatefulWidget {
  const RegisterAnime({super.key});

  @override
  State<StatefulWidget> createState() => _RegisterAnime();
}

class _RegisterAnime extends State<RegisterAnime> {
  late TextEditingController controllerName;
  late TextEditingController controllerGenre;
  late TextEditingController controllerSeasons;
  late TextEditingController controllerEpisodes;
  late TextEditingController controllerRating;

  @override
  void initState() {
    controllerName = TextEditingController();
    controllerGenre = TextEditingController();
    controllerSeasons = TextEditingController();
    controllerEpisodes = TextEditingController();
    controllerRating = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("New Anime"),
        ),
        body: ListView(
          children: [
            TextField(controller: controllerName),
            TextField(controller: controllerGenre),
            TextField(controller: controllerSeasons),
            TextField(controller: controllerEpisodes),
            TextField(controller: controllerRating),
            ElevatedButton(
                onPressed: () {
                  String name = controllerName.text;
                  String genre = controllerGenre.text;
                  String seasons = controllerRating.text;
                  String episodes = controllerEpisodes.text;
                  String rating = controllerRating.text;

                  if (name.isNotEmpty &&
                      genre.isNotEmpty &&
                      seasons.isNotEmpty &&
                      episodes.isNotEmpty &&
                      rating.isNotEmpty) {
                    Navigator.pop(
                        context,
                        Anime(
                            name: name,
                            genre: genre,
                            numberOfSeasonsWatched: int.parse(seasons),
                            numberOfEpisodesWatched: int.parse(episodes),
                            rating: int.parse(rating)));
                  }
                },
                child: const Text("Add Anime")),
          ],
        ));
  }
}
