import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ricks_and_mortys_app/src/bloc/character/character_bloc.dart';
import 'package:ricks_and_mortys_app/src/ui/pages/details_page.dart';

class CharacterCarrousel extends StatefulWidget {
  const CharacterCarrousel({
    super.key,
    this.leftPadding,
  });

  final double? leftPadding;

  @override
  State<CharacterCarrousel> createState() => _CharacterCarrouselState();
}

class _CharacterCarrouselState extends State<CharacterCarrousel> {
  final ScrollController _controller = ScrollController();
  Timer? _timer;
  double itemWidth = 50;

  @override
  void initState() {
    _timer = Timer.periodic(const Duration(seconds: 4), (timer) {
      if (_controller.hasClients) {
        if (_controller.offset >= _controller.position.maxScrollExtent &&
            !_controller.position.outOfRange) {
          _controller.animateTo(
            0,
            duration: const Duration(milliseconds: 600),
            curve: Curves.easeInOut,
          ); // Si es el último item, vuelve al principio.
        } else {
          _controller.animateTo(
            _controller.offset + itemWidth,
            duration: const Duration(milliseconds: 600),
            curve: Curves.easeInOut,
          );
        }
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    itemWidth = size.width * 0.3;

    return SizedBox(
      height: size.height * 0.22,
      width: size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(
                left: widget.leftPadding ?? 20, top: 10, bottom: 10, right: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Personajes',
                  style: TextStyle(fontSize: size.height * 0.025),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, 'characters');
                  },
                  child: Text(
                    'Ver Mas',
                    style: TextStyle(
                        color: Colors.green, fontSize: size.height * 0.02),
                  ),
                )
              ],
            ),
          ),
          BlocBuilder<CharacterBloc, CharacterState>(
            builder: (context, state) {
              if (state is CharacterLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is CharacterLoaded) {
                return Expanded(
                  child: ListView.builder(
                    controller: _controller,
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemCount: state.characters?.length ?? 0,
                    itemBuilder: (_, i) {
                      final character = state.characters![i];

                      return GestureDetector(
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
                        child: Container(
                          margin: i == 0
                              ? EdgeInsets.only(
                                  left: widget.leftPadding ?? 20, right: 10)
                              : const EdgeInsets.symmetric(horizontal: 10),
                          height: size.height * 0.18,
                          width: size.width * 0.3,
                          child: Hero(
                            tag: character.id!,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Image.network(
                                character.image!,
                                fit: BoxFit.cover,
                                loadingBuilder: (BuildContext context,
                                    Widget child,
                                    ImageChunkEvent? loadingProgress) {
                                  if (loadingProgress == null) {
                                    return child; // Retorna la imagen si ya se ha cargado completamente.
                                  }
                                  return Center(
                                    child: CircularProgressIndicator(
                                      value:
                                          loadingProgress.expectedTotalBytes !=
                                                  null
                                              ? loadingProgress
                                                      .cumulativeBytesLoaded /
                                                  loadingProgress
                                                      .expectedTotalBytes!
                                              : null,
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
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
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    _timer?.cancel();
    super.dispose();
  }
}
