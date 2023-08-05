import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ricks_and_mortys_app/src/ui/widgets/characters_carrousel.dart';

import 'package:ricks_and_mortys_app/src/ui/widgets/custom_appbar.dart';
import 'package:ricks_and_mortys_app/src/ui/widgets/home_image_container.dart';

import '../../bloc/character/character_bloc.dart';
import '../../bloc/episode/episode_bloc.dart';
import '../widgets/episode_carrousel.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    context.read<EpisodeBloc>().add(GetEpisode());
    context.read<CharacterBloc>().add(GetCharacters());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            const CustomAppBar(
              isTitle: false,
            ),
            const HomeImageContainer(),
            FadeInLeft(child: const EpisodesCarrousel()),
            FadeInRight(child: const CharacterCarrousel()),
            SizedBox(
              height: size.height * 0.1,
            )
          ],
        ),
      ),
    );
  }
}
