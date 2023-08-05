import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../model/character_model.dart';
import '../../repository/character_repository.dart';

part 'character_event.dart';
part 'character_state.dart';

class CharacterBloc extends Bloc<CharacterEvent, CharacterState> {
  final CharacterRepository characterRepository;

  CharacterBloc(this.characterRepository) : super(CharacterInitial()) {
    on<GetCharacters>((event, emit) async {
      if (state is CharacterInitial) {
        final characters = await characterRepository.getAllCharacters();
        emit(CharacterLoaded(characters: characters, hasReachedMax: false));
      } else if (state is CharacterLoaded && !_hasReachedMax(state)) {
        final characters = await characterRepository.getMoreCharacters();
        emit(
          characters.isEmpty
              ? (state as CharacterLoaded).copyWith(hasReachedMax: true)
              : CharacterLoaded(
                  characters:
                      (state as CharacterLoaded).characters! + characters,
                  hasReachedMax: false,
                ),
        );
      }
    });

    on<GetMoreCharacters>((event, emit) async {
      if (state is CharacterLoaded && !_hasReachedMax(state)) {
        final characters = await characterRepository.getMoreCharacters();
        emit(characters.isEmpty
            ? (state as CharacterLoaded).copyWith(hasReachedMax: true)
            : CharacterLoaded(
                characters: (state as CharacterLoaded).characters! + characters,
                hasReachedMax: false,
              ));
      }
    });
  }
  bool _hasReachedMax(CharacterState state) =>
      state is CharacterLoaded && state.hasReachedMax;
}
