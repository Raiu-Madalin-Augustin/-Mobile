import 'dart:convert';
import 'package:flutter/material.dart';
import '../my_home_page.dart';
import 'package:http/http.dart' as http;

class AnimeProvider with ChangeNotifier {
  AnimeProvider() {
    fetchTasks();
  }

  List<Anime> _animes = [];

  List<Anime> get animes {
    return [..._animes];
  }

  fetchTasks() async {
    final url = Uri.parse('http://10.0.2.2:8000/apis/?format=json');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      var data = json.decode(response.body) as List;
      _animes = data.map<Anime>((json) => Anime.fromJson(json)).toList();
      notifyListeners();
    }
  }

  void addAnime(Anime anime) async {
    final url = Uri.parse('http://10.0.2.2:8000/apis/');
    final response = await http.post(url,
        headers: {"Content-Type": "application/json"},
        body: json.encode(anime));
    if (response.statusCode == 201) {
      anime.id = json.decode(response.body)['id'];
      _animes.add(anime);
      notifyListeners();
    }
  }

  void updateAnime(Anime anime, int index) async {
    final url = Uri.parse('http://10.0.2.2:8000/apis/${anime.id}/');
    final response = await http.put(url,
        headers: {"Content-Type": "application/json"},
        body: json.encode(anime));
    if (response.statusCode == 200) {
      _animes[index] = anime;
      notifyListeners();
    }
  }

  void deleteAnime(Anime anime) async {
    final url = Uri.parse('http://10.0.2.2:8000/apis/${anime.id}/');
    final response = await http.delete(url);
    if (response.statusCode == 204) {
      _animes.remove(anime);
      notifyListeners();
    }
  }
}
