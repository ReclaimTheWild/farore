import 'package:flutter/material.dart';

import '../../utils/icons_finder.dart';

class Resource {
  final String title;
  final Color color;
  final IconFamily iconFamily;

  late int _minValue;
  int minMin;

  late int _maxValue;
  int maxMax;

  bool hasTemp;

  late int _value;
  late int _tempValue;

  Resource({
    required this.title,
    required this.color,
    this.iconFamily = IconFamily.zeldaMagic,
    int minValue = 0,
    this.minMin = 0,
    int maxValue = 40,
    this.maxMax = 40,
    this.hasTemp = false,
    int value = 0,
    int tempValue = 0,
  }) {
    this.minValue = minValue;
    this.maxValue = maxValue;
    this.value = value;
    this.tempValue = tempValue;
  }

  int get minValue => _minValue;
  set minValue(int value) {
    _minValue = value;
    if (_minValue < minMin) {
      _minValue = minMin;
    }
  }

  int get maxValue => _maxValue;
  set maxValue(int value) {
    _maxValue = value;
    if (_maxValue > maxMax) {
      _maxValue = maxMax;
    }
  }

  int get value => _value;
  set value(int value) {
    _value = value;
    if (_value < _minValue) {
      _value = _minValue;
    }
    if (_value > _maxValue) {
      _value = _maxValue;
    }
  }

  int get tempValue => _tempValue;
  set tempValue(int value) {
    _tempValue = value;
    if (_tempValue < _minValue) {
      _tempValue = _minValue;
    }
    if (_tempValue > _maxValue) {
      _tempValue = _maxValue;
    }
  }

  Resource copyWith({
    String? title,
    Color? color,
    IconFamily? iconFamily,
    int? minValue,
    int? minMin,
    int? maxValue,
    int? maxMax,
    bool? hasTemp,
    int? value,
    int? tempValue,
  }) {
    return Resource(
      title: title ?? this.title,
      color: color ?? this.color,
      iconFamily: iconFamily ?? this.iconFamily,
      minValue: minValue ?? this.minValue,
      minMin: minMin ?? this.minMin,
      maxValue: maxValue ?? this.maxValue,
      maxMax: maxMax ?? this.maxMax,
      hasTemp: hasTemp ?? this.hasTemp,
      value: value ?? this.value,
      tempValue: tempValue ?? this.tempValue,
    );
  }
}
