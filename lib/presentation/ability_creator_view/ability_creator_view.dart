import "package:flutter/material.dart";
import 'package:flutter/services.dart';

import '../../domain/entities/ability.dart';

class AbilityCreatorView extends StatelessWidget {
  static const routeName = '/ability-creator';
  static const altRouteName = '/abilitycreator';

  const AbilityCreatorView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Ability Creator demo"),
      ),
      body: const AbilityCreatorBody(),
    );
  }
}

class AbilityCreatorBody extends StatefulWidget {
  const AbilityCreatorBody({Key? key}) : super(key: key);

  @override
  State<AbilityCreatorBody> createState() => _AbilityCreatorBodyState();
}

class _AbilityCreatorBodyState extends State<AbilityCreatorBody> {
  final _formKey = GlobalKey<FormState>();

  late AbilityType? _type;

  @override
  void initState() {
    super.initState();
//    _type = AbilityType.none;
    _type = null;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: <Widget>[
              const SizedBox(height: 8),
              Text(
                "Ability Creator",
                style: Theme.of(context).textTheme.headline4,
              ),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Ability name is required";
                        }
                        return null;
                      },
                      style: Theme.of(context)
                          .textTheme
                          .bodyText2
                          ?.copyWith(fontSize: 20),
                      maxLength: 128,
                      decoration: const InputDecoration(
                        labelText: "Name",
                        alignLabelWithHint: true,
                      ),
                    ),
                    DropdownButtonFormField<AbilityType>(
                      decoration: const InputDecoration(
                        labelText: "Type",
                        alignLabelWithHint: true,
                      ),
                      style: Theme.of(context)
                          .textTheme
                          .bodyText2
                          ?.copyWith(fontSize: 20),
                      value: _type,
                      onSaved: (value) {
                        setState(() {
                          _type = value as AbilityType;
                        });
                      },
                      onChanged: (value) {
                        setState(() {
                          _type = value as AbilityType;
                        });
                      },
                      items: [
                        DropdownMenuItem(
                          value: AbilityType.feat,
                          child: Text(AbilityType.feat.capitalizedName),
                        ),
                        DropdownMenuItem(
                          value: AbilityType.technique,
                          child: Text(AbilityType.technique.capitalizedName),
                        ),
                        DropdownMenuItem(
                          value: AbilityType.spell,
                          child: Text(AbilityType.spell.capitalizedName),
                        ),
                      ],
                    ),
                    TextFormField(
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Token price is required";
                        }
                        return null;
                      },
                      style: Theme.of(context)
                          .textTheme
                          .bodyText2
                          ?.copyWith(fontSize: 20),
                      maxLength: 2,
                      decoration: const InputDecoration(
                        labelText: "Token Price",
                        alignLabelWithHint: true,
                      ),
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Ability effect is required";
                        }
                        return null;
                      },
                      style: Theme.of(context)
                          .textTheme
                          .bodyText2
                          ?.copyWith(fontSize: 20),
                      maxLines: 5,
                      decoration: const InputDecoration(
                        labelText: "Effect",
                        alignLabelWithHint: true,
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Ability created"),
                            ),
                          );
                        }
                      },
                      child: const Text("Submit"),
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
