import "package:flutter/material.dart";

class ZeldaGauge extends StatefulWidget {
  final int max;
  final int temp;
  final int value;
  final int tempValue;
  final int boundValue;
  final int burntValue;

  final Color emptyColor;
  final Color mainColor;
  final Color tempColor;
  final Color boundColor;
  final Color? burntColor;

  const ZeldaGauge({
    required this.max,
    required this.value,
    required this.tempValue,
    required this.boundValue,
    required this.burntValue,
    this.temp = 0,
    this.emptyColor = Colors.black,
    required this.mainColor,
    this.tempColor = Colors.yellow,
    this.boundColor = Colors.cyan,
    this.burntColor,
    Key? key,
  }) : super(key: key);

  @override
  State<ZeldaGauge> createState() => _ZeldaGaugeState();
}

class _ZeldaGaugeState extends State<ZeldaGauge>
    with SingleTickerProviderStateMixin {
  late Animation<double> _animation;
  late Animation<double> _tempAnimation;

  late AnimationController _controller;

  double _currentBegin = 0;
  double _currentEnd = 0;

  double _tempCurrentBegin = 0;
  double _tempCurrentEnd = 0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 100),
      vsync: this,
    );
    _animation = Tween<double>(begin: 0, end: 1).animate(_controller);
    _tempAnimation = Tween<double>(begin: 0, end: 1).animate(_controller);
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

      _tempCurrentBegin = _tempAnimation.value;

      if (widget.tempValue == 0 || widget.max == 0) {
        _tempCurrentEnd = 0;
      } else {
        _tempCurrentEnd = widget.tempValue.toDouble() / widget.max.toDouble();
      }

      _tempAnimation =
          Tween<double>(begin: _tempCurrentBegin, end: _tempCurrentEnd)
              .animate(_controller);
    });
    _controller.reset();
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) => _AnimatedZeldaGauges(
        animation: _animation,
        tempAnimation: _tempAnimation,
        value: widget.value,
        tempValue: widget.tempValue,
        boundValue: widget.boundValue,
        burntValue: widget.burntValue,
        maxValue: widget.max,
        widget: widget,
      );
}

class _AnimatedZeldaGauges extends StatelessWidget {
  final ZeldaGauge widget;

  final Animation<double> animation;
  final Animation<double> tempAnimation;

  final int value;
  final int tempValue;
  final int boundValue;
  final int burntValue;
  final int maxValue;

  const _AnimatedZeldaGauges({
    Key? key,
    required this.animation,
    required this.tempAnimation,
    required this.value,
    required this.tempValue,
    required this.boundValue,
    required this.burntValue,
    required this.maxValue,
    required this.widget,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
        child: Stack(
          alignment: AlignmentDirectional.center,
          children: [
            _AnimatedZeldaGauge(
              animation: animation,
              value: value,
              boundValue: boundValue,
              burntValue: burntValue,
              maxValue: maxValue,
              color: widget.mainColor,
              boundColor: widget.boundColor,
              burntColor: widget.burntColor ?? Colors.purple.shade800,
            ),
            _AnimatedZeldaGauge(
              animation: tempAnimation,
              value: tempValue,
              maxValue: maxValue,
              color: widget.tempColor,
            ),
          ],
        ),
      ),
    );
  }
}

class _AnimatedZeldaGauge extends AnimatedWidget {
  final Color color;

  final int value;
  final int boundValue;
  final int burntValue;
  final int maxValue;

  final Color? boundColor;
  final Color? burntColor;

  const _AnimatedZeldaGauge({
    Key? key,
    required Animation<double> animation,
    required this.value,
    this.boundValue = 0,
    this.burntValue = 0,
    required this.maxValue,
    required this.color,
    this.boundColor,
    this.burntColor,
  }) : super(key: key, listenable: animation);

  double transformValue(num x, num begin, num end, num before) {
    final double y = (end * x - (begin - before)) * (1 / before);
    return y < 0 ? 0 : ((y > 1) ? 1 : y);
  }

  @override
  Widget build(BuildContext context) {
    final animation = listenable as Animation<double>;

    final progressWidgets = <Widget>[];
    const border = BorderRadius.only(
      topLeft: Radius.circular(7),
      bottomLeft: Radius.circular(7),
    );
    final border2 = BorderRadius.circular(7);
    const border3 = BorderRadius.only(
      topRight: Radius.circular(7),
      bottomRight: Radius.circular(7),
    );
    final Widget progressWidget = Container(
      height: 42,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            color,
            HSLColor.fromColor(color).withLightness(0.2).toColor(),
          ],
          begin: Alignment.topCenter,
          end: const Alignment(0, 4.0),
        ),
        borderRadius: boundValue == 0 && burntValue == 0 && value == maxValue
            ? border2
            : border,
      ),
    );
    progressWidgets.add(progressWidget);

    return Flex(
      direction: Axis.horizontal,
      verticalDirection: VerticalDirection.down,
      children: <Widget>[
        Expanded(
          flex: (animation.value * 100).toInt(),
          child: Stack(
            children: progressWidgets,
          ),
        ),
        if (boundValue > 0)
          Expanded(
            flex: (boundValue * 100) ~/ maxValue,
            child: Container(
              height: 42,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    boundColor ?? Colors.cyan,
                    HSLColor.fromColor(boundColor ?? Colors.cyan)
                        .withLightness(0.2)
                        .toColor(),
                  ],
                  begin: Alignment.topCenter,
                  end: const Alignment(0, 4.0),
                ),
                borderRadius: burntValue == 0 && value + boundValue == maxValue
                    ? border3
                    : BorderRadius.zero,
              ),
            ),
          ),
        if (value + burntValue + boundValue < maxValue)
          Expanded(
            flex: 100 -
                ((animation.value * 100) +
                        ((boundValue * 100) ~/ maxValue) +
                        ((burntValue * 100) ~/ maxValue))
                    .toInt(),
            child: Container(),
          ),
        if (burntValue > 0)
          Expanded(
            flex: (burntValue * 100) ~/ maxValue,
            child: Container(
              height: 42,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    burntColor ?? Colors.purple.shade800,
                    HSLColor.fromColor(burntColor ?? Colors.purple.shade800)
                        .withLightness(0.2)
                        .toColor(),
                  ],
                  begin: Alignment.topCenter,
                  end: const Alignment(0, 4.0),
                ),
                borderRadius: border3,
              ),
            ),
          ),
      ],
    );
  }
}
