import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ricks_and_mortys_app/src/bloc/searchCharater/search_character_bloc.dart';
import 'package:ricks_and_mortys_app/src/model/character_model.dart';
import 'package:ricks_and_mortys_app/src/ui/widgets/custom_appbar.dart';

import 'details_page.dart';

class SearchCharactersPage extends StatefulWidget {
  const SearchCharactersPage({super.key});

  @override
  State<SearchCharactersPage> createState() => _SearchCharactersPageState();
}

class _SearchCharactersPageState extends State<SearchCharactersPage> {
  final TextEditingController searchController = TextEditingController();
  final FocusNode searchFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      searchFocusNode.requestFocus();
    });
  }

  @override
  Widget build(BuildContext context) {
    final characterBloc = BlocProvider.of<SearchCharacterBloc>(context);
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
              title: '',
              isSearch: false,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
              ),
              child: TextField(
                focusNode: searchFocusNode,
                decoration: const InputDecoration(
                  hintText: 'Busca personajes por su nombre',
                ),
                onChanged: (query) {
                  if (query.length > 3) {
                    characterBloc.add(SearchCharacters(query));
                  }
                },
              ),
            ),
            BlocBuilder<SearchCharacterBloc, SearchCharacterState>(
              builder: (context, state) {
                if (state is CharacterSearching) {
                  return const Expanded(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                } else if (state is CharacterSearchResult) {
                  return Expanded(
                    child: ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      itemCount: state.characters!.length,
                      itemBuilder: (_, i) {
                        final character = state.characters![i];

                        return FadeInUp(
                          duration: const Duration(seconds: 1),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => DetailsPage(
                                    character: character,
                                  ),
                                ),
                              );
                            },
                            child: characterCard(size, character),
                          ),
                        );
                      },
                    ),
                  );
                } else if (state is CharacterSearchError) {
                  return const Center(
                    child: Text('Parace que este personaje no existe :C'),
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

  Padding characterCard(Size size, Character character) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Container(
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.grey),
        ),
        child: Row(
          children: [
            SizedBox(
              width: size.width * 0.4,
              height: size.height * 0.3,
              child: Image.network(
                character.image!,
                fit: BoxFit.cover,
              ),
            ),
            Container(
              width: size.width * 0.5,
              height: size.height * 0.2,
              padding: const EdgeInsets.all(15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: size.width * 0.4,
                    child: Text(
                      character.name!,
                      style: TextStyle(fontSize: size.height * 0.025),
                    ),
                  ),
                  Text(
                    character.status!,
                    style: TextStyle(color: checkAlive(character.status!)),
                  ),
                  Text(character.location!.name!),
                  Text(character.species!),
                  Text(character.gender!),
                  Text(character.origin!.name!),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Color checkAlive(String text) {
    if (text == 'Alive') {
      return Colors.green;
    }
    return Colors.red;
  }

  @override
  void dispose() {
    searchController.dispose();
    searchFocusNode.dispose();

    super.dispose();
  }
}
