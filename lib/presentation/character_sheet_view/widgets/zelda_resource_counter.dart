import 'package:flutter/material.dart';
import 'package:icon_decoration/icon_decoration.dart';
import 'package:simple_animations/simple_animations.dart';

import '../../../utils/icons_finder.dart';

class ZeldaResourceCounter extends StatefulWidget {
  final iconsFinder = const IconsFinder();

  int max;
  int temp;
  int value;

  final Color emptyColor;
  final Color mainColor;
  final Color tempColor;

  final IconFamily iconFamily;

  ZeldaResourceCounter({
    required this.max,
    required this.value,
    this.temp = 0,
    this.emptyColor = Colors.black,
    required this.mainColor,
    this.tempColor = Colors.yellow,
    required this.iconFamily,
    Key? key,
  }) : super(key: key);

  @override
  State<ZeldaResourceCounter> createState() => _ZeldaResourceCounterState();
}

class _ZeldaResourceCounterState extends State<ZeldaResourceCounter> {
  IconValue quarterToIconValue(int q) {
    switch (q) {
      case 1:
        return IconValue.h25;
      case 2:
        return IconValue.h50;
      case 3:
        return IconValue.h75;
      case 4:
        return IconValue.full;
      default:
        return IconValue.container;
    }
  }

  @override
  Widget build(BuildContext context) {
    final elements = <ZeldaResourceElement>[];
    int fValue = widget.value;
    for (int i = 0; i < widget.max; i += 4) {
      final int quarter = fValue > 4 ? 4 : fValue;
      fValue -= quarter;
      elements.add(
        ZeldaResourceElement(
          color: widget.mainColor,
          iconFamily: widget.iconFamily,
          iconValue: quarterToIconValue(quarter),
          iconsFinder: widget.iconsFinder,
        ),
      );
    }
    for (int i = elements.length; i < 12; i++) {
      elements.add(
        ZeldaResourceElement(
          visibility: false,
          color: widget.emptyColor,
          iconFamily: widget.iconFamily,
          iconValue: IconValue.container,
          iconsFinder: widget.iconsFinder,
        ),
      );
    }
    if (elements.length <= 6) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: elements,
      );
    } else {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            children: elements.sublist(0, 6),
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            children: elements.sublist(6, elements.length),
          ),
        ],
      );
    }
  }
}

class ZeldaResourceElement extends StatelessWidget {
  final IconFamily iconFamily;
  final IconValue iconValue;
  final IconsFinder iconsFinder;
  final Color color;
  final bool visibility;

  const ZeldaResourceElement({
    Key? key,
    this.visibility = true,
    required this.iconFamily,
    required this.iconValue,
    required this.iconsFinder,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: visibility,
      maintainAnimation: true,
      maintainState: true,
      maintainSize: true,
      child: Stack(
        alignment: AlignmentDirectional.center,
        children: [
          DecoratedIcon(
            icon: Icon(
              iconsFinder.getIconData(iconFamily, IconValue.full),
              color: Colors.grey.shade800,
              size: 48,
            ),
            decoration: const IconDecoration(
              border: IconBorder(
                color: Colors.black87,
                width: 4,
              ),
              shadows: [
                Shadow(
                  blurRadius: 2,
                  offset: Offset(2, 0),
                )
              ],
            ),
          ),
          _ZeldaResourceElementOverlay(
            iconsFinder: iconsFinder,
            iconFamily: iconFamily,
            iconValue: iconValue,
            color: color,
          ),
        ],
      ),
    );
  }
}

class _ZeldaResourceElementOverlay extends StatelessWidget {
  final IconsFinder iconsFinder;
  final IconFamily iconFamily;
  final IconValue iconValue;
  final Color color;

  const _ZeldaResourceElementOverlay({
    Key? key,
    required this.iconsFinder,
    required this.iconFamily,
    required this.iconValue,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomAnimation<double>(
      control: CustomAnimationControl.stop,
      tween: Tween<double>(begin: 48, end: 44),
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      startPosition: 0,
      animationStatusListener: (status) {
        print("status updated: $status");
      },
      builder: (context, child, value) {
        return DecoratedIcon(
          icon: Icon(
            iconsFinder.getIconData(iconFamily, iconValue),
            color: iconValue.index == 0 ? Colors.transparent : null,
            size: value,
          ),
          decoration: iconValue.index != 0
              ? IconDecoration(
                  gradient: LinearGradient(
                    colors: [
                      HSLColor.fromColor(color).withLightness(0.8).toColor(),
                      color,
                      HSLColor.fromColor(color).withLightness(0.2).toColor(),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                )
              : null,
        );
      },
    );
  }
}
