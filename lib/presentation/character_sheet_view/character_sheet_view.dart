import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";

import "../../domain/entities/resource.dart";
import "../../utils/icons_finder.dart";
import "../blocs/resource_cubit.dart";
import '../blocs/traits_cubit.dart';
import "widgets/resource_editor.dart";
import 'widgets/traits_display.dart';

class CharacterSheetView extends StatelessWidget {
  static const routeName = '/character-sheet';
  static const altRouteName = '/charasheet';

  const CharacterSheetView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: const Text("Character Sheet demo"),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: <Widget>[
              const SizedBox(height: 16),
              BlocProvider(
                create: (_) => ResourceCubit(
                  Resource(
                    title: "Health",
                    color: Colors.red,
                    iconFamily: IconFamily.zeldaHeart,
                    maxValue: 200,
                    maxMax: 200,
                  ),
                ),
                child: const ResourceEditor(),
              ),
              const SizedBox(height: 16),
              BlocProvider(
                create: (_) => ResourceCubit(
                  Resource(
                    title: "Stamina",
                    color: Colors.green,
                    value: 10,
                    iconFamily: IconFamily.zeldaStamina,
                  ),
                ),
                child: const ResourceEditor(),
              ),
              const SizedBox(height: 16),
              BlocProvider(
                create: (_) => ResourceCubit(
                  Resource(
                    title: "Magic",
                    color: Colors.blue,
                    iconFamily: IconFamily.zeldaMagic,
                  ),
                ),
                child: const ResourceEditor(),
              ),
              const SizedBox(height: 16),
              BlocProvider(
                create: (_) => TraitsCubit(),
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: TraitsDisplay(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
