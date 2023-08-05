import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ricks_and_mortys_app/src/bloc/searchCharater/search_character_bloc.dart';

import 'package:ricks_and_mortys_app/src/routes/routes.dart';
import 'package:ricks_and_mortys_app/src/bloc/episode/episode_bloc.dart';
import 'package:ricks_and_mortys_app/src/bloc/character/character_bloc.dart';
import 'package:ricks_and_mortys_app/src/repository/episode_repository.dart';
import 'package:ricks_and_mortys_app/src/repository/character_repository.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final CharacterRepository characterRepository = CharacterRepository();
    final EpisodeRepository episodeRepository = EpisodeRepository();

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => CharacterBloc(characterRepository)),
        BlocProvider(create: (_) => SearchCharacterBloc(characterRepository)),
        BlocProvider(create: (_) => EpisodeBloc(episodeRepository)),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Rick and Morty',
        initialRoute: 'home',
        routes: routes,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSwatch().copyWith(
            primary: Colors.green,
          ),
        ),
      ),
    );
  }
}
