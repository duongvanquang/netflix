import 'package:flutter/material.dart';
import '../theme/color_theme.dart';

class GameScreen extends StatelessWidget {
  const GameScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
      backgroundColor: NetFlixColorsTheme.greenColor,
      body: Column(
        children: const [Text('GameScreen')],
      ));
}
