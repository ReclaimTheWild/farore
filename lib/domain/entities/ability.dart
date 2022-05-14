import 'resource.dart';

enum AbilityType {
  none,
  feat,
  technique,
  spell,
}

extension AbilityTypeName on AbilityType {
  String get capitalizedName {
    switch (this) {
      case AbilityType.none:
        return "";
      case AbilityType.feat:
        return 'Feat';
      case AbilityType.technique:
        return 'Technique';
      case AbilityType.spell:
        return 'Spell';
      default:
        return 'Unknown';
    }
  }
}

enum AbilityActionType {
  none,
  standard,
  minor,
  free,
  reaction,
  move,
}

extension AbilityActionTypeName on AbilityActionType {
  String get capitalizedName {
    switch (this) {
      case AbilityActionType.none:
        return "";
      case AbilityActionType.standard:
        return 'Standard Action';
      case AbilityActionType.minor:
        return 'Minor Action';
      case AbilityActionType.free:
        return 'Free Action';
      case AbilityActionType.reaction:
        return 'Reaction';
      case AbilityActionType.move:
        return 'Move Action';
      default:
        return 'Unknown';
    }
  }
}

class Ability {
  final String title;
  final AbilityType type;
  final int tokenPrice;
  final List<AbilityRequirement>? useRequirements;
  final List<AbilityRequirement>? learnRequirements;
  final String effect;
  final String? special;
  final int? resourcePrice;
  final ResourceType resourceType;
  final ConsumptionType consumptionType;
  final AbilityActionType actionType;
  final String? damageFormula;

  const Ability({
    required this.title,
    this.type = AbilityType.none,
    required this.tokenPrice,
    this.useRequirements,
    this.learnRequirements,
    required this.effect,
    this.special,
    this.damageFormula,
    this.resourcePrice,
    this.resourceType = ResourceType.none,
    this.consumptionType = ConsumptionType.none,
    this.actionType = AbilityActionType.none,
  });

  Map<String, dynamic> toJson() => {
        'title': title,
        'type': type.index,
        'token_price': tokenPrice,
        'use_requirements': useRequirements?.map((e) => e.toJson()).toList(),
        'learn_requirements':
            learnRequirements?.map((e) => e.toJson()).toList(),
        'effect': effect,
        'special': special,
        'damage_formula': damageFormula,
        'resource_price': resourcePrice,
        'resource_type': resourceType.index,
        'consumption_type': consumptionType.index,
        'action_type': actionType.index,
      };

  static List<Ability> fromJsonList(List<dynamic> json) =>
      List<Ability>.from(json.map((e) => Ability.fromJson));

  factory Ability.fromJson(Map<String, dynamic> json) => Ability(
        title: json['title'] as String,
        type: AbilityType.values[json['type'] as int],
        tokenPrice: json['tokenPrice'] as int,
        useRequirements: List<AbilityRequirement>.from(
          (json['requirements'] as List<Map<String, dynamic>>)
              .map((e) => AbilityRequirement.fromJson)
              .toList(),
        ),
        learnRequirements: List<AbilityRequirement>.from(
          (json['learn_requirements'] as List<Map<String, dynamic>>)
              .map((e) => AbilityRequirement.fromJson)
              .toList(),
        ),
        effect: json['effect'] as String,
        special: json['special'] as String?,
        damageFormula: json['damage_formula'] as String?,
        resourcePrice: json['resource_price'] as int?,
        resourceType: ResourceType.values[json['resource_type'] as int],
        consumptionType:
            ConsumptionType.values[json['consumption_type'] as int],
        actionType: AbilityActionType.values[json['action_type'] as int],
      );
}

class AbilityRequirement {
  final String message;
  final String? rank;
  const AbilityRequirement({
    required this.message,
    this.rank,
  });

  String toReadable() => message + (rank != null ? ' ($rank)' : '');

  Map<String, dynamic> toJson() => {
        'message': message,
        'rank': rank,
      };

  factory AbilityRequirement.fromJson(Map<String, dynamic> json) =>
      AbilityRequirement(
        message: json['message'] as String,
        rank: json['rank'] as String?,
      );
}
