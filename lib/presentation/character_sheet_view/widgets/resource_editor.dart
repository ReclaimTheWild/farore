import "package:flutter/gestures.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:numberpicker/numberpicker.dart";
import 'package:toggle_switch/toggle_switch.dart';

import "../../../domain/entities/resource.dart";
import '../../../utils/resource_info_icons_icons.dart';
import "../../blocs/resource_cubit.dart";
import "zelda_gauge.dart";
import "zelda_resource_counter.dart";

class ResourceEditor extends StatefulWidget {
  const ResourceEditor({
    Key? key,
  }) : super(key: key);

  @override
  State<ResourceEditor> createState() => _ResourceEditorState();
}

class _ResourceEditorState extends State<ResourceEditor> {
  late final cubit = BlocProvider.of<ResourceCubit>(context);

  void updatePickerValue(int value) {
    cubit.setCurrent(value);
  }

  void updatePickerTempValue(int value) {
    cubit.setTemporary(value);
  }

  void updatePickerBoundValue(int value) {
    cubit.setBound(value);
  }

  void updatePickerBurntValue(int value) {
    cubit.setBurnt(value);
  }

  void editValue(Resource newValue) => cubit.set(newValue);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: BlocBuilder<ResourceCubit, Resource>(
        bloc: cubit,
        builder: (context, state) {
          return Column(
            children: <Widget>[
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                child: Stack(
                  alignment: AlignmentDirectional.centerEnd,
                  children: [
                    Center(
                      child: Text(
                        state.title,
                        style: Theme.of(context).textTheme.headline4?.copyWith(
                              color: state.color,
                              fontWeight: FontWeight.bold,
                            ),
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
                            return ResourceEditorDialog(
                              resource: state,
                              onValueChanged: editValue,
                            );
                          },
                        ),
                        child: const Icon(Icons.edit),
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                children: <Widget>[
                  const Text(""),
                  ScrollConfiguration(
                    behavior: ScrollConfiguration.of(context).copyWith(
                      dragDevices: {
                        PointerDeviceKind.touch,
                        PointerDeviceKind.mouse,
                      },
                    ),
                    child: NumberPicker(
                      itemHeight: 30,
                      minValue: state.minValue,
                      maxValue: state.maxValue,
                      value: state.value,
                      onChanged: updatePickerValue,
                      axis: Axis.horizontal,
                      textStyle: Theme.of(context).textTheme.headline6,
                      selectedTextStyle: Theme.of(context)
                          .textTheme
                          .headline5
                          ?.copyWith(color: state.color),
                    ),
                  ),
                  if (state.hasTemp) ...[
                    const SizedBox(height: 16),
                    ScrollConfiguration(
                      behavior: ScrollConfiguration.of(context).copyWith(
                        dragDevices: {
                          PointerDeviceKind.touch,
                          PointerDeviceKind.mouse,
                        },
                      ),
                      child: NumberPicker(
                        itemHeight: 30,
                        minValue: state.minMin,
                        maxValue: state.maxValue,
                        value: state.tempValue,
                        onChanged: updatePickerTempValue,
                        axis: Axis.horizontal,
                        textStyle: Theme.of(context).textTheme.headline6,
                        selectedTextStyle: Theme.of(context)
                            .textTheme
                            .headline5
                            ?.copyWith(color: Colors.yellow),
                      ),
                    ),
                  ],
                  ResourceInfoRow(
                    min: state.minValue,
                    max: state.maxValue,
                    bound: state.boundValue,
                    burnt: state.burntValue,
                  ),
                  if (state.iconMode == false) ...[
                    const SizedBox(height: 8),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.9,
                      child: ZeldaGauge(
                        max: state.maxValue,
                        value: state.value,
                        tempValue: state.tempValue,
                        mainColor: state.color,
                      ),
                    ),
                  ],
                  if (state.iconMode == true) ...[
                    const SizedBox(height: 8),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.9,
                      child: ZeldaResourceCounter(
                        max: state.maxValue,
                        value: state.value,
                        mainColor: state.color,
                        tempValue: state.tempValue,
                        iconFamily: state.iconFamily,
                      ),
                    ),
                  ],
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}

class ResourceInfoRow extends StatelessWidget {
  final int min;
  final int max;
  final int bound;
  final int burnt;

  const ResourceInfoRow({
    Key? key,
    required this.min,
    required this.max,
    required this.bound,
    required this.burnt,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final allowedWidth = size.width * 0.22;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        Stack(
          alignment: AlignmentDirectional.center,
          children: [
            const Icon(
              Icons.circle_rounded,
              size: 52.0,
              color: Colors.black26,
            ),
            const Icon(
              ResourceInfoIcons.min,
              size: 32.0,
              color: Colors.white,
            ),
            Text(
              min.toString(),
              style: Theme.of(context)
                  .textTheme
                  .headline5
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
          ],
        ),
        Stack(
          alignment: AlignmentDirectional.center,
          children: [
            const Icon(
              Icons.circle_rounded,
              size: 52.0,
              color: Colors.black26,
            ),
            const Icon(
              ResourceInfoIcons.bound,
              size: 32.0,
              color: Colors.white,
            ),
            Text(
              bound.toString(),
              style: Theme.of(context)
                  .textTheme
                  .headline5
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
          ],
        ),
        Stack(
          alignment: AlignmentDirectional.center,
          children: [
            const Icon(
              Icons.circle_rounded,
              size: 52.0,
              color: Colors.black26,
            ),
            const Icon(
              ResourceInfoIcons.burnt,
              size: 32.0,
              color: Colors.white,
            ),
            Text(
              burnt.toString(),
              style: Theme.of(context)
                  .textTheme
                  .headline5
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
          ],
        ),
        Stack(
          alignment: AlignmentDirectional.center,
          children: [
            const Icon(
              Icons.circle_rounded,
              size: 52.0,
              color: Colors.black26,
            ),
            const Icon(
              ResourceInfoIcons.max,
              size: 32.0,
              color: Colors.white,
            ),
            Text(
              max.toString(),
              style: Theme.of(context)
                  .textTheme
                  .headline5
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ],
    );
  }
}

class ResourceEditorDialog extends StatefulWidget {
  final Resource resource;
  final ValueChanged<Resource> onValueChanged;

  const ResourceEditorDialog({
    Key? key,
    required this.resource,
    required this.onValueChanged,
  }) : super(key: key);

  @override
  State<ResourceEditorDialog> createState() => _ResourceEditorDialogState();
}

class _ResourceEditorDialogState extends State<ResourceEditorDialog> {
  Resource get resource => widget.resource;
  ValueChanged<Resource> get onValueChanged => widget.onValueChanged;

  late int newBoundValue;
  late int newBurntValue;
  late bool newHasTemp;
  late bool newIconMode;

  @override
  void initState() {
    super.initState();
    newBoundValue = resource.boundValue;
    newBurntValue = resource.burntValue;
    newHasTemp = resource.hasTemp;
    newIconMode = resource.iconMode;
  }

  void changeBoundValue(int change) {
    int _newBoundValue = newBoundValue + change;
    if (_newBoundValue < resource.minValue) {
      _newBoundValue = resource.minValue;
    }
    if (_newBoundValue > resource.maxValue) {
      _newBoundValue = resource.maxValue;
    }
    setState(() {
      newBoundValue = _newBoundValue;
    });
  }

  void changeBurntValue(int change) {
    int _newBurntValue = newBurntValue + change;
    if (_newBurntValue < resource.minValue) {
      _newBurntValue = resource.minValue;
    }
    if (_newBurntValue > resource.maxValue) {
      _newBurntValue = resource.maxValue;
    }
    setState(() {
      newBurntValue = _newBurntValue;
    });
  }

  // ignore: avoid_positional_boolean_parameters
  void toggleHasTemp(bool value) {
    setState(() {
      newHasTemp = value;
    });
  }

  // ignore: avoid_positional_boolean_parameters
  void toggleIconMode(bool value) {
    setState(() {
      newIconMode = value;
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
                "Edit ${resource.title}",
                style: Theme.of(context).textTheme.headline5,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.7,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Has Temporary:",
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    Switch(value: newHasTemp, onChanged: toggleHasTemp),
                  ],
                ),
              ),
              Column(
                children: [
                  Text(
                    "Display Mode:",
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  const SizedBox(height: 8),
                  ToggleSwitch(
                    initialLabelIndex: newIconMode ? 1 : 0,
                    totalSwitches: 2,
                    minWidth: 100,
                    fontSize: 18,
                    labels: const ['Gauge', 'Icons'],
                    onToggle: (index) {
                      toggleIconMode(index == 1);
                    },
                  ),
                ],
              ),
              Column(
                children: [
                  Text(
                    "Bound ${resource.title}:",
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: () => changeBoundValue(-1),
                        child: SizedBox(
                          height: 50,
                          child: Center(
                            child: Text(
                              "-",
                              style:
                                  Theme.of(context).primaryTextTheme.headline6,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 70,
                        child: Center(
                          child: Text(
                            newBoundValue.toString(),
                            style: Theme.of(context).textTheme.headline5,
                          ),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () => changeBoundValue(1),
                        child: SizedBox(
                          height: 50,
                          child: Center(
                            child: Text(
                              "+",
                              style:
                                  Theme.of(context).primaryTextTheme.headline6,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Column(
                children: [
                  Text(
                    "Burnt ${resource.title}:",
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: () => changeBurntValue(-1),
                        child: SizedBox(
                          height: 50,
                          child: Center(
                            child: Text(
                              "-",
                              style:
                                  Theme.of(context).primaryTextTheme.headline6,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 70,
                        child: Center(
                          child: Text(
                            newBurntValue.toString(),
                            style: Theme.of(context).textTheme.headline5,
                          ),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () => changeBurntValue(1),
                        child: SizedBox(
                          height: 50,
                          child: Center(
                            child: Text(
                              "+",
                              style:
                                  Theme.of(context).primaryTextTheme.headline6,
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
                  resource.setBoundValue(newBoundValue);
                  resource.setBurntValue(newBurntValue);
                  onValueChanged(
                    resource.copyWith(
                      hasTemp: newHasTemp,
                      iconMode: newIconMode,
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
