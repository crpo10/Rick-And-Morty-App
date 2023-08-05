part of 'search_character_bloc.dart';

@immutable
abstract class SearchCharacterState {}

class SearchCharacterInitial extends SearchCharacterState {}

class CharacterSearching extends SearchCharacterState {}

class CharacterSearchResult extends SearchCharacterState {
  final List<Character>? characters;

  CharacterSearchResult({this.characters});
}

class CharacterSearchError extends SearchCharacterState {}
