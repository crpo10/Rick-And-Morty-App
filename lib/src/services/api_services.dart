import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:ricks_and_mortys_app/src/model/episode_model.dart';

import '../model/character_model.dart';

class ApiService {
  final Dio _dio = Dio();
  int _page = 2;
  int _episodePage = 2;

  Future<List<Character>> getCharacters() async {
    try {
      Response response =
          await _dio.get('https://rickandmortyapi.com/api/character');
      CharacterModel characterModel =
          characterModelFromJson(jsonEncode(response.data));

      List<Character> characters = characterModel.results!;

      return characters;
    } catch (e) {
      print(e);
      throw Exception(e);
    }
  }

  Future<List<Character>> getMoreCharacters() async {
    try {
      Response response = await _dio
          .get('https://rickandmortyapi.com/api/character?page=$_page');
      CharacterModel characterModel =
          characterModelFromJson(jsonEncode(response.data));

      List<Character> characters = characterModel.results!;
      _page++;

      return characters;
    } catch (e) {
      print(e);
      throw Exception(e);
    }
  }

  Future<List<Episode>> getEpisodes() async {
    try {
      Response response =
          await _dio.get('https://rickandmortyapi.com/api/episode');
      EpisodeModel characterModel =
          episodeModelFromJson(jsonEncode(response.data));

      List<Episode> episode = characterModel.results!;

      return episode;
    } catch (e) {
      print(e);
      throw Exception(e);
    }
  }

  Future<List<Episode>> getMoreEpisodes() async {
    try {
      Response response = await _dio
          .get('https://rickandmortyapi.com/api/episode?page=$_episodePage');
      EpisodeModel characterModel =
          episodeModelFromJson(jsonEncode(response.data));

      List<Episode> episode = characterModel.results!;
      print(episode);

      _episodePage++;

      return episode;
    } catch (e) {
      print(e);
      throw Exception(e);
    }
  }

  Future<List<Character>> searchCharacters(String query) async {
    try {
      Response response = await _dio
          .get('https://rickandmortyapi.com/api/character/?name=$query');
      CharacterModel characterModel =
          characterModelFromJson(jsonEncode(response.data));

      List<Character> characters = characterModel.results!;
      print(characters);

      return characters;
    } catch (e) {
      print(e);
      throw Exception(e);
    }
  }
}
