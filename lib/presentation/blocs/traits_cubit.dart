import "package:flutter_bloc/flutter_bloc.dart";

import "../../domain/entities/traits.dart";

class TraitsCubit extends Cubit<Traits> {
  TraitsCubit([Traits? traits])
      : super(
          traits ??
              Traits(
                power: PowerAspect.init(),
                wisdom: WisdomAspect.init(),
                courage: CourageAspect.init(),
              ),
        );

  String get title => state.title;
  PowerAspect get power => state.power;
  WisdomAspect get wisdom => state.wisdom;
  CourageAspect get courage => state.courage;

  void setTitle(String title) {
    emit(state.copyWith(title: title));
  }

  void setPower(PowerAspect power) {
    emit(state.copyWith(power: power));
  }

  void setWisdom(WisdomAspect wisdom) {
    emit(state.copyWith(wisdom: wisdom));
  }

  void setCourage(CourageAspect courage) {
    emit(state.copyWith(courage: courage));
  }

  void setTrait(Trait trait) {
    final powerIndex = state.power.traits.indexWhere((e) => e.id == trait.id);
    if (powerIndex != -1) {
      emit(state.copyWith(power: state.power.copyWith(trait: trait)));
      return;
    }
    final wisdomIndex = state.wisdom.traits.indexWhere((e) => e.id == trait.id);
    if (wisdomIndex != -1) {
      emit(state.copyWith(wisdom: state.wisdom.copyWith(trait: trait)));
      return;
    }
    final courageIndex =
        state.courage.traits.indexWhere((e) => e.id == trait.id);
    if (courageIndex != -1) {
      emit(state.copyWith(courage: state.courage.copyWith(trait: trait)));
      return;
    }
  }
}
