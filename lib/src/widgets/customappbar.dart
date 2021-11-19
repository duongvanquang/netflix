import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import '../theme/color_theme.dart';

class CustomAppBar extends StatefulWidget {
  late final ScrollController? scrollController;
  final bool? iShowLogoAndAvatar;
  final bool showAppBar;
  final bool backgroundAppBar;
  CustomAppBar(
      {Key? key,
      this.scrollController,
      this.iShowLogoAndAvatar,
      this.showAppBar = true,
      this.backgroundAppBar = true})
      : super(key: key);

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  // late ScrollController _scrollController;

  // @override
  // void initState() {
  //   widget.scrollController = ScrollController()
  //     ..addListener(() {
  //       iShowLogoAndAvatar =
  //           widget.scrollController!.position.userScrollDirection ==
  //               ScrollDirection.forward;

  //       if (_showAppBar != iShowLogoAndAvatar) {
  //         setState(() {
  //           _showAppBar = iShowLogoAndAvatar;
  //         });
  //       }

  //       if (widget.scrollController!.offset >=
  //           widget.scrollController!.position.minScrollExtent + 80) {
  //         setState(() {
  //           _backgroundAppBar = false;
  //         });
  //       } else {
  //         setState(() {
  //           _backgroundAppBar = true;
  //         });
  //       }
  //     });

  //   super.initState();
  // }

  // @override
  // void dispose() {
  //   widget.scrollController!.dispose();

  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) => appBar(context);

  SingleChildScrollView appBar(BuildContext context) {
    return SingleChildScrollView(
      controller: widget.scrollController,
      child: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 24),
          color: Colors.black,
          // .withOpacity(
          //     (widget.scrollOffset / 350).clamp(0, 1).toDouble()),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (widget.showAppBar)
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
                          image: AssetImage(
                              'assets/images/anh-girl-xinh-9-1.jpeg')),
                    )
                  ],
                )
              else
                const SizedBox.shrink(),
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
                        Icons.download,
                        size: 32,
                        color: NetFlixColorsTheme.primaryWhite,
                      )
                    ],
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
