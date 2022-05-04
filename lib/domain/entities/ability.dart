enum AbilityType {
  feat,
  technique,
  spell,
}

extension AbilityTypeName on AbilityType {
  String get capitalizedName {
    switch (this) {
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

class Ability {
  final String id;
  final String title;
  final AbilityType type;
  final int tokenPrice;
  final List<AbilityRequirement>? requirements;
  final List<AbilityRequirement>? learnRequirements;
  final String effect;
  final String? special;

  const Ability({
    required this.id,
    required this.title,
    required this.type,
    required this.tokenPrice,
    this.requirements,
    this.learnRequirements,
    required this.effect,
    this.special,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'type': type.index,
        'tokenPrice': tokenPrice,
        'requirements': requirements?.map((e) => e.toJson()).toList(),
        'learnRequirements': learnRequirements?.map((e) => e.toJson()).toList(),
        'effect': effect,
        'special': special,
      };

  factory Ability.fromJson(Map<String, dynamic> json) => Ability(
        id: json['id'] as String,
        title: json['title'] as String,
        type: AbilityType.values[json['type'] as int],
        tokenPrice: json['tokenPrice'] as int,
        requirements: List<AbilityRequirement>.from(
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
