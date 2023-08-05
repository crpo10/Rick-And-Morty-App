import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../model/character_model.dart';
import '../../repository/character_repository.dart';

part 'search_character_event.dart';
part 'search_character_state.dart';

class SearchCharacterBloc
    extends Bloc<SearchCharacterEvent, SearchCharacterState> {
  final CharacterRepository characterRepository;
  SearchCharacterBloc(this.characterRepository)
      : super(SearchCharacterInitial()) {
    on<SearchCharacters>((event, emit) async {
      emit(CharacterSearching());

      try {
        final characters =
            await characterRepository.searchCharacters(event.query);

        emit(CharacterSearchResult(characters: characters));
      } catch (e) {
        emit(CharacterSearchError());
      }
    });
  }
}
