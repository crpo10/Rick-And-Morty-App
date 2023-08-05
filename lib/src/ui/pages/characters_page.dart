import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ricks_and_mortys_app/src/bloc/character/character_bloc.dart';

import 'package:ricks_and_mortys_app/src/model/character_model.dart';

import '../widgets/custom_appbar.dart';
import 'details_page.dart';

class CharactersPage extends StatefulWidget {
  const CharactersPage({super.key});

  @override
  State<CharactersPage> createState() => _CharactersPageState();
}

class _CharactersPageState extends State<CharactersPage> {
  late ScrollController _scrollController;
  late CharacterBloc _characterBloc;

  @override
  void initState() {
    _scrollController = ScrollController();
    _characterBloc = context.read<CharacterBloc>();
    _scrollController.addListener(_onScroll);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            CustomAppBar(
              widget: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: const Padding(
                  padding: EdgeInsets.only(right: 10),
                  child: Icon(Icons.arrow_back_ios_new),
                ),
              ),
              title: 'Personajes',
            ),
            BlocBuilder<CharacterBloc, CharacterState>(
              builder: (context, state) {
                if (state is CharacterLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is CharacterLoaded) {
                  return Expanded(
                    child: GridView.builder(
                      controller: _scrollController,
                      physics: const BouncingScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 5,
                        mainAxisSpacing: 5,
                      ),
                      itemCount: state.characters!.length,
                      itemBuilder: (_, i) {
                        final character = state.characters![i];

                        return _listItem(
                          character,
                          size,
                          () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => DetailsPage(
                                  character: character,
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  );
                } else if (state is CharacterError) {
                  return const Center(
                    child: Text('Parace que ocurrió un error'),
                  );
                } else {
                  return Container();
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  GestureDetector _listItem(
    Character character,
    Size size,
    void Function() onTapItem,
  ) {
    return GestureDetector(
      onTap: onTapItem,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Image.network(
          character.image!,
          fit: BoxFit.cover,
          loadingBuilder: (BuildContext context, Widget child,
              ImageChunkEvent? loadingProgress) {
            if (loadingProgress == null) {
              return child; // Retorna la imagen si ya se ha cargado completamente.
            }
            return Center(
              child: CircularProgressIndicator(
                value: loadingProgress.expectedTotalBytes != null
                    ? loadingProgress.cumulativeBytesLoaded /
                        loadingProgress.expectedTotalBytes!
                    : null,
              ),
            );
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isBottom) _characterBloc.add(GetMoreCharacters());
  }

  bool get _isBottom {
    return _scrollController.offset >=
            _scrollController.position.maxScrollExtent &&
        !_scrollController.position.outOfRange;
  }
}
