import 'package:anime_heaven/database.dart';
import 'package:anime_heaven/register_anime.dart';
import 'package:flutter/material.dart';

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
    return Scaffold(
      appBar: AppBar(
        title: Text(widget._title),
        centerTitle: true,
      ),
      body: Center(
        child: FutureBuilder<List<Anime>>(
            future: DatabaseHelper.instance.getGroceries(),
            builder:
                (BuildContext context, AsyncSnapshot<List<Anime>> snapshot) {
              if (!snapshot.hasData) {
                return Center(child: Text('Loading...'));
              }
              return snapshot.data!.isEmpty
                  ? Center(child: Text('No Animes in List.'))
                  : Center(
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
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            return Padding(
                                padding:
                                    EdgeInsets.only(left: 3, right: 3, top: 10),
                                child: ListTile(
                                  textColor: Colors.white,
                                  onTap: () {
                                    Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (_) => ModifyAnime(
                                                    snapshot.data![index])))
                                        .then((newAnime) {
                                      if (newAnime != null) {
                                        setState(() {
                                          DatabaseHelper.instance
                                              .update(newAnime);

                                          messageResponse(
                                              context,
                                              newAnime.name +
                                                  " Has been modified...!");
                                        });
                                      }
                                    });
                                  },
                                  onLongPress: () {
                                    removeAnime(context, snapshot.data![index]);
                                  },
                                  title: Text(snapshot.data![index].name),
                                  subtitle: Text(snapshot.data![index].genre),
                                  leading: CircleAvatar(
                                    backgroundColor: Colors.deepPurple[800],
                                    child: Text(
                                        snapshot.data![index].name
                                            .substring(0, 1),
                                        style: const TextStyle(
                                            color: Colors.white)),
                                  ),
                                  trailing: Text.rich(TextSpan(children: [
                                    TextSpan(
                                        text:
                                            "${snapshot.data![index].rating}/10",
                                        style: const TextStyle(
                                            color: Colors.white)),
                                    const WidgetSpan(
                                        child: Icon(Icons.rate_review_rounded)),
                                  ])),
                                ));
                          },
                        ),
                      ),
                    );
            }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
                  MaterialPageRoute(builder: (_) => const RegisterAnime()))
              .then((newAnime) {
            if (newAnime != null) {
              DatabaseHelper.instance.add(newAnime);
              messageResponse(context, newAnime.name + " was added...!");
              setState(() {});
            }
          });
        },
        tooltip: "Add Anime",
        child: const Icon(Icons.add),
      ),
    );
  }

  removeAnime(BuildContext context, Anime anime) {
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
                        DatabaseHelper.instance.remove(anime.id!);
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
  final int? id;
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

  factory Anime.fromMap(Map<String, dynamic> json) => new Anime(
        id: json['id'],
        name: json['name'],
        genre: json['genre'],
        numberOfSeasonsWatched: json['numberOfSeasonsWatched'],
        numberOfEpisodesWatched: json['numberOfEpisodesWatched'],
        rating: json['rating'],
      );

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'genre': genre,
      'numberOfSeasonsWatched': numberOfSeasonsWatched,
      'numberOfEpisodesWatched': numberOfEpisodesWatched,
      'rating': rating
    };
  }
}

messageResponse(BuildContext context, String name) {
  showDialog(
      context: context,
      builder: (_) => AlertDialog(
            title: const Text("Update Message...!"),
            content: Text("Anime $name"),
          ));
}
