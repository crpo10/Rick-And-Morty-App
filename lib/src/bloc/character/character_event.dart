part of 'character_bloc.dart';

@immutable
abstract class CharacterEvent {}

class GetCharacters extends CharacterEvent {}

class GetMoreCharacters extends CharacterEvent {}
