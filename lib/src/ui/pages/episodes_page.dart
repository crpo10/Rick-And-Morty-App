import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ricks_and_mortys_app/src/bloc/episode/episode_bloc.dart';

import '../../model/episode_model.dart';
import '../widgets/custom_appbar.dart';

class EpisodesPage extends StatefulWidget {
  const EpisodesPage({super.key});

  @override
  State<EpisodesPage> createState() => _EpisodesPageState();
}

class _EpisodesPageState extends State<EpisodesPage> {
  late ScrollController _scrollController;
  late EpisodeBloc _episodeBloc;

  @override
  void initState() {
    _scrollController = ScrollController();
    _episodeBloc = context.read<EpisodeBloc>();
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
              title: 'Episodios',
            ),
            BlocBuilder<EpisodeBloc, EpisodeState>(
              builder: (context, state) {
                if (state is EpisodeLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is EpisodeLoaded) {
                  return Expanded(
                    child: GridView.builder(
                      controller: _scrollController,
                      physics: const BouncingScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 0,
                        crossAxisSpacing: 5,
                      ),
                      itemCount: state.episodes.length,
                      itemBuilder: (_, i) {
                        final episode = state.episodes[i];

                        return _listItem(episode, size, () {});
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
      ),
    );
  }

  GestureDetector _listItem(
    Episode episode,
    Size size,
    void Function() onTapItem,
  ) {
    return GestureDetector(
      onTap: onTapItem,
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
              child: SizedBox(
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
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isBottom) _episodeBloc.add(GetMoreEpisodes());
  }

  bool get _isBottom {
    return _scrollController.offset >=
            _scrollController.position.maxScrollExtent &&
        !_scrollController.position.outOfRange;
  }
}
