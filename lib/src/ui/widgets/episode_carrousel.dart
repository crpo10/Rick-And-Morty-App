import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ricks_and_mortys_app/src/model/episode_model.dart';

import '../../bloc/episode/episode_bloc.dart';

class EpisodesCarrousel extends StatefulWidget {
  const EpisodesCarrousel({super.key, this.widget, this.leftPadding});

  final double? leftPadding;
  final Widget? widget;

  @override
  State<EpisodesCarrousel> createState() => _EpisodesCarrouselState();
}

class _EpisodesCarrouselState extends State<EpisodesCarrousel> {
  final ScrollController _controller = ScrollController();
  Timer? _timer;
  double itemWidth = 50;

  @override
  void initState() {
    _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
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
                  'Episodios',
                  style: TextStyle(fontSize: size.height * 0.025),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, 'episodes');
                  },
                  child: Text(
                    'Ver Mas',
                    style: TextStyle(
                        color: Colors.green, fontSize: size.height * 0.02),
                  ),
                ),
              ],
            ),
          ),
          BlocBuilder<EpisodeBloc, EpisodeState>(
            builder: (context, state) {
              if (state is EpisodeLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is EpisodeLoaded) {
                return Expanded(
                  child: ListView.builder(
                    controller: _controller,
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemCount: state.episodes.length,
                    itemBuilder: (_, i) {
                      final episode = state.episodes[i];

                      return listItem(episode, i, size, () {});
                    },
                  ),
                );
              } else if (state is EpisodeError) {
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

  GestureDetector listItem(
    Episode episode,
    int i,
    Size size,
    void Function() onTapItem,
  ) {
    return GestureDetector(
      onTap: onTapItem,
      child: Container(
        margin: i == 0
            ? EdgeInsets.only(left: widget.leftPadding ?? 20, right: 10)
            : const EdgeInsets.symmetric(horizontal: 10),
        height: size.height * 0.18,
        width: size.width * 0.3,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
              child: SizedBox(
                height: size.height * 0.12,
                child: Image.asset(
                  'assets/intros.jpeg',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Text(
              episode.name!,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: size.height * 0.018),
            ),
            Text(
              episode.episode!,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: size.height * 0.018),
            )
          ],
        ),
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
