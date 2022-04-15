import "package:flutter/material.dart";
import "package:icon_decoration/icon_decoration.dart";

import "../../../utils/icons_finder.dart";

class ZeldaResourceCounter extends StatefulWidget {
  final iconsFinder = const IconsFinder();

  final int max;
  final int temp;
  final int value;
  final int tempValue;

  final Color emptyColor;
  final Color mainColor;
  final Color tempColor;

  final IconFamily iconFamily;

  const ZeldaResourceCounter({
    required this.max,
    required this.value,
    required this.tempValue,
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
    final tempElements = <ZeldaResourceElement>[];
    int ftValue = widget.tempValue;
    for (int i = 0; i < widget.max; i += 4) {
      final int quarter = ftValue > 4 ? 4 : ftValue;
      ftValue -= quarter;
      tempElements.add(
        ZeldaResourceElement(
          color: widget.tempColor,
          hideBackground: true,
          iconFamily: widget.iconFamily,
          iconValue: quarterToIconValue(quarter),
          iconsFinder: widget.iconsFinder,
        ),
      );
    }
    return Stack(
      children: [
        Wrap(
          alignment: WrapAlignment.start,
          children: elements,
        ),
        Wrap(
          alignment: WrapAlignment.start,
          children: tempElements,
        ),
      ],
    );
  }
}

class ZeldaResourceElement extends StatelessWidget {
  final IconFamily iconFamily;
  final IconValue iconValue;
  final IconsFinder iconsFinder;
  final Color color;
  final bool visibility;
  final bool hideBackground;

  const ZeldaResourceElement({
    Key? key,
    this.visibility = true,
    this.hideBackground = false,
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
          if (hideBackground == false)
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
    return DecoratedIcon(
      icon: Icon(
        iconsFinder.getIconData(iconFamily, iconValue),
        color: iconValue.index == 0 ? Colors.transparent : null,
        size: 48,
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
  }
}
