import "package:flutter/material.dart";
import 'package:flutter/services.dart';

import '../../domain/entities/ability.dart';
import '../../domain/entities/resource.dart';

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
  late ResourceType? _resourceType;
  late ConsumptionType? _consumptionType;

  @override
  void initState() {
    super.initState();
    _type = null;
    _resourceType = null;
    _consumptionType = null;
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
                        isDense: true,
                        counter: SizedBox(),
                        alignLabelWithHint: true,
                      ),
                    ),
                    DropdownButtonFormField<AbilityType>(
                      decoration: const InputDecoration(
                        labelText: "Type",
                        isDense: true,
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
                        isDense: true,
                        counter: SizedBox(),
                        alignLabelWithHint: true,
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            style: Theme.of(context)
                                .textTheme
                                .bodyText2
                                ?.copyWith(fontSize: 20),
                            maxLength: 128,
                            decoration: const InputDecoration(
                              labelText: "Learn Requirement",
                              isDense: true,
                              counter: SizedBox(),
                              alignLabelWithHint: true,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        IconButton(
                          onPressed: () {},
                          iconSize: 32,
                          padding: EdgeInsets.zero,
                          icon: const Icon(Icons.add),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            style: Theme.of(context)
                                .textTheme
                                .bodyText2
                                ?.copyWith(fontSize: 20),
                            maxLength: 128,
                            decoration: const InputDecoration(
                              labelText: "Use Requirement",
                              isDense: true,
                              counter: SizedBox(),
                              alignLabelWithHint: true,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        IconButton(
                          onPressed: () {},
                          iconSize: 32,
                          padding: EdgeInsets.zero,
                          icon: const Icon(Icons.add),
                        ),
                      ],
                    ),
                    if (_type == AbilityType.technique ||
                        _type == AbilityType.spell) ...[
                      TextFormField(
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Resource cost is required";
                          }
                          return null;
                        },
                        style: Theme.of(context)
                            .textTheme
                            .bodyText2
                            ?.copyWith(fontSize: 20),
                        decoration: const InputDecoration(
                          labelText: "Resource Cost",
                          isDense: true,
                          alignLabelWithHint: true,
                        ),
                      ),
                      DropdownButtonFormField<ResourceType>(
                        decoration: const InputDecoration(
                          labelText: "Resource Type",
                          isDense: true,
                          alignLabelWithHint: true,
                        ),
                        style: Theme.of(context)
                            .textTheme
                            .bodyText2
                            ?.copyWith(fontSize: 20),
                        value: _resourceType,
                        onSaved: (value) {
                          setState(() {
                            _resourceType = value as ResourceType;
                          });
                        },
                        onChanged: (value) {
                          setState(() {
                            _resourceType = value as ResourceType;
                          });
                        },
                        items: [
                          DropdownMenuItem(
                            value: ResourceType.stamina,
                            child: Text(ResourceType.stamina.capitalizedName),
                          ),
                          DropdownMenuItem(
                            value: ResourceType.magic,
                            child: Text(ResourceType.magic.capitalizedName),
                          ),
                          DropdownMenuItem(
                            value: ResourceType.health,
                            child: Text(ResourceType.health.capitalizedName),
                          ),
                        ],
                      ),
                      DropdownButtonFormField<ConsumptionType>(
                        decoration: const InputDecoration(
                          labelText: "Consumption Type",
                          isDense: true,
                          alignLabelWithHint: true,
                        ),
                        style: Theme.of(context)
                            .textTheme
                            .bodyText2
                            ?.copyWith(fontSize: 20),
                        value: _consumptionType,
                        onSaved: (value) {
                          setState(() {
                            _consumptionType = value as ConsumptionType;
                          });
                        },
                        onChanged: (value) {
                          setState(() {
                            _consumptionType = value as ConsumptionType;
                          });
                        },
                        items: [
                          DropdownMenuItem(
                            value: ConsumptionType.spend,
                            child: Text(ConsumptionType.spend.capitalizedName),
                          ),
                          DropdownMenuItem(
                            value: ConsumptionType.bind,
                            child: Text(ConsumptionType.bind.capitalizedName),
                          ),
                          DropdownMenuItem(
                            value: ConsumptionType.burn,
                            child: Text(ConsumptionType.burn.capitalizedName),
                          ),
                        ],
                      ),
                      TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Damage formula is required";
                          }
                          return null;
                        },
                        style: Theme.of(context)
                            .textTheme
                            .bodyText2
                            ?.copyWith(fontSize: 20),
                        maxLength: 128,
                        decoration: const InputDecoration(
                          labelText: "Damage Formula",
                          isDense: true,
                          alignLabelWithHint: true,
                        ),
                      ),
                    ],
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
                        isDense: true,
                        alignLabelWithHint: true,
                      ),
                    ),
                    TextFormField(
                      style: Theme.of(context)
                          .textTheme
                          .bodyText2
                          ?.copyWith(fontSize: 20),
                      decoration: const InputDecoration(
                        labelText: "Special",
                        isDense: true,
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
