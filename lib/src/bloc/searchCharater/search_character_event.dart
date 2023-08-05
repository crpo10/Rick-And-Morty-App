part of 'search_character_bloc.dart';

@immutable
abstract class SearchCharacterEvent {}

class SearchCharacters extends SearchCharacterEvent {
  final String query;

  SearchCharacters(this.query);
}
