import 'package:anime_heaven/api/api.dart';
import 'package:anime_heaven/database.dart';
import 'package:anime_heaven/register_anime.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'modify_anime.dart';

class MyHomePage extends StatefulWidget {
  final String _title;

  MyHomePage(this._title);

  @override
  State<StatefulWidget> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    final animeProvider = Provider.of<AnimeProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(widget._title),
        centerTitle: true,
      ),
      body:  Center(
        child: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [
                  Colors.blue,
                  Color.fromRGBO(205, 85, 213, 296),
                ],
              )),
          child: ListView.builder(
            itemCount: animeProvider.animes.length,
            itemBuilder: (context, index) {
              return Padding(
                  padding:  EdgeInsets.only(left: 3, right: 3, top: 10),
                  child: ListTile(
                    textColor: Colors.white,
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => ModifyAnime(animeProvider.animes[index])))
                          .then((newAnime) {
                        if (newAnime != null) {
                          setState(() {
                            animeProvider.updateAnime(newAnime,index);
                            messageResponse(context,
                                newAnime.name + " Has been modified...!");
                          });
                        }
                      });
                    },
                    onLongPress: () {
                      removeAnime(context, animeProvider.animes[index],animeProvider);
                    },
                    title: Text(animeProvider.animes[index].name),
                    subtitle: Text(animeProvider.animes[index].genre),
                    leading:  CircleAvatar(
                      backgroundColor: Colors.deepPurple[800],
                      child: Text(animeProvider.animes[index].name.substring(0, 1),style: const TextStyle(color:Colors.white)),
                    ),
                    trailing: Text.rich(TextSpan(children: [
                      TextSpan(text: "${animeProvider.animes[index].rating}/10",style: const TextStyle(color:Colors.white)),
                      const WidgetSpan(
                          child: Icon(Icons.star_border_purple500_sharp)),
                    ])),
                  ));
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (_) => const RegisterAnime()))
              .then((newAnime) {
            if (newAnime != null) {
              setState(() {
                animeProvider.addAnime(newAnime);
                messageResponse(context, newAnime.name + " was added...!");
              });
            }
          });
        },
        tooltip: "Add Anime",
        child: const Icon(Icons.add),
      ),
    );
  }

  removeAnime(BuildContext context, Anime anime, AnimeProvider animeProvider) {
    showDialog(
        context: context,
        builder: (_) => AlertDialog(
              title: Text("Delete Anime"),
              content:
                  Text("Are you sure you want to delete " + anime.name + "?"),
              actions: [
                TextButton(
                  onPressed: () {
                    setState(() {
                      try {
                        animeProvider.deleteAnime(anime);
                      } on Exception catch (_) {
                        rethrow;
                      }
                      Navigator.pop(context);
                    });
                  },
                  child: const Text(
                    "Delete",
                    style: TextStyle(color: Colors.red),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text(
                    "Cancel",
                    style: TextStyle(color: Colors.blue),
                  ),
                )
              ],
            ));
  }
}

class Anime {
  int? id;
  var name;
  var genre;
  var numberOfSeasonsWatched;
  var numberOfEpisodesWatched;
  var rating;

  Anime(
      {this.id,
      this.name,
      this.genre,
      this.numberOfSeasonsWatched,
      this.numberOfEpisodesWatched,
      this.rating});

  factory Anime.fromJson(Map<String, dynamic> json) {
    return Anime(
        id: json['id'],
        name: json['name'],
        genre: json['genre'],
        numberOfSeasonsWatched: json['numberOfSeasonsWatched'],
        numberOfEpisodesWatched: json['numberOfEpisodesWatched'],
        rating: json['rating']);
  }

  dynamic toJson() => {
        'id': id,
        'name': name,
        'genre': genre,
        'numberOfSeasonsWatched': numberOfSeasonsWatched,
        'numberOfEpisodesWatched': numberOfEpisodesWatched,
        'rating': rating
      };
}

messageResponse(BuildContext context, String name) {
  showDialog(
      context: context,
      builder: (_) => AlertDialog(
            title: const Text("Update Message...!"),
            content: Text("Anime $name"),
          ));
}
