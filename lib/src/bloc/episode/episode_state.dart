part of 'episode_bloc.dart';

@immutable
abstract class EpisodeState {}

class EpisodeInitial extends EpisodeState {}

class EpisodeLoading extends EpisodeState {}

class EpisodeLoaded extends EpisodeState {
  final List<Episode> episodes;
  final bool hasReachMax;

  EpisodeLoaded({required this.episodes, this.hasReachMax = false});

  EpisodeLoaded copyWith({
    final List<Episode>? episodes,
    bool? hasReachMax,
  }) {
    return EpisodeLoaded(
      episodes: episodes ?? this.episodes,
      hasReachMax: hasReachMax ?? this.hasReachMax,
    );
  }
}

class EpisodeError extends EpisodeState {}
