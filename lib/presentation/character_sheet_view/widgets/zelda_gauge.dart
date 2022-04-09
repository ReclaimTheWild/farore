import 'package:flutter/material.dart';

class ZeldaGauge extends StatefulWidget {
  int max;
  int temp;
  int value;

  final Color emptyColor;
  final Color mainColor;
  final Color tempColor;

  ZeldaGauge({
    required this.max,
    required this.value,
    this.temp = 0,
    this.emptyColor = Colors.black,
    required this.mainColor,
    this.tempColor = Colors.yellow,
    Key? key,
  }) : super(key: key);

  @override
  State<ZeldaGauge> createState() => _ZeldaGaugeState();
}

class _ZeldaGaugeState extends State<ZeldaGauge>
    with SingleTickerProviderStateMixin {
  late Animation<double> _animation;
  late AnimationController _controller;
  double _currentBegin = 0;
  double _currentEnd = 0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 100),
      vsync: this,
    );
    _animation = Tween<double>(begin: 0, end: 1).animate(_controller);
    triggerAnimation();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  void didUpdateWidget(covariant ZeldaGauge oldWidget) {
    super.didUpdateWidget(oldWidget);
    triggerAnimation();
  }

  void triggerAnimation() {
    setState(() {
      _currentBegin = _animation.value;

      if (widget.value == 0 || widget.max == 0) {
        _currentEnd = 0;
      } else {
        _currentEnd = widget.value.toDouble() / widget.max.toDouble();
      }

      _animation = Tween<double>(begin: _currentBegin, end: _currentEnd)
          .animate(_controller);
    });
    _controller.reset();
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) => _AnimatedZeldaGauge(
        animation: _animation,
        widget: widget,
      );
}

class _AnimatedZeldaGauge extends AnimatedWidget {
  final ZeldaGauge widget;

  const _AnimatedZeldaGauge({
    Key? key,
    required Animation<double> animation,
    required this.widget,
  }) : super(key: key, listenable: animation);

  double transformValue(num x, num begin, num end, num before) {
    final double y = (end * x - (begin - before)) * (1 / before);
    return y < 0 ? 0 : ((y > 1) ? 1 : y);
  }

  @override
  Widget build(BuildContext context) {
    final animation = listenable as Animation<double>;
    final mainColor = widget.mainColor;

    final progressWidgets = <Widget>[];
    const border = BorderRadius.only(
      topLeft: Radius.circular(7),
      bottomLeft: Radius.circular(7),
    );
    final border2 = BorderRadius.circular(7);
    final Widget progressWidget = Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            mainColor,
            HSLColor.fromColor(mainColor).withLightness(0.2).toColor(),
          ],
          begin: Alignment.topCenter,
          end: const Alignment(0, 4.0),
        ),
        borderRadius: animation.value == 1 ? border2 : border,
      ),
    );
    progressWidgets.add(progressWidget);

    return Directionality(
      textDirection: TextDirection.ltr,
      child: Container(
        height: 42,
        decoration: BoxDecoration(
          color: widget.emptyColor,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: Colors.grey.shade300,
            width: 3,
          ),
          boxShadow: const [
            BoxShadow(
              color: Colors.black,
              blurRadius: 3,
              spreadRadius: 1,
            ),
          ],
        ),
        child: Flex(
          direction: Axis.horizontal,
          verticalDirection: VerticalDirection.down,
          children: <Widget>[
            Expanded(
              flex: (animation.value * 100).toInt(),
              child: Stack(
                children: progressWidgets,
              ),
            ),
            Expanded(
              flex: 100 - (animation.value * 100).toInt(),
              child: Container(),
            ),
          ],
        ),
      ),
    );
  }
}
