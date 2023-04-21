import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";

import "../../../domain/entities/traits.dart";
import "../../blocs/traits_cubit.dart";

class TraitsDisplay extends StatefulWidget {
  const TraitsDisplay({
    Key? key,
  }) : super(key: key);

  @override
  State<TraitsDisplay> createState() => _TraitsDisplayState();
}

class _TraitsDisplayState extends State<TraitsDisplay> {
  late final cubit = BlocProvider.of<TraitsCubit>(context);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: BlocBuilder<TraitsCubit, Traits>(
        bloc: cubit,
        builder: (context, state) {
          return Column(
            children: <Widget>[
              Center(
                child: Text(
                  "[TEMP] Total Traits Token Cost: ${state.tokenPriceTotal} (${state.power.tokenPriceTotal}, ${state.wisdom.tokenPriceTotal}, ${state.courage.tokenPriceTotal})",
                ),
              ),
              const SizedBox(height: 8),
              AspectDisplay(aspect: state.power),
              const SizedBox(height: 8),
              AspectDisplay(aspect: state.wisdom),
              const SizedBox(height: 8),
              AspectDisplay(aspect: state.courage),
            ],
          );
        },
      ),
    );
  }
}

class AspectDisplay extends StatefulWidget {
  final Aspect aspect;

  const AspectDisplay({
    Key? key,
    required this.aspect,
  }) : super(key: key);

  @override
  State<AspectDisplay> createState() => _AspectDisplayState();
}

class _AspectDisplayState extends State<AspectDisplay> {
  late final cubit = BlocProvider.of<TraitsCubit>(context);

  Aspect get aspect => widget.aspect;

  void editInjuryValue(Aspect aspect) {
    if (aspect.title == cubit.courage.title) {
      cubit.setCourage(aspect as CourageAspect);
    } else if (aspect.title == cubit.power.title) {
      cubit.setPower(aspect as PowerAspect);
    } else if (aspect.title == cubit.wisdom.title) {
      cubit.setWisdom(aspect as WisdomAspect);
    }
  }

  @override
  Widget build(BuildContext context) {
    final _screen = MediaQuery.of(context).size;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: aspect.color,
        border: Border.all(
          color: HSLColor.fromColor(aspect.color).withLightness(0.4).toColor(),
          width: 4,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.9,
              child: Stack(
                alignment: AlignmentDirectional.centerEnd,
                children: [
                  Center(
                    child: Text(
                      aspect.title,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ),
                  SizedBox(
                    width: 40,
                    height: 40,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.zero,
                      ),
                      onPressed: () => showDialog(
                        context: context,
                        builder: (context) {
                          return InjuryEditorDialog(
                            aspect: aspect,
                            onValueChanged: editInjuryValue,
                          );
                        },
                      ),
                      child: const Icon(Icons.water_drop),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              aspect.injuries == 0
                  ? "No injuries"
                  : "Injuries: ${aspect.injuries}",
              style: Theme.of(context)
                  .textTheme
                  .titleLarge
                  ?.copyWith(fontSize: 14),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                width: _screen.width * 0.40,
                child: Center(
                  child: Text(
                    "Trait",
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
              ),
              SizedBox(
                width: _screen.width * 0.18,
                child: Center(
                  child: Text(
                    "Value",
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
              ),
              SizedBox(
                width: _screen.width * 0.18,
                child: Center(
                  child: Text(
                    "Bonus",
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
              ),
              SizedBox(
                width: _screen.width * 0.18,
                child: Center(
                  child: Text(
                    "Total",
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
              ),
            ],
          ),
          for (Trait trait in aspect.traits) ...[
            TraitDisplay(trait: trait, injuries: aspect.injuries),
            const Divider()
          ],
        ],
      ),
    );
  }
}

class InjuryEditorDialog extends StatefulWidget {
  final Aspect aspect;
  final ValueChanged<Aspect> onValueChanged;

  const InjuryEditorDialog({
    Key? key,
    required this.aspect,
    required this.onValueChanged,
  }) : super(key: key);

  @override
  State<InjuryEditorDialog> createState() => _InjuryEditorDialogState();
}

class _InjuryEditorDialogState extends State<InjuryEditorDialog> {
  Aspect get aspect => widget.aspect;
  ValueChanged<Aspect> get onValueChanged => widget.onValueChanged;

  late int newInjuryValue;

  @override
  void initState() {
    super.initState();
    newInjuryValue = aspect.injuries;
  }

  void changeInjuryValue(int change) {
    int _newInjuryValue = newInjuryValue + change;
    if (_newInjuryValue < 0) {
      _newInjuryValue = 0;
    }
    if (_newInjuryValue > 10) {
      _newInjuryValue = 10;
    }
    setState(() {
      newInjuryValue = _newInjuryValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: SizedBox(
        height: 400,
        width: 400,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Edit ${aspect.title} Injuries",
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: () => changeInjuryValue(-1),
                        child: SizedBox(
                          height: 50,
                          child: Center(
                            child: Text(
                              "-",
                              style:
                                  Theme.of(context).primaryTextTheme.titleLarge,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 70,
                        child: Center(
                          child: Text(
                            newInjuryValue.toString(),
                            style: Theme.of(context).textTheme.headlineSmall,
                          ),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () => changeInjuryValue(1),
                        child: SizedBox(
                          height: 50,
                          child: Center(
                            child: Text(
                              "+",
                              style:
                                  Theme.of(context).primaryTextTheme.titleLarge,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              ElevatedButton(
                onPressed: () {
                  if (aspect.title == "Courage") {
                    onValueChanged(
                      (aspect as CourageAspect)
                          .copyWith(injuries: newInjuryValue),
                    );
                  }
                  if (aspect.title == "Power") {
                    onValueChanged(
                      (aspect as PowerAspect)
                          .copyWith(injuries: newInjuryValue),
                    );
                  }
                  if (aspect.title == "Wisdom") {
                    onValueChanged(
                      (aspect as WisdomAspect)
                          .copyWith(injuries: newInjuryValue),
                    );
                  }
                  Navigator.pop(context);
                },
                child: const Text("Confirm"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TraitDisplay extends StatefulWidget {
  final Trait trait;
  final int injuries;
  const TraitDisplay({
    Key? key,
    required this.trait,
    required this.injuries,
  }) : super(key: key);

  @override
  State<TraitDisplay> createState() => _TraitDisplayState();
}

class _TraitDisplayState extends State<TraitDisplay> {
  late final cubit = BlocProvider.of<TraitsCubit>(context);

  Trait get trait => widget.trait;
  int get injuries => widget.injuries;

  void editValue(Trait newTrait) => cubit.setTrait(newTrait);

  @override
  Widget build(BuildContext context) {
    final _screen = MediaQuery.of(context).size;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        SizedBox(
          width: _screen.width * 0.40,
          child: Center(
            child: Text(
              trait.title,
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
        ),
        SizedBox(
          width: _screen.width * 0.18,
          child: TextButton(
            style: TextButton.styleFrom(
              foregroundColor: Colors.transparent,
            ),
            onPressed: () => showDialog(
              context: context,
              builder: (context) {
                return ValueEditDialog(
                  trait: trait,
                  onValueChanged: editValue,
                );
              },
            ),
            child: Text(
              trait.value.toString(),
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
        ),
        SizedBox(
          width: _screen.width * 0.18,
          child: TextButton(
            style: TextButton.styleFrom(
              foregroundColor: Colors.transparent,
            ),
            onPressed: () => showDialog(
              context: context,
              builder: (context) {
                return BonusValueEditDialog(
                  trait: trait,
                  onValueChanged: editValue,
                );
              },
            ),
            child: Text(
              trait.totalBonus.toString(),
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
        ),
        SizedBox(
          width: _screen.width * 0.18,
          child: TextButton(
            style: TextButton.styleFrom(
              foregroundColor: Colors.transparent,
            ),
            onPressed: () => showDialog(
              context: context,
              builder: (context) {
                return BonusValueEditDialog(
                  trait: trait,
                  onValueChanged: editValue,
                );
              },
            ),
            child: Text(
              (trait.totalValue - injuries >= 0
                      ? trait.totalValue - injuries
                      : 0)
                  .toString(),
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
        ),
      ],
    );
  }
}

class ValueEditDialog extends StatefulWidget {
  final Trait trait;
  final ValueChanged<Trait> onValueChanged;

  const ValueEditDialog({
    Key? key,
    required this.trait,
    required this.onValueChanged,
  }) : super(key: key);

  @override
  State<ValueEditDialog> createState() => _ValueEditDialogState();
}

class _ValueEditDialogState extends State<ValueEditDialog> {
  Trait get trait => widget.trait;
  ValueChanged<Trait> get onValueChanged => widget.onValueChanged;

  late int newValue;

  @override
  void initState() {
    super.initState();
    newValue = trait.value;
  }

  void changeValue(int change) {
    int _newValue = newValue + change;
    if (_newValue < 0) {
      _newValue = 0;
    }
    if (_newValue > 99) {
      _newValue = 99;
    }
    setState(() {
      newValue = _newValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: SizedBox(
        height: 200,
        width: 400,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Edit ${trait.title}",
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              Text(
                "Previous: ${trait.value}",
                style: Theme.of(context).textTheme.titleLarge,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () => changeValue(-1),
                    child: SizedBox(
                      height: 50,
                      child: Center(
                        child: Text(
                          "-",
                          style: Theme.of(context).primaryTextTheme.titleLarge,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 70,
                    child: Center(
                      child: Text(
                        newValue.toString(),
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () => changeValue(1),
                    child: SizedBox(
                      height: 50,
                      child: Center(
                        child: Text(
                          "+",
                          style: Theme.of(context).primaryTextTheme.titleLarge,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                width: 260,
                child: Stack(
                  alignment: AlignmentDirectional.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        onValueChanged(trait.copyWith(value: newValue));
                        Navigator.pop(context);
                      },
                      child: const Text("Confirm"),
                    ),
                    Positioned(
                      left: 180,
                      child: Text(
                        newValue < 11
                            ? "Token Cost: ${Trait.tokenPricesSumPerValue[newValue] - Trait.tokenPricesSumPerValue[trait.value]}"
                            : "",
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class BonusValueEditDialog extends StatefulWidget {
  final Trait trait;
  final ValueChanged<Trait> onValueChanged;

  const BonusValueEditDialog({
    Key? key,
    required this.trait,
    required this.onValueChanged,
  }) : super(key: key);

  @override
  State<BonusValueEditDialog> createState() => _BonusValueEditDialogState();
}

class _BonusValueEditDialogState extends State<BonusValueEditDialog> {
  Trait get trait => widget.trait;
  ValueChanged<Trait> get onValueChanged => widget.onValueChanged;

  late int newEquipmentValue;
  late int newOtherValue;

  @override
  void initState() {
    super.initState();
    newEquipmentValue = trait.equipmentBonus;
    newOtherValue = trait.otherBonus;
  }

  void changeEquipmentValue(int change) {
    int _newEquipmentValue = newEquipmentValue + change;
    if (_newEquipmentValue < -99) {
      _newEquipmentValue = -99;
    }
    if (_newEquipmentValue > 99) {
      _newEquipmentValue = 99;
    }
    setState(() {
      newEquipmentValue = _newEquipmentValue;
    });
  }

  void changeOtherValue(int change) {
    int _newOtherValue = newOtherValue + change;
    if (_newOtherValue < -99) {
      _newOtherValue = -99;
    }
    if (_newOtherValue > 99) {
      _newOtherValue = 99;
    }
    setState(() {
      newOtherValue = _newOtherValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: SizedBox(
        height: 300,
        width: 400,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Edit ${trait.title} Bonus",
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              Text(
                "Previous: ${trait.equipmentBonus} (Equipment), ${trait.otherBonus} (Other)",
                style: Theme.of(context).textTheme.titleLarge,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () => changeEquipmentValue(-1),
                    child: SizedBox(
                      height: 50,
                      child: Center(
                        child: Text(
                          "-",
                          style: Theme.of(context).primaryTextTheme.titleLarge,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 70,
                    child: Center(
                      child: Column(
                        children: [
                          Text(
                            "Equipment",
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                          Text(
                            newEquipmentValue.toString(),
                            style: Theme.of(context).textTheme.headlineSmall,
                          ),
                        ],
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () => changeEquipmentValue(1),
                    child: SizedBox(
                      height: 50,
                      child: Center(
                        child: Text(
                          "+",
                          style: Theme.of(context).primaryTextTheme.titleLarge,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () => changeOtherValue(-1),
                    child: SizedBox(
                      height: 50,
                      child: Center(
                        child: Text(
                          "-",
                          style: Theme.of(context).primaryTextTheme.titleLarge,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 70,
                    child: Center(
                      child: Column(
                        children: [
                          Text(
                            "Other",
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                          Text(
                            newOtherValue.toString(),
                            style: Theme.of(context).textTheme.headlineSmall,
                          ),
                        ],
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () => changeOtherValue(1),
                    child: SizedBox(
                      height: 50,
                      child: Center(
                        child: Text(
                          "+",
                          style: Theme.of(context).primaryTextTheme.titleLarge,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              ElevatedButton(
                onPressed: () {
                  onValueChanged(
                    trait.copyWith(
                      equipmentBonus: newEquipmentValue,
                      otherBonus: newOtherValue,
                    ),
                  );
                  Navigator.pop(context);
                },
                child: const Text("Confirm"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
