import "package:flutter/material.dart";
import "package:icon_decoration/icon_decoration.dart";

import "../../../utils/icons_finder.dart";

class ZeldaResourceCounter extends StatefulWidget {
  final iconsFinder = const IconsFinder();

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

  final IconFamily iconFamily;

  const ZeldaResourceCounter({
    required this.max,
    required this.value,
    required this.tempValue,
    this.boundValue = 0,
    this.burntValue = 0,
    this.temp = 0,
    this.emptyColor = Colors.black,
    required this.mainColor,
    this.tempColor = Colors.yellow,
    this.boundColor = Colors.cyan,
    this.burntColor,
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
          hideBackground: true,
          iconFamily: widget.iconFamily,
          iconValue: quarterToIconValue(quarter),
          iconsFinder: widget.iconsFinder,
        ),
      );
    }
    final boundElements = <ZeldaResourceElement>[];
    int fBoundValue = widget.value + widget.boundValue;
    for (int i = 0; i < widget.max; i += 4) {
      final int quarter = fBoundValue > 4 ? 4 : fBoundValue;
      fBoundValue -= quarter;
      boundElements.add(
        ZeldaResourceElement(
          color: widget.boundColor,
          hideBackground: true,
          iconFamily: widget.iconFamily,
          iconValue: quarterToIconValue(quarter),
          iconsFinder: widget.iconsFinder,
        ),
      );
    }
    final burntElementsBack = <ZeldaResourceElement>[];
    int fBurntBackValue = widget.max;
    for (int i = 0; i < widget.max; i += 4) {
      final int quarter = fBurntBackValue > 4 ? 4 : fBurntBackValue;
      fBurntBackValue -= quarter;
      burntElementsBack.add(
        ZeldaResourceElement(
          color: widget.burntColor ?? Colors.purple.shade800,
          iconFamily: widget.iconFamily,
          iconValue: quarterToIconValue(quarter),
          iconsFinder: widget.iconsFinder,
        ),
      );
    }
    final notBurntElements = <ZeldaResourceElement>[];
    int fNotBurntValue = widget.max - widget.burntValue;
    for (int i = 0; i < widget.max; i += 4) {
      final int quarter = fNotBurntValue > 4 ? 4 : fNotBurntValue;
      fNotBurntValue -= quarter;
      notBurntElements.add(
        ZeldaResourceElement(
          color: Colors.grey.shade800,
          hideBackground: true,
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
      alignment: Alignment.center,
      children: [
        Wrap(
          alignment: WrapAlignment.start,
          children: burntElementsBack,
        ),
        Wrap(
          alignment: WrapAlignment.start,
          children: notBurntElements,
        ),
        Wrap(
          alignment: WrapAlignment.start,
          children: boundElements,
        ),
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
  final double size;

  const ZeldaResourceElement({
    Key? key,
    this.visibility = true,
    this.hideBackground = false,
    this.size = 42.0,
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
                size: size,
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
            size: size,
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
  final double size;

  const _ZeldaResourceElementOverlay({
    Key? key,
    required this.iconsFinder,
    required this.iconFamily,
    required this.iconValue,
    required this.color,
    required this.size,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DecoratedIcon(
      icon: Icon(
        iconsFinder.getIconData(iconFamily, iconValue),
        color: iconValue.index == 0 ? Colors.transparent : null,
        size: size,
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
