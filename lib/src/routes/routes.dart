import 'package:flutter/material.dart';
import 'package:ricks_and_mortys_app/src/ui/pages/characters_page.dart';
import 'package:ricks_and_mortys_app/src/ui/pages/details_page.dart';
import 'package:ricks_and_mortys_app/src/ui/pages/episodes_page.dart';
import 'package:ricks_and_mortys_app/src/ui/pages/home_page.dart';

import '../ui/pages/search_characters_page.dart';

Map<String, Widget Function(BuildContext)> routes = {
  'home': (_) => const HomePage(),
  'episodes': (_) => const EpisodesPage(),
  'details': (_) => const DetailsPage(),
  'characters': (_) => const CharactersPage(),
  'searchCharacters': (_) => const SearchCharactersPage(),
};
