import "package:flutter/material.dart";

import "../../utils/icons_finder.dart";

enum ResourceType {
  none,
  stamina,
  magic,
  health,
}

extension ResourceTypeName on ResourceType {
  String get capitalizedName {
    switch (this) {
      case ResourceType.none:
        return "";
      case ResourceType.health:
        return 'Health';
      case ResourceType.stamina:
        return 'Stamina';
      case ResourceType.magic:
        return 'Magic';
      default:
        return 'Unknown';
    }
  }
}

enum ConsumptionType {
  none,
  spend,
  bind,
  burn,
}

extension ConsumptionTypeName on ConsumptionType {
  String get capitalizedName {
    switch (this) {
      case ConsumptionType.none:
        return "";
      case ConsumptionType.spend:
        return 'Spend';
      case ConsumptionType.bind:
        return 'Bind';
      case ConsumptionType.burn:
        return 'Burn';
      default:
        return 'Unknown';
    }
  }
}

class BasicResources {
  final Resource health;
  final Resource stamina;
  final Resource magic;

  const BasicResources({
    required this.health,
    required this.stamina,
    required this.magic,
  });
}

class Resource {
  final String title;
  final Color color;
  final IconFamily iconFamily;

  late int _minValue;
  int minMin;

  late int _maxValue;
  int maxMax;

  bool hasTemp;
  bool iconMode;

  late int _value;
  late int _tempValue;
  late int _boundValue;
  late int _burntValue;

  Resource({
    required this.title,
    required this.color,
    this.iconFamily = IconFamily.zeldaMagic,
    int minValue = 0,
    this.minMin = 0,
    int maxValue = 40,
    this.maxMax = 40,
    this.hasTemp = false,
    this.iconMode = false,
    int value = 0,
    int tempValue = 0,
    int boundValue = 0,
    int burntValue = 0,
  }) {
    this.minValue = minValue;
    this.maxValue = maxValue;
    this.boundValue = boundValue;
    this.burntValue = burntValue;
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
    if (_value > _maxValue - (_boundValue + _burntValue)) {
      _value = _maxValue - (_boundValue + _burntValue);
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

  int get boundValue => _boundValue;
  set boundValue(int value) {
    _boundValue = value;
    if (_boundValue < _minValue) {
      _boundValue = _minValue;
    }
    if (_boundValue > _maxValue) {
      _boundValue = _maxValue;
    }
  }

  int get burntValue => _burntValue;
  set burntValue(int value) {
    _burntValue = value;
    if (_burntValue < _minValue) {
      _burntValue = _minValue;
    }
    if (_burntValue > _maxValue) {
      _burntValue = _maxValue;
    }
  }

  void setBoundValue(int nValue) {
    final oldValue = boundValue;
    boundValue = nValue;
    value = value - (boundValue - oldValue);
  }

  void setBurntValue(int nValue) {
    final oldValue = burntValue;
    burntValue = nValue;
    value = value - ((burntValue - oldValue) < 0 ? 0 : (burntValue - oldValue));
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
    bool? iconMode,
    int? value,
    int? tempValue,
    int? boundValue,
    int? burntValue,
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
      iconMode: iconMode ?? this.iconMode,
      value: value ?? this.value,
      tempValue: tempValue ?? this.tempValue,
      boundValue: boundValue ?? this.boundValue,
      burntValue: burntValue ?? this.burntValue,
    );
  }
}
