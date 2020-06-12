import 'package:flutter/material.dart';

class BuilderAnimateWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _BuilderAnimateState();
}

class _BuilderAnimateState extends State<BuilderAnimateWidget> with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<double> animation;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 1000)
    );

    final CurvedAnimation curve = CurvedAnimation(
        parent: controller,
        curve: Curves.elasticOut
    );

    animation = Tween(begin: 50.0, end: 200.0).animate(curve);

    controller.repeat(reverse: true);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedBuilder(
        animation: animation,
        child:  FlutterLogo(),
        builder: (context, child) => Container(
          width: animation.value,
          height: animation.value,
          child: child,
        ),
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
