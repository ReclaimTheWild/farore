import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";

import "../../domain/entities/resource.dart";

class ResourceCubit extends Cubit<Resource> {
  ResourceCubit(Resource? resource)
      : super(resource ?? Resource(title: "Unknown", color: Colors.black));

  String get title => state.title;
  Color get color => state.color;
  int get current => state.value;
  int get max => state.maxValue;
  int get min => state.minValue;
  int get temp => state.tempValue;

  void set(Resource resource) => emit(resource);

  void setMin(int min) {
    emit(state.copyWith(minValue: min));
  }

  void setMinMinimum(int minMin) {
    emit(state.copyWith(minMin: minMin));
  }

  void setMax(int max) {
    emit(state.copyWith(maxValue: max));
  }

  void setMaxMaximum(int maxMax) {
    emit(state.copyWith(maxMax: maxMax));
  }

  void add(int value) {
    emit(state.copyWith(value: state.value + value));
  }

  void substract(int value) {
    emit(state.copyWith(value: state.value - value));
  }

  void setCurrent(int current) {
    emit(state.copyWith(value: current));
  }

  void setTemporary(int tempValue) {
    emit(state.copyWith(tempValue: tempValue));
  }

  void setBound(int boundValue) {
    final newState = state;
    newState.setBoundValue(boundValue);
    emit(newState.copyWith());
  }

  void setBurnt(int burntValue) {
    final newState = state;
    newState.setBurntValue(burntValue);
    emit(newState.copyWith());
  }

  void setHasTemp({bool hasTemp = false}) {
    emit(state.copyWith(hasTemp: hasTemp));
  }
}
