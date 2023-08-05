part of 'episode_bloc.dart';

@immutable
abstract class EpisodeEvent {}

class GetEpisode extends EpisodeEvent {}

class GetMoreEpisodes extends EpisodeEvent {}
