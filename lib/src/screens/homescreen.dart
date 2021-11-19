import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/configuration/configuration_bloc.dart';
import '../blocs/configuration/configuration_event.dart';
import '../blocs/configuration/configuration_state.dart';
import '../blocs/tvshow/tvshow_bloc.dart';
import '../blocs/tvshow/tvshow_event.dart';
import '../blocs/tvshow/tvshow_state.dart';
import '../model/movies_configuration.dart';
import '../theme/color_theme.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late ScrollController _scrollController;
  late bool iShowLogoAndAvatar = false;
  bool _showAppBar = true;
  bool _backgroundAppBar = true;
  @override
  void initState() {
    super.initState();
    context.read<ConfigurationBloc>().add(ConfigurationStarted());
    context.read<TvshowBloc>().add(TvShowLoaded());
    _scrollController = ScrollController()
      ..addListener(() {
        iShowLogoAndAvatar = _scrollController.position.userScrollDirection ==
            ScrollDirection.forward;
        if (_showAppBar != iShowLogoAndAvatar) {
          setState(() {
            _showAppBar = iShowLogoAndAvatar;
          });
        }
        if (_scrollController.offset >=
            _scrollController.position.minScrollExtent + 80) {
          setState(() {
            _backgroundAppBar = false;
          });
        } else {
          setState(() {
            _backgroundAppBar = true;
          });
        }
      });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: Colors.black87,
        appBar: PreferredSize(
            preferredSize: Size(screenSize.width, 90), child: appBar(context)),
        body: SingleChildScrollView(
            controller: _scrollController,
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Stack(
                children: [
                  SizedBox(
                    width: double.infinity,
                    height: 550,
                    child: ShaderMask(
                        shaderCallback: (rect) => LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Colors.grey.shade900,
                                Colors.transparent
                              ],
                            ).createShader(Rect.fromLTRB(0, 0, 0, rect.height)),
                        blendMode: BlendMode.dstIn,
                        child: const Image(
                          image: AssetImage('assets/images/netflix_logo0.png'),
                          fit: BoxFit.fill,
                        )),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10, bottom: 15),
                    child: Text(
                      tr('homescreen.titlelist'),
                      style: Theme.of(context)
                          .textTheme
                          .headline3!
                          .copyWith(color: NetFlixColorsTheme.primaryWhite),
                    ),
                  ),
                  BlocBuilder<TvshowBloc, TvshowState>(
                      builder: (context, state) {
                    if (state is TvShowLoadInProgress) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (state is TvShowLoadSuccess) {
                      return SizedBox(
                        height: 200,
                        width: double.infinity,
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            physics: const ScrollPhysics(),
                            itemCount: state.airingTVShowsData.length,
                            itemBuilder: (context, index) {
                              final tvShowData = state.airingTVShowsData[index];
                              return Card(
                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                elevation: 10,
                                child: Row(
                                  children: [
                                    BlocBuilder<ConfigurationBloc,
                                        ConfigurationState>(
                                      builder: (context, state) {
                                        if (state
                                            is ConfigurationStartSuccess) {
                                          return CachedNetworkImage(
                                              imageUrl:
                                                  '''${state.configuration.getPosterSize(PosterSize.big)}${tvShowData.posterPath}''',
                                              fit: BoxFit.fill,
                                              errorWidget: (context, url,
                                                      error) =>
                                                  Container(
                                                    decoration:
                                                        const BoxDecoration(
                                                      image: DecorationImage(
                                                        image: AssetImage(
                                                            'assets/images/img_not_found.png'),
                                                      ),
                                                    ),
                                                  ));
                                        }
                                        return Text(tr(
                                            '''homescreen.configurationfailure'''));
                                      },
                                    ),
                                  ],
                                ),
                              );
                            }),
                      );
                    }
                    return Text(tr('tvshowbloc.statefailure'));
                  }),
                ],
              ),
              const SizedBox(height: 15),
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10, top: 17, bottom: 6),
                  child: Text(
                    tr('homescreen.titlepopular'),
                    style: Theme.of(context)
                        .textTheme
                        .headline3!
                        .copyWith(color: NetFlixColorsTheme.primaryWhite),
                  ),
                ),
                BlocBuilder<TvshowBloc, TvshowState>(builder: (context, state) {
                  if (state is TvShowLoadInProgress) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is TvShowLoadSuccess) {
                    return SizedBox(
                      height: 200,
                      width: double.infinity,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          physics: const ScrollPhysics(),
                          itemCount: state.popularTVShowData.length,
                          itemBuilder: (context, index) {
                            final tvShowData = state.popularTVShowData[index];
                            return Card(
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                              elevation: 10,
                              child: Row(
                                children: [
                                  BlocBuilder<ConfigurationBloc,
                                      ConfigurationState>(
                                    builder: (context, state) {
                                      if (state is ConfigurationStartSuccess) {
                                        return CachedNetworkImage(
                                            imageUrl:
                                                '''${state.configuration.getPosterSize(PosterSize.big)}${tvShowData.posterPath}''',
                                            fit: BoxFit.fill,
                                            errorWidget:
                                                (context, url, error) =>
                                                    Container(
                                                      decoration:
                                                          const BoxDecoration(
                                                        image: DecorationImage(
                                                          image: AssetImage(
                                                              'assets/images/img_not_found.png'),
                                                        ),
                                                      ),
                                                    ));
                                      }
                                      return Text(tr(
                                          '''homescreen.configurationfailure'''));
                                    },
                                  ),
                                ],
                              ),
                            );
                          }),
                    );
                  }
                  return Text(tr('tvshowbloc.statefailure'));
                })
              ]),

              const SizedBox(height: 15),
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10, top: 17, bottom: 6),
                  child: Text(
                    tr('homescreen.titletrending'),
                    style: Theme.of(context)
                        .textTheme
                        .headline3!
                        .copyWith(color: NetFlixColorsTheme.primaryWhite),
                  ),
                ),
                BlocBuilder<TvshowBloc, TvshowState>(builder: (context, state) {
                  if (state is TvShowLoadInProgress) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is TvShowLoadSuccess) {
                    return SizedBox(
                      height: 200,
                      width: double.infinity,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          physics: const ScrollPhysics(),
                          itemCount: state.onTheAirTVShowData.length,
                          itemBuilder: (context, index) {
                            final tvShowData = state.onTheAirTVShowData[index];
                            return Card(
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                              elevation: 10,
                              child: Row(
                                children: [
                                  BlocBuilder<ConfigurationBloc,
                                      ConfigurationState>(
                                    builder: (context, state) {
                                      if (state is ConfigurationStartSuccess) {
                                        return CachedNetworkImage(
                                            imageUrl:
                                                '''${state.configuration.getPosterSize(PosterSize.big)}${tvShowData.posterPath}''',
                                            fit: BoxFit.fill,
                                            errorWidget:
                                                (context, url, error) =>
                                                    Container(
                                                      decoration:
                                                          const BoxDecoration(
                                                        image: DecorationImage(
                                                          image: AssetImage(
                                                              'assets/images/img_not_found.png'),
                                                        ),
                                                      ),
                                                    ));
                                      }
                                      return Text(tr(
                                          '''homescreen.configurationfailure'''));
                                    },
                                  ),
                                ],
                              ),
                            );
                          }),
                    );
                  }
                  return Text(tr('tvshowbloc.statefailure'));
                })
              ]),

              const SizedBox(height: 15),
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10, top: 17, bottom: 6),
                  child: Text(tr('homescreen.titlewatch'),
                      style: Theme.of(context)
                          .textTheme
                          .headline3!
                          .copyWith(color: NetFlixColorsTheme.primaryWhite)),
                ),
                BlocBuilder<TvshowBloc, TvshowState>(builder: (context, state) {
                  if (state is TvShowLoadInProgress) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is TvShowLoadSuccess) {
                    return SizedBox(
                      height: 200,
                      width: double.infinity,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          physics: const ScrollPhysics(),
                          itemCount: state.topRedTVShowsData.length,
                          itemBuilder: (context, index) {
                            final tvShowData = state.topRedTVShowsData[index];
                            return Card(
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                              elevation: 10,
                              child: Row(
                                children: [
                                  BlocBuilder<ConfigurationBloc,
                                      ConfigurationState>(
                                    builder: (context, state) {
                                      if (state is ConfigurationStartSuccess) {
                                        return CachedNetworkImage(
                                            imageUrl:
                                                '''${state.configuration.getPosterSize(PosterSize.big)}${tvShowData.posterPath}''',
                                            fit: BoxFit.fill,
                                            errorWidget:
                                                (context, url, error) =>
                                                    Container(
                                                      decoration:
                                                          const BoxDecoration(
                                                        image: DecorationImage(
                                                          image: AssetImage(
                                                              'assets/images/img_not_found.png'),
                                                        ),
                                                      ),
                                                    ));
                                      }
                                      return Text(tr(
                                          '''homescreen.configurationfailure'''));
                                    },
                                  ),
                                ],
                              ),
                            );
                          }),
                    );
                  }
                  return Text(tr('tvshowbloc.statefailure'));
                })
              ]),

              const SizedBox(height: 60)
              //   ],
              // )
            ])),
        floatingActionButton: _showAppBar
            ? FloatingActionButton.extended(
                onPressed: () {},
                backgroundColor: NetFlixColorsTheme.primaryWhite,
                icon: const Image(
                    height: 40,
                    image: AssetImage('assets/images/random-button.png')),
                label: Text(
                  tr('homescreen.random'),
                  style: Theme.of(context)
                      .textTheme
                      .headline4!
                      .copyWith(color: NetFlixColorsTheme.pinkRandomColor),
                ))
            : FloatingActionButton(
                onPressed: () {},
                backgroundColor: NetFlixColorsTheme.primaryWhite,
                child: const Image(
                  height: 40,
                  image: AssetImage('assets/images/random-button.png'),
                ),
              ));
  }

  Widget appBar(BuildContext context) => Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(horizontal: 24),
        color: _showAppBar ? Colors.transparent : Colors.black45,
        child: Column(
          children: [
            const SizedBox(height: 40),
            if (_showAppBar)
              Row(
                children: const [
                  Image(
                    height: 30,
                    width: 30,
                    image: AssetImage('assets/images/netflix_logo0.png'),
                  ),
                  Spacer(),
                  Icon(
                    Icons.search,
                    size: 32,
                    color: NetFlixColorsTheme.primaryWhite,
                  ),
                  SizedBox(width: 30),
                  ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(50)),
                    child: Image(
                        width: 50,
                        height: 50,
                        image:
                            AssetImage('assets/images/anh-girl-xinh-9-1.jpeg')),
                  )
                ],
              )
            else
              const SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  tr('homescreen.tvshow'),
                  style: Theme.of(context)
                      .textTheme
                      .headline3!
                      .copyWith(color: NetFlixColorsTheme.primaryWhite),
                ),
                Text(
                  tr('homescreen.movies'),
                  style: Theme.of(context)
                      .textTheme
                      .headline3!
                      .copyWith(color: NetFlixColorsTheme.primaryWhite),
                ),
                Row(
                  children: [
                    Text(
                      tr('homescreen.categories'),
                      style: Theme.of(context)
                          .textTheme
                          .headline3!
                          .copyWith(color: NetFlixColorsTheme.primaryWhite),
                    ),
                    const Icon(
                      Icons.arrow_drop_down,
                      size: 32,
                      color: NetFlixColorsTheme.primaryWhite,
                    )
                  ],
                ),
              ],
            )
          ],
        ),
      );
}
