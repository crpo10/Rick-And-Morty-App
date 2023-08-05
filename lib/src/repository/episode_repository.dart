import 'package:ricks_and_mortys_app/src/model/episode_model.dart';

import '../services/api_services.dart';

class EpisodeRepository {
  final ApiService _apiService = ApiService();

  Future<List<Episode>> getAllEpisodes() {
    return _apiService.getEpisodes();
  }

  Future<List<Episode>> getMoreEpisodes() {
    return _apiService.getMoreEpisodes();
  }
}
