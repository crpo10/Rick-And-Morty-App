import 'package:bloc/bloc.dart';

import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:ricks_and_mortys_app/src/repository/episode_repository.dart';

import '../../model/episode_model.dart';

part 'episode_event.dart';
part 'episode_state.dart';

class EpisodeBloc extends Bloc<EpisodeEvent, EpisodeState> {
  final EpisodeRepository episodeRepository;

  EpisodeBloc(this.episodeRepository) : super(EpisodeInitial()) {
    on<GetEpisode>((event, emit) async {
      if (state is EpisodeInitial) {
        final episodes = await episodeRepository.getAllEpisodes();
        emit(EpisodeLoaded(episodes: episodes, hasReachMax: false));
      } else if (state is EpisodeLoaded && !_hasReachedMax(state)) {
        final episodes = await episodeRepository.getMoreEpisodes();
        emit(
          episodes.isEmpty
              ? (state as EpisodeLoaded).copyWith(hasReachMax: true)
              : EpisodeLoaded(
                  episodes: (state as EpisodeLoaded).episodes + episodes,
                  hasReachMax: false,
                ),
        );
      }
    });

    on<GetMoreEpisodes>((event, emit) async {
      if (state is EpisodeLoaded && !_hasReachedMax(state)) {
        final episodes = await episodeRepository.getMoreEpisodes();
        emit(episodes.isEmpty
            ? (state as EpisodeLoaded).copyWith(hasReachMax: true)
            : EpisodeLoaded(
                episodes: (state as EpisodeLoaded).episodes + episodes,
                hasReachMax: false,
              ));
      }
    });
  }
  bool _hasReachedMax(EpisodeState state) =>
      state is EpisodeLoaded && state.hasReachMax;
}
