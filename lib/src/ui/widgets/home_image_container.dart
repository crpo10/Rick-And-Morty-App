import 'dart:math';

import 'package:flutter/material.dart';

class HomeImageContainer extends StatefulWidget {
  const HomeImageContainer({super.key});

  @override
  State<HomeImageContainer> createState() => _HomeImageContainerState();
}

class _HomeImageContainerState extends State<HomeImageContainer>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 10),
      vsync: this,
    )..repeat();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Transform.rotate(
          angle: _controller.value * 2 * pi,
          child: child,
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        height: size.height * 0.4,
        width: size.width,
        child: Image.asset('assets/portal.png'),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
