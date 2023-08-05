import '../model/character_model.dart';
import '../services/api_services.dart';

class CharacterRepository {
  final ApiService _apiService = ApiService();

  Future<List<Character>> getAllCharacters() {
    return _apiService.getCharacters();
  }

  Future<List<Character>> getMoreCharacters() {
    return _apiService.getMoreCharacters();
  }

  Future<List<Character>> searchCharacters(String query) {
    return _apiService.searchCharacters(query);
  }
}
