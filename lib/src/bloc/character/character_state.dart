part of 'character_bloc.dart';

@immutable
abstract class CharacterState {}

class CharacterInitial extends CharacterState {}

class CharacterLoading extends CharacterState {}

class CharacterLoaded extends CharacterState {
  final List<Character>? characters;
  final bool hasReachedMax;

  CharacterLoaded({this.characters, this.hasReachedMax = false});

  CharacterLoaded copyWith({
    List<Character>? characters,
    bool? hasReachedMax,
  }) {
    return CharacterLoaded(
      characters: characters ?? this.characters,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }
}

class CharacterError extends CharacterState {}
