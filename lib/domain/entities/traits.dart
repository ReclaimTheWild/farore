import 'package:flutter/material.dart';

class Traits {
  final String title;

  final PowerAspect power;
  final WisdomAspect wisdom;
  final CourageAspect courage;

  const Traits({
    this.title = "Traits",
    required this.power,
    required this.wisdom,
    required this.courage,
  });

  Traits copyWith({
    String? title,
    PowerAspect? power,
    WisdomAspect? wisdom,
    CourageAspect? courage,
  }) {
    return Traits(
      title: title ?? this.title,
      power: power ?? this.power,
      wisdom: wisdom ?? this.wisdom,
      courage: courage ?? this.courage,
    );
  }

  int get tokenPriceTotal =>
      power.tokenPriceTotal + wisdom.tokenPriceTotal + courage.tokenPriceTotal;
}

class PowerAspect extends Aspect {
  const PowerAspect({
    String title = "Power",
    Color color = Colors.red,
    int injuries = 0,
    required List<Trait> traits,
  })  : assert(traits.length == 8, 'Traits must have 8 elements'),
        super(
          title: title,
          injuries: injuries,
          traits: traits,
          color: color,
        );

  Trait get combat => traits[traits.indexWhere((e) => e.id == "combat")];
  Trait get hearts => traits[traits.indexWhere((e) => e.id == "hearts")];
  Trait get athletics => traits[traits.indexWhere((e) => e.id == "athletics")];
  Trait get civilization =>
      traits[traits.indexWhere((e) => e.id == "civilization")];
  Trait get fortitude => traits[traits.indexWhere((e) => e.id == "fortitude")];
  Trait get intimidate =>
      traits[traits.indexWhere((e) => e.id == "intimidate")];
  Trait get mechanics => traits[traits.indexWhere((e) => e.id == "mechanics")];
  Trait get smithing => traits[traits.indexWhere((e) => e.id == "smithing")];

  PowerAspect copyWith({
    String? title,
    int? injuries,
    List<Trait>? traits,
    Trait? trait,
  }) {
    final _traits = traits ?? this.traits;
    if (trait != null) {
      _traits[_traits.indexWhere((e) => e.id == trait.id)] = trait;
    }
    return PowerAspect(
      title: title ?? this.title,
      injuries: injuries ?? this.injuries,
      traits: _traits,
    );
  }

  static PowerAspect init() => PowerAspect(
        title: "Power",
        injuries: 0,
        traits: [
          Trait(id: "combat", title: "Combat"),
          Trait(id: "hearts", title: "Hearts"),
          Trait(id: "athletics", title: "Athletics"),
          Trait(id: "civilization", title: "Civilization"),
          Trait(id: "fortitude", title: "Fortitude"),
          Trait(id: "intimidate", title: "Intimidate"),
          Trait(id: "mechanics", title: "Mechanics"),
          Trait(id: "smithing", title: "Smithing"),
        ],
      );
}

class WisdomAspect extends Aspect {
  const WisdomAspect({
    String title = "Wisdom",
    Color color = Colors.blueAccent,
    int injuries = 0,
    required List<Trait> traits,
  })  : assert(traits.length == 8, 'Traits must have 8 elements'),
        super(
          title: title,
          injuries: injuries,
          traits: traits,
          color: color,
        );

  Trait get willpower => traits[traits.indexWhere((e) => e.id == "willpower")];
  Trait get magic => traits[traits.indexWhere((e) => e.id == "magic")];
  Trait get arcana => traits[traits.indexWhere((e) => e.id == "arcana")];
  Trait get perception =>
      traits[traits.indexWhere((e) => e.id == "perception")];
  Trait get influence => traits[traits.indexWhere((e) => e.id == "influence")];
  Trait get perform => traits[traits.indexWhere((e) => e.id == "perform")];
  Trait get discipline =>
      traits[traits.indexWhere((e) => e.id == "discipline")];
  Trait get enchanting =>
      traits[traits.indexWhere((e) => e.id == "enchanting")];

  WisdomAspect copyWith({
    String? title,
    int? injuries,
    List<Trait>? traits,
    Trait? trait,
  }) {
    final _traits = traits ?? this.traits;
    if (trait != null) {
      _traits[_traits.indexWhere((e) => e.id == trait.id)] = trait;
    }
    return WisdomAspect(
      title: title ?? this.title,
      injuries: injuries ?? this.injuries,
      traits: _traits,
    );
  }

  static WisdomAspect init() => WisdomAspect(
        title: "Wisdom",
        injuries: 0,
        traits: [
          Trait(id: "willpower", title: "Willpower"),
          Trait(id: "magic", title: "Magic"),
          Trait(id: "arcana", title: "Arcana"),
          Trait(id: "perception", title: "Perception"),
          Trait(id: "influence", title: "Influence"),
          Trait(id: "perform", title: "Perform"),
          Trait(id: "discipline", title: "Discipline"),
          Trait(id: "enchanting", title: "Enchanting"),
        ],
      );
}

class CourageAspect extends Aspect {
  const CourageAspect({
    String title = "Courage",
    Color color = Colors.green,
    int injuries = 0,
    required List<Trait> traits,
  })  : assert(traits.length == 8, 'Traits must have 8 elements'),
        super(
          title: title,
          injuries: injuries,
          traits: traits,
          color: color,
        );

  Trait get accuracy => traits[traits.indexWhere((e) => e.id == "accuracy")];
  Trait get stamina => traits[traits.indexWhere((e) => e.id == "stamina")];
  Trait get nature => traits[traits.indexWhere((e) => e.id == "nature")];
  Trait get agility => traits[traits.indexWhere((e) => e.id == "agility")];
  Trait get command => traits[traits.indexWhere((e) => e.id == "command")];
  Trait get insight => traits[traits.indexWhere((e) => e.id == "insight")];
  Trait get guile => traits[traits.indexWhere((e) => e.id == "guile")];
  Trait get cooking => traits[traits.indexWhere((e) => e.id == "cooking")];

  CourageAspect copyWith({
    String? title,
    int? injuries,
    List<Trait>? traits,
    Trait? trait,
  }) {
    final _traits = traits ?? this.traits;
    if (trait != null) {
      _traits[_traits.indexWhere((e) => e.id == trait.id)] = trait;
    }
    return CourageAspect(
      title: title ?? this.title,
      injuries: injuries ?? this.injuries,
      traits: _traits,
    );
  }

  static CourageAspect init() => CourageAspect(
        title: "Courage",
        injuries: 0,
        traits: [
          Trait(id: "accuracy", title: "Accuracy"),
          Trait(id: "stamina", title: "Stamina"),
          Trait(id: "nature", title: "Nature"),
          Trait(id: "agility", title: "Agility"),
          Trait(id: "command", title: "Command"),
          Trait(id: "insight", title: "Insight"),
          Trait(id: "guile", title: "Guile"),
          Trait(id: "cooking", title: "Cooking"),
        ],
      );
}

abstract class Aspect {
  final String title;
  final int injuries;
  final List<Trait> traits;
  final Color color;

  const Aspect({
    required this.title,
    this.injuries = 0,
    required this.traits,
    this.color = Colors.white,
  });

  int get tokenPriceTotal => traits.fold(0, (acc, e) => acc + e.tokenPrice);
}

class Trait {
  final String id;
  final String title;

  final int value;
  final int equipmentBonus;
  final int otherBonus;

  int get totalBonus => equipmentBonus + otherBonus;
  int get totalValue => value + totalBonus;

  static const tokenPricesSumPerValue = [
    0, // Trait 0
    0, // Trait 1
    2, // Trait 2
    5, // Trait 3
    9, // Trait 4
    14, // Trait 5
    20, // Trait 6
    27, // Trait 7
    35, // Trait 8
    44, // Trait 9
    54, // Trait 10
  ];

  int get tokenPrice => tokenPricesSumPerValue[value];

  Trait({
    required this.id,
    required this.title,
    this.value = 1,
    this.equipmentBonus = 0,
    this.otherBonus = 0,
  });

  Trait copyWith({
    String? id,
    String? title,
    int? value,
    int? equipmentBonus,
    int? otherBonus,
  }) {
    return Trait(
      id: id ?? this.id,
      title: title ?? this.title,
      value: value ?? this.value,
      equipmentBonus: equipmentBonus ?? this.equipmentBonus,
      otherBonus: otherBonus ?? this.otherBonus,
    );
  }
}
