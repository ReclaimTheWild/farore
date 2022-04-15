import "package:flutter/gestures.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:numberpicker/numberpicker.dart";

import "../../../domain/entities/resource.dart";
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

  @override
  Widget build(BuildContext context) {
    return Center(
      child: BlocBuilder<ResourceCubit, Resource>(
        bloc: cubit,
        builder: (context, state) {
          return Column(
            children: <Widget>[
              Text(
                state.title,
                style: Theme.of(context).textTheme.headline4?.copyWith(
                      color: state.color,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Text("Min", style: Theme.of(context).textTheme.headline6),
                      const SizedBox(height: 8),
                      Text(state.minValue.toString()),
                    ],
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
                      const SizedBox(height: 16),
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 2,
                        child: ZeldaGauge(
                          max: state.maxValue,
                          value: state.value,
                          tempValue: state.tempValue,
                          mainColor: state.color,
                        ),
                      ),
                      const SizedBox(height: 16),
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 2,
                        child: ZeldaResourceCounter(
                          max: state.maxValue,
                          value: state.value,
                          mainColor: state.color,
                          tempValue: state.tempValue,
                          iconFamily: state.iconFamily,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      Text("Max", style: Theme.of(context).textTheme.headline6),
                      Text(state.maxValue.toString()),
                    ],
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}
